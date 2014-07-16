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
        NSString * dataSupportPath = [HMSettings sharedSettings].documentDirectoryPathString;
        NSString * projectName = [HMHelper projectName];
        
        sharedQueue = [[HMDatabaseQueue alloc] initWithPath:[dataSupportPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite3",projectName]]];
        
        [sharedQueue initialization];
    });
    
    return sharedQueue;
}


- (void)initialization
{
    [self inDatabase:^(FMDatabase *db) {

        NSString * tripSQLFilePath = [[NSBundle mainBundle] pathForResource:@"trip" ofType:@"sql"];
        
        NSArray * tripCommands = [self commandsFromFile:tripSQLFilePath];
        
        for (NSString * aCommand in tripCommands)
        {
            [db executeUpdate:aCommand];
        }
        
        NSString * feeSQLFilePath = [[NSBundle mainBundle] pathForResource:@"trip" ofType:@"sql"];
        
        NSArray * feeCommands = [self commandsFromFile:feeSQLFilePath];
        
        for (NSString * aCommand in feeCommands)
        {
            [db executeUpdate:aCommand];
        }
    }];
}

- (NSArray *)commandsFromFile:(NSString *)filePath
{
    NSError * error = nil;
    
    NSString * SQLs = [NSString stringWithContentsOfFile:filePath
                                                encoding:NSUTF8StringEncoding
                                                   error:&error];
    NSAssert(!error, @"Failed to get database structure: %@", filePath);
    
    NSArray * commands = [SQLs componentsSeparatedByString:@"\n\n"];
    
    return commands;
}

@end
