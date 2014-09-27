//
//  HMTripStepView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-15.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  出行列表阶段切换视图
 */
@interface HMTripStepView : UIView
/**
 *  出行列表名称
 */
@property (nonatomic, strong) NSString * title;
/**
 *  更改出行列表阶段时，触发该信号。
 */
@property (nonatomic, strong, readonly) RACSignal * changeStepSignal;
/**
 *  @brief 设置出行列表选中阶段
 *
 *  @param index 阶段
 */
- (void)setSelectedIndex:(NSInteger)index;

@end
