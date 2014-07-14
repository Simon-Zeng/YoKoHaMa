//
//  HMFeeDao.m
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import "HMFeeDao.h"

#import "HMDatabaseQueue.h"

@implementation HMFeeDao

+ (BOOL)saveFee:(HMFee *)aFee
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:@"INSERT OR REPLACE INTO Fees (travelIdentifier, name, cost, desc) VALUES (:travelIdentifier, :name, :cost, :desc)"
          withParameterDictionary:(@{
                                     @"travelIdentifier": aFee.travelIdentifier,
                                     @"name": aFee.name,
                                     @"cost": aFee.cost,
                                     @"desc": aFee.desc
                                     })];
    }];
    
    return saved;
}

+ (HMFee *)feeWithIdentifier:(NSNumber *)identifier
{
    __block HMFee * aFee = nil;
    
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:@"SELECT * FROM Fees WHERE identifier == :identifier LIMIT 1"
                           withParameterDictionary:(@{
                                                      @"identifier": identifier
                                                      })];
        
        while ([resultSet next])
        {
            aFee = [[HMFee alloc] init];
            
            aFee.identifier = [resultSet objectForColumnName:@"identifier"];
            aFee.travelIdentifier = [resultSet objectForColumnName:@"travelIdentifier"];
            aFee.name = [resultSet objectForColumnName:@"name"];
            aFee.cost = [resultSet objectForColumnName:@"cost"];
            aFee.desc = [resultSet objectForColumnName:@"desc"];
        }
    }];
    
    return aFee;
}

+ (NSArray *)feesWithTravelIdentifier:(NSNumber *)travelIdentifier
{
    NSMutableArray * fees = [NSMutableArray array];
    
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        FMResultSet * resultSet = [db executeQuery:@"SELECT * FROM Fees WHERE travelIdentifier == :travelIdentifier"
                           withParameterDictionary:(@{
                                                      @"travelIdentifier": travelIdentifier
                                                      })];
        
        while ([resultSet next])
        {
            HMFee * aFee = [[HMFee alloc] init];
            
            aFee.identifier = [resultSet objectForColumnName:@"identifier"];
            aFee.travelIdentifier = [resultSet objectForColumnName:@"travelIdentifier"];
            aFee.name = [resultSet objectForColumnName:@"name"];
            aFee.cost = [resultSet objectForColumnName:@"cost"];
            aFee.desc = [resultSet objectForColumnName:@"desc"];
            
            [fees addObject:aFee];
        }
    }];
    
    return fees;
}

+ (BOOL)updateFee:(HMFee *)aFee
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"UPDATE Fees SET \n"
                                   @"   travelIdentifier = :travelIdentifier, \n"
                                   @"   name = :name, \n"
                                   @"   cost = :cost, \n"
                                   @"   desc = :desc \n"
                                   @"WHERE identifier == :identifier \n")
          withParameterDictionary:(@{
                                     @"identifier": aFee.identifier,
                                     @"travelIdentifier": aFee.travelIdentifier,
                                     @"name": aFee.name,
                                     @"cost": aFee.cost,
                                     @"desc": aFee.desc
                                     })];
    }];
    
    return saved;
}

+ (BOOL)deleteFeeWithIdentifier:(NSNumber *)identifier
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"DELETE FROM Fees \n"
                                   @"WHERE identifier == :identifier \n")
          withParameterDictionary:(@{
                                     @"identifier": identifier
                                     })];
    }];
    
    return saved;
}

+ (BOOL)deleteFeeWithTravelIdentifier:(NSNumber *)travelIdentifier
{
    __block BOOL saved = NO;
    [[HMDatabaseQueue sharedDBQueue] inDatabase:^(FMDatabase *db) {
        saved = [db executeUpdate:(@"DELETE FROM Fees \n"
                                   @"WHERE travelIdentifier == :travelIdentifier \n")
          withParameterDictionary:(@{
                                     @"travelIdentifier": travelIdentifier
                                     })];
    }];
    
    return saved;
}

@end
