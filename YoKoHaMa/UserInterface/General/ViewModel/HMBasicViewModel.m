//
//  HMBasicViewModel.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMBasicViewModel.h"

#import "UMSocialSnsPlatformManager.h"
#import "UMSocialSnsService.h"

#import "HMHelper.h"

@implementation HMBasicViewModel


- (RACSignal *)shareImage:(UIImage *)image message:(NSString *)message
{
    RACSignal * signal = [RACSignal empty];
    
    [UMSocialSnsService presentSnsIconSheetView:[HMHelper rootNavigationController]
                                         appKey:kUMengAppKey
                                      shareText:message
                                     shareImage:image
                                shareToSnsNames:@[UMShareToSina,UMShareToWechatSession]
                                       delegate:nil];
    
    return signal;
}

- (RACSignal *)shareURLString:(NSString *)string message:(NSString *)message
{
    RACSignal * signal = [RACSignal empty];
    
    [UMSocialSnsService presentSnsIconSheetView:[HMHelper rootNavigationController]
                                         appKey:kUMengAppKey
                                      shareText:message
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToSina,UMShareToWechatSession]
                                       delegate:nil];
    
    return signal;
}

- (void)back
{
    UINavigationController * navController = [HMHelper rootNavigationController];
    [navController popViewControllerAnimated:YES];
}

@end
