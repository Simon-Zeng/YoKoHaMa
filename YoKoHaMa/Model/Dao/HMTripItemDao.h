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

+ (BOOL)saveTripItem:(HMTripItem *)aTripItem;

+ (HMTripItem *)tripItemWithTripIdentifier:(NSNumber *)identifier
                            itemIdentifier:(NSNumber *)itemIdentifier;

+ (NSArray *)tripItemsWithTripIdentifier:(NSNumber *)tripIdentifier;

+ (BOOL)updateTripItem:(HMTripItem *)aTripItem;

+ (BOOL)deleteTripItemWithIdentifier:(NSNumber *)identifier
                      itemIdentifier:(NSNumber *)itemIdentifier;

+ (BOOL)deleteTripItemWithTripIdentifier:(NSNumber *)tripIdentifier;

@end
