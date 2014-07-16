//
//  HMTripItemDao.m
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import "HMTripItemDao.h"

#import "HMDatabaseQueue.h"
#import "HMItem.h"

@implementation HMTripItemDao

+ (NSNumber *)saveTripItem:(HMTripItem *)aTripItem
{
    __block NSNumber * insertId = nil;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        BOOL saved = [db executeUpdate:@"INSERT OR REPLACE INTO TripItems (tripIdentifier, itemIdentifier, itemName, required, state) VALUES (:tripIdentifier, :itemIdentifier, :itemName, :required, :state)"
          withParameterDictionary:(@{
                                     @"tripIdentifier": aTripItem.tripIdentifier,
                                     @"itemIdentifier": aTripItem.itemIdentifier,
                                     @"itemName": aTripItem.itemName,
                                     @"required": aTripItem.required,
                                     @"state": aTripItem.state
                                     })];
        
        if (saved)
        {
            insertId = @(db.lastInsertRowId);
        }
    }];
    
    return insertId;
}

+ (HMTripItem *)tripItemWithTripIdentifier:(NSNumber *)identifier
                            itemIdentifier:(NSNumber *)itemIdentifier
{
    __block HMTripItem * aTripItem = nil;
    
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:@"SELECT * FROM TripItems WHERE tripIdentifier == :tripIdentifier AND itemIdentifier == :itemIdentifier LIMIT 1"
                           withParameterDictionary:(@{
                                                      @"tripIdentifier": identifier,
                                                      @"itemIdentifier": itemIdentifier
                                                      })];
        
        while ([resultSet next])
        {
            aTripItem = [[HMTripItem alloc] init];
            
            aTripItem.tripIdentifier = [resultSet objectForColumnName:@"tripIdentifier"];
            aTripItem.itemIdentifier = [resultSet objectForColumnName:@"itemIdentifier"];
            aTripItem.itemName       = [resultSet objectForColumnName:@"itemName"];
            aTripItem.required = [resultSet objectForColumnName:@"required"];
            aTripItem.state = [resultSet objectForColumnName:@"state"];
        }
    }];
    
    return aTripItem;
}

+ (NSArray *)itemsWithTripIdentifier:(NSNumber *)tripIdentifier
{
    NSMutableArray * tripItems = [NSMutableArray array];
    
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:@"SELECT * FROM Items WHERE identifier IN (SELECT itemIdentifier FROM TripItems WHERE tripIdentifier == :tripIdentifier)"
                           withParameterDictionary:(@{
                                                      @"tripIdentifier": tripIdentifier
                                                      })];
        
        while ([resultSet next])
        {
            HMItem * anItem = [[HMItem alloc] init];
            
            anItem.identifier = [resultSet objectForColumnName:@"identifier"];
            anItem.categoryIdentifier = [resultSet objectForColumnName:@"categoryIdentifier"];
            anItem.name       = [resultSet objectForColumnName:@"name"];
            
            [tripItems addObject:anItem];
        }
    }];
    
    return tripItems;

}

+ (NSArray *)tripItemsWithTripIdentifier:(NSNumber *)tripIdentifier
{
    NSMutableArray * tripItems = [NSMutableArray array];
    
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:@"SELECT * FROM TripItems WHERE tripIdentifier == :tripIdentifier"
                           withParameterDictionary:(@{
                                                      @"tripIdentifier": tripIdentifier
                                                      })];
        
        while ([resultSet next])
        {
            HMTripItem * aTripItem = [[HMTripItem alloc] init];
            
            aTripItem.tripIdentifier = [resultSet objectForColumnName:@"tripIdentifier"];
            aTripItem.itemIdentifier = [resultSet objectForColumnName:@"itemIdentifier"];
            aTripItem.itemName       = [resultSet objectForColumnName:@"itemName"];
            aTripItem.required = [resultSet objectForColumnName:@"required"];
            aTripItem.state = [resultSet objectForColumnName:@"state"];
            
            [tripItems addObject:aTripItem];
        }
    }];
    
    return tripItems;
}

+ (BOOL)updateTripItem:(HMTripItem *)aTripItem
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"UPDATE TripItems SET \n"
                                   @"   itemName = :itemName, \n"
                                   @"   required = :required, \n"
                                   @"   state = :state \n"
                                   @"WHERE tripIdentifier == :tripIdentifier AND itemIdentifier == :itemIdentifier \n")
          withParameterDictionary:(@{
                                     @"tripIdentifier": aTripItem.tripIdentifier,
                                     @"itemIdentifier": aTripItem.itemIdentifier,
                                     @"itemName": aTripItem.itemName,
                                     @"required": aTripItem.required,
                                     @"state": aTripItem.state
                                     })];
    }];
    
    return saved;
}

+ (BOOL)deleteTripItemWithTripIdentifier:(NSNumber *)identifier
                          itemIdentifier:(NSNumber *)itemIdentifier
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"DELETE FROM TripItems \n"
                                   @"WHERE tripIdentifier == :tripIdentifier AND itemIdentifier == :itemIdentifier \n")
          withParameterDictionary:(@{
                                     @"tripIdentifier": identifier,
                                     @"itemIdentifier": itemIdentifier
                                     })];
    }];
    
    return saved;
}

+ (BOOL)deleteTripItemWithTripIdentifier:(NSNumber *)tripIdentifier
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"DELETE FROM TripItems \n"
                                   @"WHERE tripIdentifier == :tripIdentifier \n")
          withParameterDictionary:(@{
                                     @"tripIdentifier": tripIdentifier
                                     })];
    }];
    
    return saved;
}
@end
