//
//  HMWebViewController.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HMCommonViewModel.h"

typedef NS_ENUM(NSUInteger, HMContentCategory)
{
    HMContentCategoryRoute,
    HMContentCategoryEquipment,
    HMContentCategoryAssistant,
    HMContentCategoryMore
};

@interface HMWebViewController : UIViewController

@property (nonatomic, strong, readonly) HMCommonViewModel * viewModel;
@property (nonatomic, assign) HMContentCategory category;


@property (nonatomic, strong, readonly) UIWebView * webView;


- (void)loadURL:(NSURL *)url;

@end
