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
        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, bounds.size.width - 120, 24)];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        [self.contentView addSubview:self.titleLabel];
        
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 5, bounds.size.width-120, 24)];
        self.descriptionLabel.font = [UIFont systemFontOfSize:12.0];
        self.descriptionLabel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.descriptionLabel];

        self.costLabel = [[UILabel alloc] initWithFrame:CGRectMake(bounds.size.width - 100, 5, 80, 24)];
        self.costLabel.font = [UIFont systemFontOfSize:14.0];
        
        [self.contentView addSubview:self.costLabel];

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
