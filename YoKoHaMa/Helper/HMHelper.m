//
//  HMHelper.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMHelper.h"

#import "HMAppDelegate.h"

@implementation HMHelper

+ (UINavigationController *)rootNavigationController
{
    HMAppDelegate * appDelegate = (HMAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UINavigationController * navController = (UINavigationController *)appDelegate.window.rootViewController;
    
    return navController;
}

@end
