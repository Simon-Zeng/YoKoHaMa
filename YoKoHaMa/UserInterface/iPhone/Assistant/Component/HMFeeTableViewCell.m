//
//  HMFeeTableViewCell.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMFeeTableViewCell.h"

#import "HMFee.h"

@interface HMFeeTableViewCell ()

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descriptionLabel;
@property (nonatomic, strong) UILabel * costLabel;

@end

@implementation HMFeeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect bounds = self.contentView.bounds;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 3, bounds.size.width - 120, 20)];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.titleLabel];


        self.costLabel = [[UILabel alloc] initWithFrame:CGRectMake(bounds.size.width - 100, 3, 80, 20)];
        self.costLabel.font = [UIFont systemFontOfSize:14.0];
        self.costLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.costLabel.textColor = [UIColor colorWithRed:225.0/255
                                                          green:225.0/255
                                                           blue:225.0/255
                                                          alpha:1.0];

        self.costLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.costLabel];
        
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 20, bounds.size.width-120, 20)];
        self.descriptionLabel.font = [UIFont systemFontOfSize:12.0];
        self.descriptionLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        self.descriptionLabel.textColor = [UIColor colorWithRed:225.0/255
                                                          green:225.0/255
                                                           blue:225.0/255
                                                          alpha:1.0];
        self.descriptionLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.descriptionLabel];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateWithFee:(HMFee *)aFee
{
    self.titleLabel.text = aFee.name;
    self.descriptionLabel.text = aFee.desc;
    self.costLabel.text = [NSString stringWithFormat:NSLocalizedString(@"费用: %@", nil), aFee.cost];
}

@end
