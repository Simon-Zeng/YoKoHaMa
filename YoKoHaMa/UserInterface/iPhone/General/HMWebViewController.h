//
//  HMWebViewController.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HMCommonViewModel.h"
/**
 *  网页展示内容所属类别
 */
typedef NS_ENUM(NSUInteger, HMContentCategory)
{
    /**
     *  展示内容为优路线内容
     */
    HMContentCategoryRoute,
    /**
     *  展示内容为优装备内容
     */
    HMContentCategoryEquipment,
    /**
     *  展示内容为优助手内容
     */
    HMContentCategoryAssistant,
    /**
     *  展示内容为更多
     */
    HMContentCategoryMore
};

/**
 *  网页展示视图控制器
 */
@interface HMWebViewController : UIViewController
/**
 *  通用ViewModel
 */
@property (nonatomic, strong, readonly) HMCommonViewModel * viewModel;
/**
 *  展示内容类别
 */
@property (nonatomic, assign) HMContentCategory category;

/**
 *  展示内容的webview
 */
@property (nonatomic, strong, readonly) UIWebView * webView;

/**
 *  @brief 加载url对应的网页内容
 *
 *  @param url 网页地址
 */
- (void)loadURL:(NSURL *)url;

@end
