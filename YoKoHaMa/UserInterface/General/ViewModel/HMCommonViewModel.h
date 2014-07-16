//
//  HMCommonViewModel.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMBasicViewModel.h"

@class HMFocus;
@class HMTrip;

@interface HMCommonViewModel : HMBasicViewModel

@property (nonatomic, strong) NSNumber * catID;

@property (nonatomic, strong, readonly) RACSignal * refreshFocusSignal;
@property (nonatomic, strong, readonly) RACSignal * refreshTripsSignal;

- (RACSignal *)refreshTypesSignalForCID:(NSNumber *)cid;

- (void)showListFor:(NSString *)stype withCatID:(NSNumber *)cid;
- (void)showDetailForFocus:(HMFocus *)focus;

- (void)showDetailForListCommand:(NSString *)command;

- (void)feeCalculate;

- (void)showTripGuideForTrip:(HMTrip *)aTrip;


@end
