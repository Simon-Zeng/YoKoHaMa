//
//  HMTripViewModel.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMItem;
@class HMTripItem;

@interface HMTripViewModel : NSObject

@property (nonatomic, readonly) RACSignal * updateContentSignal;

- (instancetype)initWithTripIdentifier:(NSNumber *)tid;

- (void)addItem:(HMItem *)aItem;
- (void)removeTripItem:(HMTripItem *)aTripItem;

- (RACSignal *)shareImage:(UIImage *)image;


#pragma mark -
- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (HMTripItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
