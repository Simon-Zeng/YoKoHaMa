//
//  HMDatabaseQueue.m
//  YoKoHaMa
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Conggen. All rights reserved.
//

#import "HMDatabaseQueue.h"

#import "HMHelper.h"
#import "HMSettings.h"

@implementation HMDatabaseQueue

+ (instancetype)sharedDBQueue
{
    static HMDatabaseQueue * sharedQueue = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString * dataSupportPath = [HMSettings sharedSettings].applicationDataSupportDirectoryPathString;
        NSString * projectName = [HMHelper projectName];
        
        sharedQueue = [[HMDatabaseQueue alloc] initWithPath:[dataSupportPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite3",projectName]]];
        
        [sharedQueue initialization];
    });
    
    return sharedQueue;
}


- (void)initialization
{
    [self inDatabase:^(FMDatabase *db) {
        NSError * error = nil;
        
        NSString * tripSQLFilePath = [[NSBundle mainBundle] pathForResource:@"trip" ofType:@"sql"];
        
        NSString * tripSQL = [NSString stringWithContentsOfFile:tripSQLFilePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
        NSAssert(!error, @"Failed to get trip database structure");
        
        
        NSString * feeSQLFilePath = [[NSBundle mainBundle] pathForResource:@"trip" ofType:@"sql"];
        
        NSString * feeSQL = [NSString stringWithContentsOfFile:feeSQLFilePath
                                                       encoding:NSUTF8StringEncoding
                                                          error:&error];
        NSAssert(!error, @"Failed to get fee database structure");

        
        [db executeUpdate:tripSQL];
        [db executeUpdate:feeSQL];
    }];
}

@end
