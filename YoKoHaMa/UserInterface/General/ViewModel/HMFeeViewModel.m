//
//  HMFeeViewModel.m
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import "HMFeeViewModel.h"

#import "HMFee.h"
#import "HMTravel.h"

@interface HMFeeViewModel ()

@property (nonatomic, strong) HMTravel * travel;
@property (nonatomic, strong) NSMutableArray * fees;


@property (nonatomic, strong, readwrite) RACSubject * updateContentSignal;

@end

@implementation HMFeeViewModel

- (instancetype)initWithTravelIdentifier:(NSNumber *)tid
{
    if (self = [super init])
    {
        self.travel = nil;
        self.fees = [[NSMutableArray alloc] init];
        
        _updateContentSignal = [RACSubject subject];
    }
    
    return self;
}

#pragma mark - Getters/Setters
- (RACCommand *)calculateAverageCommand
{
    RACCommand * command = [[RACCommand alloc] initWithEnabled:[self travelIsValidSignal]
                                                   signalBlock:^RACSignal *(id input) {
                                                       return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                                           // Do calculate
                                                           NSNumber * sum = [self.fees valueForKeyPath:@"@sum.self.cost"];
                                                           NSNumber * count = self.travel.membersCount;
                                                           
                                                           if (count.longLongValue > 0)
                                                           {
                                                               NSNumber * avg = @(sum.longLongValue * 1.0 /count.integerValue);
                                                               [subscriber sendNext:avg];
                                                           }
                                                           
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
    [self.fees addObject:aFee];
    
    [(RACSubject *)_updateContentSignal sendNext:aFee];
}

- (void)removeFee:(HMFee *)aFee
{
    [self.fees removeObject:aFee];
    
    [(RACSubject *)_updateContentSignal sendNext:aFee];
}

- (RACSignal *)shareImage:(UIImage *)image
{
    RACSignal * signal = [RACSignal empty];
    
    // TODO: Share
    
    return signal;
}

- (RACSignal *)travelIsValidSignal
{
    RACSignal * signal = [[RACObserve(self, membersCount) switchToLatest] map:^id(id value) {
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
