//
//  HMGridMenuViewCell.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMGridMenuViewCell.h"

@interface HMGridMenuViewCell ()

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * backgroundImageView;

@end

@implementation HMGridMenuViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
        
        [self.contentView addSubview:titleLabel];
        
        self.titleLabel = titleLabel;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (![title isEqual:self.titleLabel.text])
    {
        self.titleLabel.text = title;
    }
    
    if ([title isEqual:NSLocalizedString(@"路线搜索", nil)])
    {
        self.backgroundImageView.image = [UIImage imageNamed:@"Button-Search"];
        
        [self addSubview:self.backgroundImageView];
        [self sendSubviewToBack:self.backgroundImageView];
        
        self.titleLabel.textColor = [UIColor colorWithRed:77/255.0 green:82/255.0 blue:131/255.0 alpha:1.0];
    }
    else
    {
        [_backgroundImageView removeFromSuperview];
        self.titleLabel.textColor = [UIColor whiteColor];
    }
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView)
    {
        @synchronized(self)
        {
            if (!_backgroundImageView)
            {
                _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
            }
        }
    }
    
    return _backgroundImageView;
}

@end
