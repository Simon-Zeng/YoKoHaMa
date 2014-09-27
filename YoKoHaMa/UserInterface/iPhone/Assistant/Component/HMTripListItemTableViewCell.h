//
//  HMTripListItemTableViewCell.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMItem;
/**
 *  出行列表确认阶段表格单元
 */
@interface HMTripListItemTableViewCell : UITableViewCell

/**
 *  @brief 更新表格单元
 *
 *  @param anItem 出行准备项
 */
- (void)updateWithItem:(HMItem *)anItem;

@end
