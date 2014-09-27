//
//  HMLauncherView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  初次启动程序时，展示给用户的引导页面
 */
@interface HMLauncherView : UIView
/**
 *  引导页关闭信号
 */
@property (nonatomic, readonly) RACSignal * closeSignal;
/**
 *  @brief 用于初始化引导页视图对象
 *
 *  @param images 引导页需要展示的图片数组. Array of UIImage
 *
 *  @return 引导页视图对象
 */
- (instancetype)initWithLaunchImages:(NSArray *)images;


@end
