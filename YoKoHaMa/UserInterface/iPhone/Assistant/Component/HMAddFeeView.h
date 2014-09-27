//
//  HMAddFeeView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  HMAddFeeView自定义视图，用于添加一条花销统计
 */
@interface HMAddFeeView : UIView
/**
 *  添加花销信号。当用户添加一条花销记录并提交后，触发该信号
 */
@property (nonatomic, strong, readonly) RACSignal * addFeeSignal;

@end
