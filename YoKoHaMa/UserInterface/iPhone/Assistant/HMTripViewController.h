//
//  HMTripViewController.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMTripViewModel;
/**
 *  出行列表视图控制器
 */
@interface HMTripViewController : UIViewController
/**
 *  出行列表ViewModel
 */
@property (nonatomic, strong) HMTripViewModel * viewModel;

@end
