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
@property (nonatomic, strong, readonly) RACSignal * refreshRoutesSignal;
@property (nonatomic, strong, readonly) RACSignal * refreshRoadsSignal;
@property (nonatomic, strong, readonly) RACSignal * refreshTripsSignal;

- (void)showRoute:(NSNumber *)routeIdentifier;
- (void)showRoad:(NSNumber *)roadIdentifier;

- (void)showDetailForFocus:(HMFocus *)focus;

- (void)showDetailForListCommand:(NSString *)command;

- (void)feeCalculate;

- (void)showTripGuideForTrip:(HMTrip *)aTrip;


@end
