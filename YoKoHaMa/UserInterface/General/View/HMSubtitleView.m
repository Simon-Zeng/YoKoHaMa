//
//  HMSubtitleView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-8-4.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMSubtitleView.h"

@interface HMSubtitleView ()

@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation HMSubtitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        UIView * titleBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        titleBackgroundView.backgroundColor = [UIColor colorWithRed:32.0/255
                                                              green:39.0/255
                                                               blue:72.0/255
                                                              alpha:1.0];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleBackgroundView.bounds.size.width - 20, titleBackgroundView.bounds.size.height)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        
        [titleBackgroundView addSubview:self.titleLabel];
        [self addSubview:titleBackgroundView];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (NSString *)title
{
    return self.titleLabel.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
