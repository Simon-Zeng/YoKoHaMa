//
//  HMItemDao.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMItem.h"

@interface HMItemDao : NSObject

+ (NSNumber *)saveItem:(HMItem *)aItem;

+ (HMItem *)itemWithIdentifier:(NSNumber *)identifier;
+ (NSArray *)itemsWithCategoryIdentifier:(NSNumber *)cid;

+ (BOOL)updateItem:(HMItem *)aItem;

+ (BOOL)deleteItemWithIdentifier:(NSNumber *)identifier;
+ (BOOL)deleteItemWithCategoryIdentifier:(NSNumber *)cid;

@end


@interface HMItemCategoryDao : NSObject

+ (NSNumber *)saveItemCategory:(HMItemCategory *)aItemCategory;

+ (HMItemCategory *)itemCategoryWithIdentifier:(NSNumber *)identifier;
+ (NSArray *)itemCategoriesWithTripIdentifier:(NSNumber *)tid;

+ (BOOL)updateItemCategory:(HMItemCategory *)aItemCategory;

+ (BOOL)deleteItemCategoryWithIdentifier:(NSNumber *)identifier;

@end
