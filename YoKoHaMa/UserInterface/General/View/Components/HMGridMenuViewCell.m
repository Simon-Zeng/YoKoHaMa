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
        titleLabel.font = [UIFont boldFlatFontOfSize:18.0f];
        
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
}

@end
