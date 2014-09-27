//
//  HMFocusView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMFocus.h"
/**
 *  广告视图对象
 */
@interface HMFocusView : UIView
/**
 *  用户查看广告信号
 */
@property (nonatomic, strong, readonly) RACSignal * openSignal;
/**
 *  用于更新当前广告视图展示内容
 *
 *  @param focus 需要展示的广告
 */
- (void)updateWithFocus:(HMFocus *)focus;

@end
