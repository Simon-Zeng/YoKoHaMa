//
//  HMSumFeeView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSumFeeView : UIView

@property (nonatomic, strong) RACCommand * calculateAverageCommand; // Incoming command

- (void)updateWithFees:(NSArray *)fees;

@end
