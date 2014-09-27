//
//  HMSearchView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-8-10.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  优路线搜索视图
 */
@interface HMSearchView : UIView
/**
 *  搜索信号。用户点击搜索后触发
 */
@property (nonatomic, strong, readonly) RACSignal * searchSignal;

@end
