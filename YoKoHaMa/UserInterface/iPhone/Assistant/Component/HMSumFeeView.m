//
//  HMSumFeeView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMSumFeeView.h"

@interface HMSumFeeView ()

@property (nonatomic, strong) UILabel * countLabel;
@property (nonatomic, strong) UILabel * sumLabel;

@property (nonatomic, strong) UILabel * membersCountLabel;
@property (nonatomic, strong) UITextField * membersCountField;
@property (nonatomic, strong) UILabel * averageLabel;

@property (nonatomic, strong) UIButton * calculateButton;

@end

@implementation HMSumFeeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 150, 20)];
        self.countLabel.font = [UIFont systemFontOfSize:14.0];
        self.countLabel.text = nil;
        [self addSubview:self.countLabel];
        
        
        self.sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 8, 150, 20)];
        self.sumLabel.font = [UIFont systemFontOfSize:14.0];
        self.sumLabel.text = nil;
        [self addSubview:self.sumLabel];
        
        self.membersCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.countLabel.frame) + 10, 50, 20)];
        self.membersCountLabel.font = [UIFont systemFontOfSize:14.0];
        self.membersCountLabel.text = NSLocalizedString(@"人数: ", nil);
        [self addSubview:self.membersCountLabel];
        
        self.membersCountField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.membersCountLabel.frame), CGRectGetMaxY(self.countLabel.frame) + 5, 45, 31)];
        self.membersCountField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.membersCountField];
        
        self.calculateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.calculateButton.frame = CGRectMake(CGRectGetMaxX(self.membersCountField.frame), CGRectGetMaxY(self.countLabel.frame) + 5, 45, 31);
        self.calculateButton.backgroundColor = [UIColor blueColor];
        [self addSubview:self.calculateButton];
        
        
        self.averageLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, CGRectGetMaxY(self.countLabel.frame) + 10, 150, 20)];
        self.averageLabel.font = [UIFont systemFontOfSize:14.0];
        self.averageLabel.text = NSLocalizedString(@"人均: ", nil);
        [self addSubview:self.averageLabel];
    }
    return self;
}

- (void)setCalculateAverageCommand:(RACCommand *)calculateAverageCommand
{
    self.calculateButton.rac_command = calculateAverageCommand;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)updateWithFees:(NSArray *)fees
{
    NSInteger count = fees.count;
    NSNumber * total = [fees valueForKeyPath:@"@sum.self.cost"];
    
    self.countLabel.text = [NSString stringWithFormat:NSLocalizedString(@"合计: %ld项", nil), count];
    self.sumLabel.text = [NSString stringWithFormat:NSLocalizedString(@"费用: %@", nil), total];
    
    if (self.membersCountField.text.length > 0)
    {
        NSInteger membersCount = self.membersCountField.text.intValue;
        float average = total.longLongValue * 1.0 / membersCount;
        
        self.averageLabel.text = [NSString stringWithFormat:NSLocalizedString(@"人均: %.2f", nil), average];
    }
}

@end
