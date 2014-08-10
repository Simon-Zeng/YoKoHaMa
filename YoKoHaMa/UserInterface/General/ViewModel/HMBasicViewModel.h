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

@property (nonatomic, strong) NSString * title;

- (RACSignal *)shareImage:(UIImage *)image callbackURLString:(NSString *)urlString message:(NSString *)message;

- (RACSignal *)shareURLString:(NSString *)string callbackURLString:(NSString *)urlString message:(NSString *)message;

- (void)back;

@end
