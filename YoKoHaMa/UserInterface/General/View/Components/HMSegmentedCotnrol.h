//
//  HMSegmentedCotnrol.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-16.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSegmentedCotnrol : UISegmentedControl

@property (nonatomic, strong) UIColor *offColor;
@property (nonatomic, strong) UIColor *onColor;

-(id)initWithItems:(NSArray *)items
          offColor:(UIColor*)offcolor
           onColor:(UIColor*)oncolor;

@end
