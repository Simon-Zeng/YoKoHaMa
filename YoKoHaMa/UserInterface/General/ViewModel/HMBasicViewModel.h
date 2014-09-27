//
//  HMBasicViewModel.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RVMViewModel.h"
/**
 *  ViewModel基类，提供公用的方法
 */
@interface HMBasicViewModel : RVMViewModel
/**
 *  名称，保存当前页面中导航栏所需显示的标题
 */
@property (nonatomic, strong) NSString * title;

/**
 *  @brief 分享一个图片到社交平台。
 *
 *  @param image     分享的图片
 *  @param urlString 用户点击图片后回调地址
 *  @param message   分享的文字
 *
 *  @return 信号量可用于判断分享是否成功，获取错误等
 */
- (RACSignal *)shareImage:(UIImage *)image callbackURLString:(NSString *)urlString message:(NSString *)message;

/**
 *  @brief 分享一个链接到社交平台。
 *
 *  @param string     分享的链接
 *  @param urlString 用户点击图片后回调地址
 *  @param message   分享的文字
 *
 *  @return 信号量可用于判断分享是否成功，获取错误等
 */
- (RACSignal *)shareURLString:(NSString *)string callbackURLString:(NSString *)urlString message:(NSString *)message;

/**
 *  推出当前视图
 */
- (void)back;

@end
