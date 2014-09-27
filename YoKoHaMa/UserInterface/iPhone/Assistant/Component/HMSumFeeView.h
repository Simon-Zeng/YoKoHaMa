//
//  HMSumFeeView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  花销统计中，统计人均花销视图
 */
@interface HMSumFeeView : UIView
/**
 *  人数更改信号。当用户更改人数时，触发该信号。
 */
@property (nonatomic, readonly) RACSignal * memberCountsSignal;
/**
 *  计算人均命令。用户点击计算按钮时触发
 */
@property (nonatomic, strong) RACCommand * calculateAverageCommand; // Incoming command

/**
 *  @brief 加载已保存的花销项
 *
 *  @param fees 花销项
 */
- (void)updateWithFees:(NSArray *)fees;

@end
