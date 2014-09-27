//
//  HMTripInputView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-15.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  添加出行准备项视图
 */
@interface HMTripInputView : UIView

/**
 *  添加一个出行准备项时，触发该信号
 */
@property (nonatomic, strong, readonly) RACSignal * addTripItemSignal;
/**
 *  当前视图尺寸改变时，触发该信号
 */
@property (nonatomic, strong, readonly) RACSignal * frameChangedSignal;

//@property (nonatomic, strong) NSString * title;

/**
 *  是否显示
 */
@property (nonatomic, assign) BOOL inputFieldHidden;

@end
