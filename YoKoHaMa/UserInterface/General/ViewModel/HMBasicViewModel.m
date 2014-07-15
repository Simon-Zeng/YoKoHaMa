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


- (RACSignal *)shareImage:(UIImage *)image
{
    RACSignal * signal = [RACSignal empty];
    
    [UMSocialSnsService presentSnsIconSheetView:[HMHelper rootNavigationController]
                                         appKey:kUMengAppKey
                                      shareText:@""
                                     shareImage:image
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent]
                                       delegate:nil];
    
    return signal;
}

- (RACSignal *)shareURLString:(NSString *)string
{
    RACSignal * signal = [RACSignal empty];
    
    [UMSocialSnsService presentSnsIconSheetView:[HMHelper rootNavigationController]
                                         appKey:kUMengAppKey
                                      shareText:string
                                     shareImage:nil
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent]
                                       delegate:nil];
    
    return signal;
}

- (void)back
{
    UINavigationController * navController = [HMHelper rootNavigationController];
    [navController popViewControllerAnimated:YES];
}

@end
