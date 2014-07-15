//
//  HMGridContentView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMGridContentView : UIView

@property (nonatomic, strong, readonly) RACSignal * openSignal;

- (void)updateWithEntities:(NSArray *)entities;

@end
