//
//  HMTripStepView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-15.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTripStepView : UIView

@property (nonatomic, strong) NSString * title;

@property (nonatomic, strong, readonly) RACSignal * changeStepSignal;

@end
