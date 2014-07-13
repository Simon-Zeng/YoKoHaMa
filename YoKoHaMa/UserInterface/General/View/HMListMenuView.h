//
//  HMListMenu.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMListMenuView : UIView

@property (nonatomic, strong, readonly) RACSignal * openSignal;

- (instancetype)initWithTitle:(NSString *)title
                      options:(NSArray *)options;

@end
