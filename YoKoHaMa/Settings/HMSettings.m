//
//  HMSettings.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMSettings.h"

@implementation HMSettings

#pragma mark Class methods

+ (instancetype) sharedSettings
{
    static HMSettings * settings = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[self alloc] init];
    });
    
    return settings;
}

#pragma mark - Instance Methods
- (NSString *) documentDirectoryPathString
{
    NSArray * dirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([dirs count])
    {
        return [dirs firstObject];
    }
    else
    {
        return nil;
    }
}

- (NSURL *) documentDirectoryPathURL
{
    NSString * pathString = [self documentDirectoryPathString];
    if (pathString)
    {
        return [NSURL fileURLWithPath:pathString isDirectory:YES];
    }
    else
    {
        return nil;
    }
}

- (NSString *) applicationDataSupportDirectoryPathString
{
    NSArray * dirs = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    if ([dirs count])
    {
        return [dirs firstObject];
    }
    else
    {
        return nil;
    }
    
}

- (NSURL *) applicationDataSupportDirectoryPathURL
{
    NSString * pathString = [self applicationDataSupportDirectoryPathString];
    if (pathString)
    {
        return [NSURL fileURLWithPath:pathString isDirectory:YES];
    }
    else
    {
        return nil;
    }
}

- (NSString *) tempDirectoryPathString
{
    return NSTemporaryDirectory();
}

- (NSURL *) tempDirectoryPathURL
{
    NSString * pathString = [self tempDirectoryPathString];
    if (pathString)
    {
        return [NSURL fileURLWithPath:pathString isDirectory:YES];
    }
    else
    {
        return nil;
    }
}


@end
