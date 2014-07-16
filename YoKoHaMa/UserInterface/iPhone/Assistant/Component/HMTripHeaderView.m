//
//  HMTripHeaderView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-16.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMTripHeaderView.h"

@interface HMTripHeaderView ()

@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation HMTripHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width-20, frame.size.height)];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        self.titleLabel.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
    
    [self setNeedsLayout];
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
