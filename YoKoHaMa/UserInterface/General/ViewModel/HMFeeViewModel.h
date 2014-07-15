//
//  HMFeeViewModel.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMFee.h"
#import "HMBasicViewModel.h"

@interface HMFeeViewModel : HMBasicViewModel

@property (nonatomic, strong) NSNumber * membersCount;
@property (nonatomic, readonly) RACCommand * calculateAverageCommand;
@property (nonatomic, readonly) RACSignal * updateContentSignal;

- (instancetype)initWithTravelIdentifier:(NSNumber *)tid;

- (void)addFee:(HMFee *)aFee;
- (void)removeFee:(HMFee *)aFee;



#pragma mark - 
- (NSInteger)numberOfFees;
- (HMFee *)feeAtIndexPath:(NSIndexPath *)indexPath;

@end
