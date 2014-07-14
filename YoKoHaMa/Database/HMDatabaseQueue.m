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
    });
    
    return sharedQueue;
}


@end
