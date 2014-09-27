//
//  HMListMenu.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  条形菜单视图对象
 */
@interface HMListMenuView : UIView
/**
 *  条形菜单中某个菜单项被选中信号
 */
@property (nonatomic, strong, readonly) RACSignal * openSignal;
/**
 *  @brief 初始化条形菜单视图对象
 *
 *  @param title   菜单名称。显示在菜单左方，左对齐方式
 *  @param options 菜单选项，显示在菜单右方，右对齐方式
 *
 *  @return 条形菜单视图对象
 */
- (instancetype)initWithTitle:(NSString *)title
                      options:(NSArray *)options;

@end
