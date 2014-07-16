//
//  HMTripViewModel.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMBasicViewModel.h"

@class HMItem;
@class HMTripItem;
@class HMTrip;

@interface HMTripViewModel : HMBasicViewModel

@property (nonatomic, strong, readonly) HMTrip * trip;
@property (nonatomic, readonly) RACSignal * updateContentSignal;

- (instancetype)initWithTripIdentifier:(NSNumber *)tid;

- (void)addItem:(HMItem *)aItem;
- (void)removeTripItem:(HMTripItem *)aTripItem;

#pragma mark -
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSString *)titleForSection:(NSInteger)section;
- (HMTripItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
