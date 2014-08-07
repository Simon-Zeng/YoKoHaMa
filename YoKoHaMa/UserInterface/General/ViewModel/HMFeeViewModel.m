//
//  HMFeeViewModel.m
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import "HMFeeViewModel.h"

#import "HMFee.h"
#import "HMFeeDao.h"
//#import "HMTravel.h"

@interface HMFeeViewModel ()

@property (nonatomic, strong) NSNumber * travelIdentifier;
@property (nonatomic, strong) NSMutableArray * fees;


@property (nonatomic, strong, readwrite) RACSubject * updateContentSignal;

@end

@implementation HMFeeViewModel

- (instancetype)initWithTravelIdentifier:(NSNumber *)tid
{
    if (self = [super init])
    {
        self.travelIdentifier = tid? tid : @0;
        self.fees = [[NSMutableArray alloc] init];
        
        _updateContentSignal = [RACSubject subject];
    }
    
    return self;
}

#pragma mark - Getters/Setters
- (RACCommand *)calculateAverageCommand
{
    @weakify(self);
    RACCommand * command = [[RACCommand alloc] initWithEnabled:[self travelIsValidSignal]
                                                   signalBlock:^RACSignal *(id input) {
                                                       return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                                           @strongify(self);
                                                           // Do calculate
//                                                           NSNumber * sum = [self.fees valueForKeyPath:@"@sum.self.cost"];
//                                                           NSNumber * count = self.travel.membersCount;
//                                                           
//                                                           if (count.longLongValue > 0)
//                                                           {
//                                                               NSNumber * avg = @(sum.longLongValue * 1.0 /count.integerValue);
//                                                               [subscriber sendNext:avg];
//                                                           }
                                                           [subscriber sendNext:self.fees];
                                                           [subscriber sendCompleted];
                                                           
                                                           return [RACDisposable disposableWithBlock:^{
                                                               
                                                           }];
                                                       }];
                                                   }];
    
    return command;
}

#pragma mark - Public Methods
- (void)addFee:(HMFee *)aFee
{
    aFee.travelIdentifier = self.travelIdentifier;
    
    [self.fees addObject:aFee];
    
    [HMFeeDao saveFee:aFee];
    
    [(RACSubject *)_updateContentSignal sendNext:self.fees];
}

- (void)removeFee:(HMFee *)aFee
{
    [self.fees removeObject:aFee];
    
    [HMFeeDao deleteFeeWithIdentifier:aFee.identifier];
    
    [(RACSubject *)_updateContentSignal sendNext:self.fees];
}


- (void)loadSavedFee
{
    NSArray * fees = [HMFeeDao feesWithTravelIdentifier:self.travelIdentifier];
    
    [self.fees addObjectsFromArray:fees];
    
    [(RACSubject *)_updateContentSignal sendNext:self.fees];
}

- (RACSignal *)travelIsValidSignal
{
    RACSignal * signal = [RACObserve(self, membersCount) map:^id(id value) {
        if (value && [value longLongValue] > 0)
        {
            return @(YES);
        }
        else
        {
            return @(NO);
        }
    }];
    
    return signal;
}

#pragma mark -
- (NSInteger)numberOfFees
{
    return self.fees.count;
}

- (HMFee *)feeAtIndexPath:(NSIndexPath *)indexPath
{
    HMFee * aFee = nil;
    
    if (indexPath.row < self.fees.count)
    {
        aFee = [self.fees objectAtIndex:indexPath.row];
    }
    
    return aFee;
}

@end
