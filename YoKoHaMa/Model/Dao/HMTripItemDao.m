//
//  HMTripItemDao.m
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import "HMTripItemDao.h"

#import "HMDatabaseQueue.h"

@implementation HMTripItemDao

+ (BOOL)saveTripItem:(HMTripItem *)aTripItem
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:@"INSERT OR REPLACE INTO TripItems (tripIdentifier, itemIdentifier, required, state) VALUES (:tripIdentifier, :itemIdentifier, :required, :state)"
          withParameterDictionary:(@{
                                     @"tripIdentifier": aTripItem.tripIdentifier,
                                     @"itemIdentifier": aTripItem.itemIdentifier,
                                     @"required": aTripItem.required,
                                     @"state": aTripItem.state
                                     })];
    }];
    
    return saved;
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
            aTripItem.required = [resultSet objectForColumnName:@"required"];
            aTripItem.state = [resultSet objectForColumnName:@"state"];
        }
    }];
    
    return aTripItem;
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
                                   @"   required = :required, \n"
                                   @"   name = :name, \n"
                                   @"   cost = :cost, \n"
                                   @"   desc = :desc \n"
                                   @"WHERE tripIdentifier == :tripIdentifier AND itemIdentifier == :itemIdentifier \n")
          withParameterDictionary:(@{
                                     @"tripIdentifier": aTripItem.tripIdentifier,
                                     @"itemIdentifier": aTripItem.itemIdentifier,
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
