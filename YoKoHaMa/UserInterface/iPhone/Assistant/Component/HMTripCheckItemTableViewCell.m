//
//  HMTripCheckItemTableViewCell.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMTripCheckItemTableViewCell.h"

#import "HMTripItem.h"

@interface HMTripCheckItemTableViewCell ()

@property (nonatomic, strong) UIImageView * checkImageView;
@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation HMTripCheckItemTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect bounds = self.contentView.bounds;
        // Initialization code
        self.checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CheckButton-Unchecked"]];
        self.checkImageView.frame = CGRectMake(10, 8, 24, 24);
        
        [self.contentView addSubview:self.checkImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 4, bounds.size.width - 40, 32)];
        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        [self.contentView addSubview:self.titleLabel];
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

- (void)updateWithItem:(HMTripItem *)anItem
{
    if ([anItem.state boolValue])
    {
        self.checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CheckButton-Unchecked"]];
    }
    else
    {
        self.checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CheckButton-Checked"]];
    }
    
    self.titleLabel.text = anItem.itemName;
}

@end
