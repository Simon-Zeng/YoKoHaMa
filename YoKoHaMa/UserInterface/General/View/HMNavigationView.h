//
//  HMNavigationView.h
//  YoKoHaMa
//
//  Created by simon.zeng on 7/16/14.
//  Copyright (c) 2014 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  自定义导航栏
 */
@interface HMNavigationView : UIView
/**
 *  导航标题
 */
@property (nonatomic, strong) NSString * title;
/**
 *  返回信号，用户点击返回时触发
 */
@property (nonatomic, strong, readonly) RACSignal * backSignal;
/**
 *  分享信号，用户点击分享时触发
 */
@property (nonatomic, strong, readonly) RACSignal * shareSignal;
/**
 *  是否显示分享按钮
 */
@property (nonatomic, assign) BOOL shareButtonEnabled;

@end
