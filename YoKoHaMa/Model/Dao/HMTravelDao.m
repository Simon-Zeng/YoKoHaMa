//
//  HMTravelDao.m
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import "HMTravelDao.h"

#import "HMDatabaseQueue.h"

@implementation HMTravelDao

+ (BOOL)saveTravel:(HMTravel *)aTravel
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:@"INSERT OR REPLACE INTO Travels (identifier, name, membersCount, averageCost) VALUES (:identifier, :name, :membersCount, :averageCost)"
          withParameterDictionary:(@{
                                     @"identifier": aTravel.identifier,
                                     @"name": aTravel.name,
                                     @"membersCount": aTravel.membersCount,
                                     @"averageCost": aTravel.averageCost
                                     })];
    }];
    
    return saved;
}

+ (HMTravel *)travelWithIdentifier:(NSNumber *)identifier
{
    __block HMTravel * aTravel = nil;
    
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:@"SELECT * FROM Travels WHERE identifier == :identifier LIMIT 1"
                           withParameterDictionary:(@{
                                                      @"identifier": identifier
                                                      })];
        
        while ([resultSet next])
        {
            aTravel = [[HMTravel alloc] init];
            
            aTravel.identifier = [resultSet objectForColumnName:@"identifier"];
            aTravel.name = [resultSet objectForColumnName:@"name"];
            aTravel.membersCount = [resultSet objectForColumnName:@"membersCount"];
            aTravel.averageCost = [resultSet objectForColumnName:@"averageCost"];
        }
    }];
    
    return aTravel;
}

+ (BOOL)updateTravel:(HMTravel *)aTravel
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"UPDATE Travels SET \n"
                                   @"   name = :name, \n"
                                   @"   membersCount = :membersCount, \n"
                                   @"   averageCost = :averageCost \n"
                                   @"WHERE identifier == :identifier \n")
          withParameterDictionary:(@{
                                     @"identifier": aTravel.identifier,
                                     @"name": aTravel.name,
                                     @"membersCount": aTravel.membersCount,
                                     @"averageCost": aTravel.averageCost
                                     })];
    }];
    
    return saved;
}

+ (BOOL)deleteTravelWithIdentifier:(NSNumber *)identifier
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"DELETE FROM Travels \n"
                                   @"WHERE identifier == :identifier \n")
          withParameterDictionary:(@{
                                     @"identifier": identifier
                                     })];
    }];
    
    return saved;
}

@end
