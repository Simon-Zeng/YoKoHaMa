//
//  HMTripAddItemTableViewCell.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMItem;
/**
 *  出行列表添加自定义项表格单元
 */
@interface HMTripAddItemTableViewCell : UITableViewCell
/**
 *  @brief 更新出行列表添加自定义项表格内容
 *
 *  @param anItem 出行准备项
 */
- (void)updateWithItem:(HMItem *)anItem;

@end
