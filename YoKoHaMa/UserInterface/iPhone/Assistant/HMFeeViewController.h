//
//  HMFeeViewController.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HMViewController.h"

@class HMFeeViewModel;
/**
 *  花销统计视图控制器
 */
@interface HMFeeViewController : HMViewController
/**
 *  花销统计ViewModel
 */
@property (nonatomic, strong, readonly) HMFeeViewModel * viewModel;

@end
