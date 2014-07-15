//
//  HMTripStepView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-15.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMTripStepView.h"

@interface HMTripStepView ()

@property (nonatomic, strong, readwrite) RACSubject * changeStepSignal;

@property (nonatomic, strong) RACSignal * stepValueSignal;

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UISegmentedControl * segmentedControl;

@end

@implementation HMTripStepView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        self.titleLabel.backgroundColor = [UIColor blackColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        
        [self addSubview:self.titleLabel];
        
        self.segmentedControl = [[UISegmentedControl alloc] initWithItems:(@[
                                                                             NSLocalizedString(@"1, 检查出行列表", nil),
                                                                             NSLocalizedString(@"2, 添加自定义选项", nil),
                                                                             NSLocalizedString(@"1, 我的出行列表", nil)
                                                                             ])];
        self.segmentedControl.tintColor = [UIColor blackColor];
        [self addSubview:self.segmentedControl];
        
        self.changeStepSignal = [RACSubject subject];
        
        self.stepValueSignal = [self.segmentedControl rac_signalForControlEvents:UIControlEventValueChanged];
        
        @weakify(self);
        [self.stepValueSignal subscribeNext:^(id x) {
            @strongify(self);
            NSNumber * selectedIndex = @(self.segmentedControl.selectedSegmentIndex);
            [(RACSubject *)self.changeStepSignal sendNext:selectedIndex];
        }];
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
