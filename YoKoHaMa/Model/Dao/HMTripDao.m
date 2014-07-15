//
//  HMTripDao.m
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import "HMTripDao.h"

#import "HMDatabaseQueue.h"

@implementation HMTripDao

+ (NSNumber *)saveTrip:(HMTrip *)aTrip
{
    __block NSNumber * insertId = nil;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        BOOL saved = [db executeUpdate:@"INSERT OR REPLACE INTO Trips (identifier, name) VALUES (:identifier, :name)"
          withParameterDictionary:(@{
                                     @"identifier": aTrip.identifier,
                                     @"name": aTrip.name
                                     })];
        
        if (saved)
        {
            insertId = @(db.lastInsertRowId);
        }
    }];
    
    return insertId;
}

+ (HMTrip *)tripWithIdentifier:(NSNumber *)identifier
{
    __block HMTrip * aTrip = nil;
    
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:@"SELECT * FROM Trips WHERE identifier == :identifier LIMIT 1"
                           withParameterDictionary:(@{
                                                      @"identifier": identifier
                                                      })];
        
        while ([resultSet next])
        {
            aTrip = [[HMTrip alloc] init];
            
            aTrip.identifier = [resultSet objectForColumnName:@"identifier"];
            aTrip.name = [resultSet objectForColumnName:@"name"];
        }
    }];
    
    return aTrip;
}

+ (BOOL)updateTrip:(HMTrip *)aTrip
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"UPDATE Trips SET \n"
                                   @"   name = :name \n"
                                   @"WHERE identifier == :identifier \n")
          withParameterDictionary:(@{
                                     @"identifier": aTrip.identifier,
                                     @"name": aTrip.name
                                     })];
    }];
    
    return saved;
}

+ (BOOL)deleteTripWithIdentifier:(NSNumber *)identifier
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"DELETE FROM Trips \n"
                                   @"WHERE identifier == :identifier \n")
          withParameterDictionary:(@{
                                     @"identifier": identifier
                                     })];
    }];
    
    return saved;
}

@end
