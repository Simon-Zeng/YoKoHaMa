//
//  HMFeeTableViewCell.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMFee;

@interface HMFeeTableViewCell : UITableViewCell

- (void)updateWithFee:(HMFee *)aFee;

@end
