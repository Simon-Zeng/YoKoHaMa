//
//  HMItemDao.m
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import "HMItemDao.h"

#import "HMDatabaseQueue.h"

@implementation HMItemDao

+ (NSNumber *)saveItem:(HMItem *)aItem
{
    __block NSNumber * insertId = nil;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        BOOL saved = [db executeUpdate:@"INSERT OR REPLACE INTO Items (identifier, categoryIdentifier, name) VALUES (:identifier, :categoryIdentifier, :name)"
          withParameterDictionary:(@{
                                     @"identifier": aItem.identifier,
                                     @"categoryIdentifier": aItem.categoryIdentifier,
                                     @"name": aItem.name
                                     })];
        
        if (saved)
        {
            insertId = @(db.lastInsertRowId);
        }
    }];
    
    return insertId;
}

+ (HMItem *)itemWithIdentifier:(NSNumber *)identifier
{
    __block HMItem * aItem = nil;
    
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:@"SELECT * FROM Items WHERE identifier == :identifier LIMIT 1"
                           withParameterDictionary:(@{
                                                      @"identifier": identifier
                                                      })];
        
        while ([resultSet next])
        {
            aItem = [[HMItem alloc] init];
            
            aItem.identifier = [resultSet objectForColumnName:@"identifier"];
            aItem.categoryIdentifier = [resultSet objectForColumnName:@"categoryIdentifier"];
            aItem.name = [resultSet objectForColumnName:@"name"];
        }
    }];
    
    return aItem;
}

+ (NSArray *)itemsWithCategoryIdentifier:(NSNumber *)cid
{
    NSMutableArray * items = [NSMutableArray array];
    
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:@"SELECT * FROM Items WHERE categoryIdentifier == :categoryIdentifier"
                           withParameterDictionary:(@{
                                                      @"categoryIdentifier": cid
                                                      })];
        
        while ([resultSet next])
        {
            HMItem * aItem = [[HMItem alloc] init];
            
            aItem.identifier = [resultSet objectForColumnName:@"identifier"];
            aItem.categoryIdentifier = [resultSet objectForColumnName:@"categoryIdentifier"];
            aItem.name = [resultSet objectForColumnName:@"name"];
            
            [items addObject:aItem];
        }
    }];
    
    return items;
}

+ (BOOL)updateItem:(HMItem *)aItem
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"UPDATE Items SET \n"
                                   @"   categoryIdentifier = :categoryIdentifier, \n"
                                   @"   name = :name \n"
                                   @"WHERE identifier == :identifier \n")
          withParameterDictionary:(@{
                                     @"identifier": aItem.identifier,
                                     @"categoryIdentifier": aItem.categoryIdentifier,
                                     @"name": aItem.name
                                     })];
    }];
    
    return saved;
}

+ (BOOL)deleteItemWithIdentifier:(NSNumber *)identifier
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"DELETE FROM Items \n"
                                   @"WHERE identifier == :identifier \n")
          withParameterDictionary:(@{
                                     @"identifier": identifier
                                     })];
    }];
    
    return saved;
}

+ (BOOL)deleteItemWithCategoryIdentifier:(NSNumber *)cid
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"DELETE FROM Items \n"
                                   @"WHERE categoryIdentifier == :categoryIdentifier \n")
          withParameterDictionary:(@{
                                     @"categoryIdentifier": cid
                                     })];
    }];
    
    return saved;
}
@end


@implementation HMItemCategoryDao

+ (NSNumber *)saveItemCategory:(HMItemCategory *)aItemCategory
{
    __block NSNumber * insertId = nil;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        BOOL saved = [db executeUpdate:@"INSERT OR REPLACE INTO ItemCategories (identifier, name) VALUES (:identifier, :name)"
          withParameterDictionary:(@{
                                     @"identifier": aItemCategory.identifier,
                                     @"name": aItemCategory.name
                                     })];
        
        if (saved)
        {
            insertId = @(db.lastInsertRowId);
        }
    }];
    
    return insertId;
}

+ (HMItemCategory *)ItemCategoryWithIdentifier:(NSNumber *)identifier
{
    __block HMItemCategory * aItemCategory = nil;
    
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:@"SELECT * FROM ItemCategories WHERE identifier == :identifier LIMIT 1"
                           withParameterDictionary:(@{
                                                      @"identifier": identifier
                                                      })];
        
        while ([resultSet next])
        {
            aItemCategory = [[HMItemCategory alloc] init];
            
            aItemCategory.identifier = [resultSet objectForColumnName:@"identifier"];
            aItemCategory.name = [resultSet objectForColumnName:@"name"];
        }
    }];
    
    return aItemCategory;
}

+ (BOOL)updateItemCategory:(HMItemCategory *)aItemCategory
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"UPDATE ItemCategories SET \n"
                                   @"   name = :name \n"
                                   @"WHERE identifier == :identifier \n")
          withParameterDictionary:(@{
                                     @"identifier": aItemCategory.identifier,
                                     @"name": aItemCategory.name
                                     })];
    }];
    
    return saved;
}

+ (BOOL)deleteItemCategoryWithIdentifier:(NSNumber *)identifier
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"DELETE FROM ItemCategories \n"
                                   @"WHERE identifier == :identifier \n")
          withParameterDictionary:(@{
                                     @"identifier": identifier
                                     })];
    }];
    
    return saved;
}

@end

