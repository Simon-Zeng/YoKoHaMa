//
//  HMSettings.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  HMSettings keeps the most common settings consist in the application. And provide convenient methods for developers to access the sandbox file system.
 */
@interface HMSettings : NSObject

/**
 *  @brief The path string of the document directory.
 */
@property (nonatomic, readonly) NSString * documentDirectoryPathString;
/**
 *  @brief The path url of the document directory
 */
@property (nonatomic, readonly) NSURL * documentDirectoryPathURL;

/**
 *  @brief The path string of the place where persistant application data is saved
 */
@property (nonatomic, readonly) NSString * applicationDataSupportDirectoryPathString;
/**
 *  @brief The path url of the place where persistant application data is saved
 */
@property (nonatomic, readonly) NSURL * applicationDataSupportDirectoryPathURL;

/**
 *  @brief Temp directory path string
 */
@property (nonatomic, readonly) NSString * tempDirectoryPathString;
/**
 *  @brief Temp directory path urls
 */
@property (nonatomic, readonly) NSURL * tempDirectoryPathURL;


+ (instancetype) sharedSettings;

@end
