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

typedef NS_ENUM(NSUInteger, TripListMode){
    TripListModeCheck,
    TripListModeAdd,
    TripListModeDone
};

@interface HMTripViewModel : HMBasicViewModel

@property (nonatomic, readonly) HMTrip * trip;
@property (nonatomic, readonly) RACSignal * updateContentSignal;

@property (nonatomic, readonly) RACCommand * saveCommand;
@property (nonatomic, readonly) RACCommand * recheckCommand;

@property (nonatomic, assign) TripListMode listMode;

- (instancetype)initWithTripIdentifier:(NSNumber *)tid;

- (void)addItem:(HMItem *)aItem;
- (void)removeTripItem:(HMTripItem *)aTripItem;

#pragma mark -
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (NSString *)titleForSection:(NSInteger)section;
- (HMTripItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
