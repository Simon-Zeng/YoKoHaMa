//
//  HMHelper.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * HMHelper is a class with a collection of all useful methods inside it.
 */
@interface HMHelper : NSObject

/**
 *  @brief Convenient method to get the project name
 *
 *  @return Project name
 */
+ (NSString *)projectName;

/**
 *  @brief Convenient method to get the app display name
 *
 *  @return App display name
 */
+ (NSString *)appDisplayName;

/**
 *  @brief Convenient method to get the root navigation controller of the whole application
 *
 *  @return The topest UINavigationController
 */
+ (UINavigationController *)rootNavigationController;

/**
 *  @brief Convenient method to make a screen shot from the specified view
 *
 *  @param aView The view to make a screen shot
 *
 *  @return The screenshot image
 */
+ (UIImage *)screenShot:(UIView *)aView;

@end
