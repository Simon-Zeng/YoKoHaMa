//
//  HMLauncherView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HMLauncherView : UIView

@property (nonatomic, readonly) RACSignal * closeSignal;

- (instancetype)initWithLaunchImages:(NSArray *)images;


@end
