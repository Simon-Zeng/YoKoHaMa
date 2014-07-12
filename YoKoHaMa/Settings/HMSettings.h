//
//  HMSettings.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSettings : NSObject

@property (nonatomic, readonly) NSString * documentDirectoryPathString;
@property (nonatomic, readonly) NSURL * documentDirectoryPathURL;

@property (nonatomic, readonly) NSString * applicationDataSupportDirectoryPathString;
@property (nonatomic, readonly) NSURL * applicationDataSupportDirectoryPathURL;

@property (nonatomic, readonly) NSString * tempDirectoryPathString;
@property (nonatomic, readonly) NSURL * tempDirectoryPathURL;


+ (instancetype) sharedSettings;

@end
