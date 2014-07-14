//
//  HMTripViewModel.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMItem;

@interface HMTripViewModel : NSObject

@property (nonatomic, readonly) RACSignal * updateContentSignal;

- (instancetype)initWithTripIdentifier:(NSNumber *)tid;

- (void)addItem:(HMItem *)aItem;
- (void)removeItem:(HMItem *)aItem;

- (RACSignal *)shareImage:(UIImage *)image;


#pragma mark -
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (HMItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
