//
//  HMFocusView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMFocus.h"

@interface HMFocusView : UIView

@property (nonatomic, strong, readonly) RACSignal * openSignal;

- (void)updateWithFocus:(HMFocus *)focus;

@end
