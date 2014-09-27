//
//  HMFeeTableViewCell.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMFee;
/**
 *  花销统计表格单元
 */
@interface HMFeeTableViewCell : UITableViewCell
/**
 *  @brief 更新表格内容
 *
 *  @param aFee 花销
 */
- (void)updateWithFee:(HMFee *)aFee;

@end
