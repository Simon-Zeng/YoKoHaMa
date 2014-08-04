//
//  HMSumFeeView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMSumFeeView.h"

#import "UILabel+AttributedString.h"

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
        self.backgroundColor = [UIColor whiteColor];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 130, 20)];
        self.countLabel.font = [UIFont systemFontOfSize:12.0];
        self.countLabel.text = nil;
        [self addSubview:self.countLabel];
        
        
        self.sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 8, 130, 20)];
        self.sumLabel.font = [UIFont systemFontOfSize:12.0];
        self.sumLabel.text = nil;
        [self addSubview:self.sumLabel];
        
        self.membersCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.countLabel.frame) + 10, 65, 20)];
        self.membersCountLabel.font = [UIFont systemFontOfSize:12.0];
        self.membersCountLabel.text = NSLocalizedString(@"请输入人数: ", nil);
        [self addSubview:self.membersCountLabel];
        
        self.membersCountField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.membersCountLabel.frame), CGRectGetMaxY(self.countLabel.frame) + 10, 30, 20)];
        self.membersCountField.borderStyle = UITextBorderStyleRoundedRect;
        self.membersCountField.keyboardType = UIKeyboardTypeNumberPad;
        self.membersCountField.returnKeyType = UIReturnKeyDone;
//        self.membersCountField.delegate = self;
        [self addSubview:self.membersCountField];
        
        self.calculateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.calculateButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Button-Background"]];
        [self.calculateButton setTitle:NSLocalizedString(@"AA制", nil)
                              forState:UIControlStateNormal];
        self.calculateButton.frame = CGRectMake(CGRectGetMaxX(self.membersCountField.frame) +3,
                                                CGRectGetMaxY(self.countLabel.frame) + 5,
                                                40,
                                                28);
        self.calculateButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.calculateButton];
        
        
        self.averageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.calculateButton.frame) + 10, CGRectGetMaxY(self.countLabel.frame) + 10, frame.size.width - CGRectGetMaxX(self.calculateButton.frame) - 10, 20)];
        self.averageLabel.font = [UIFont systemFontOfSize:12.0];
        self.averageLabel.text = NSLocalizedString(@"人均费用: 0 元", nil);
        [self addSubview:self.averageLabel];
        
        [self updateWithFees:nil];
    }
    return self;
}

- (void)setCalculateAverageCommand:(RACCommand *)calculateAverageCommand
{
    self.calculateButton.rac_command = calculateAverageCommand;
}

- (RACCommand *)calculateAverageCommand
{
    return self.calculateButton.rac_command;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (RACSignal *)memberCountsSignal
{
    return [self.membersCountField.rac_textSignal map:^id(id value) {
        return @([value longLongValue]);
    }];
}

- (void)updateWithFees:(NSArray *)fees
{
    NSInteger count = fees.count;
    NSNumber * total = @([[fees valueForKeyPath:@"@sum.self.cost"] longLongValue]);
    float average = 0;
    
    if (self.membersCountField.text.length > 0)
    {
        NSInteger membersCount = self.membersCountField.text.intValue;
        average = total.longLongValue * 1.0 / membersCount;
    }
    
    self.countLabel.text = [NSString stringWithFormat:NSLocalizedString(@"已添加统计: %ld 项", nil), count];
    self.sumLabel.text = [NSString stringWithFormat:NSLocalizedString(@"合计: %@ 元", nil), total];
    self.averageLabel.text = [NSString stringWithFormat:NSLocalizedString(@"人均费用: %.2f 元", nil), average];
    
    // Attributed string
    [self.countLabel setToAttributeText:[NSString stringWithFormat:@"%ld", (long)count]];
    [self.countLabel color:[UIColor redColor]];
    
    [self.sumLabel setToAttributeText:[NSString stringWithFormat:@"%@", total]];
    [self.sumLabel color:[UIColor redColor]];
    
    [self.averageLabel setToAttributeText:[NSString stringWithFormat:@"%.2f", average]];
    [self.averageLabel color:[UIColor redColor]];
    
    [self.membersCountField resignFirstResponder];
}

@end
