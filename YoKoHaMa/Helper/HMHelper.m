//
//  HMHelper.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMHelper.h"

#import "HMAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation HMHelper

+ (NSString *)projectName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
}

+ (NSString *)appDisplayName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (UINavigationController *)rootNavigationController
{
    HMAppDelegate * appDelegate = (HMAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UINavigationController * navController = (UINavigationController *)appDelegate.window.rootViewController;
    
    return navController;
}

+ (UIImage *)screenShot:(UIView *)aView
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContextWithOptions(screenRect.size, NO, 0.0);
    
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
