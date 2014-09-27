//
//  HMGridContentView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  九宫格菜单容器对象，用于展示优路线、优装备、有助手中各种选项
 */
@interface HMGridContentView : UIView
/**
 *  菜单中选项被打开时发送的信号
 */
@property (nonatomic, strong, readonly) RACSignal * openSignal;
/**
 *  更新九宫格菜单容器内容
 *
 *  @param entities 菜单内容数组. Array of id<HMEntity>
 */
- (void)updateWithEntities:(NSArray *)entities;

@end
