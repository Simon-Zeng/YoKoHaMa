//
//  HMBasicViewModel.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RVMViewModel.h"

@interface HMBasicViewModel : RVMViewModel

- (RACSignal *)shareImage:(UIImage *)image message:(NSString *)message;

- (RACSignal *)shareURLString:(NSString *)string message:(NSString *)message;

- (void)back;

@end
