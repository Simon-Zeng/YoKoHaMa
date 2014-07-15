//
//  HMHelper.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMHelper : NSObject

+ (NSString *)projectName;
+ (NSString *)appDisplayName;

+ (UINavigationController *)rootNavigationController;

+ (UIImage *)screenShot:(UIView *)aView;

@end
