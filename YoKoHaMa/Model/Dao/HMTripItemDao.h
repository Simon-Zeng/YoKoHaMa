//
//  HMTripItemDao.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMTripItem.h"

@interface HMTripItemDao : NSObject

+ (NSNumber *)saveTripItem:(HMTripItem *)aTripItem;

+ (HMTripItem *)tripItemWithTripIdentifier:(NSNumber *)identifier
                            itemIdentifier:(NSNumber *)itemIdentifier;

+ (NSArray *)itemsWithTripIdentifier:(NSNumber *)tripIdentifier;

+ (NSArray *)tripItemsWithTripIdentifier:(NSNumber *)tripIdentifier;

+ (BOOL)updateTripItem:(HMTripItem *)aTripItem;

+ (BOOL)deleteTripItemWithTripIdentifier:(NSNumber *)identifier
                      itemIdentifier:(NSNumber *)itemIdentifier;

+ (BOOL)deleteTripItemWithTripIdentifier:(NSNumber *)tripIdentifier;

@end
