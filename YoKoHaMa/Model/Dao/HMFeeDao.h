//
//  HMFeeDao.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMFee.h"

@interface HMFeeDao : NSObject

+ (NSNumber *)saveFee:(HMFee *)aFee;

+ (HMFee *)feeWithIdentifier:(NSNumber *)identifier;
+ (NSArray *)feesWithTravelIdentifier:(NSNumber *)travelIdentifier;

+ (BOOL)updateFee:(HMFee *)aFee;

+ (BOOL)deleteFeeWithIdentifier:(NSNumber *)identifier;
+ (BOOL)deleteFeeWithTravelIdentifier:(NSNumber *)travelIdentifier;

@end
