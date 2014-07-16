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
        self.backgroundColor = [UIColor whiteColor];
        
        UIView * titleBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)];
        titleBackgroundView.backgroundColor = [UIColor colorWithRed:32.0/255
                                                              green:39.0/255
                                                               blue:72.0/255
                                                              alpha:1.0];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, titleBackgroundView.bounds.size.width - 20, titleBackgroundView.bounds.size.height)];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        
        [titleBackgroundView addSubview:self.titleLabel];
        [self addSubview:titleBackgroundView];
        
        self.segmentedControl = [[UISegmentedControl alloc] initWithItems:(@[
                                                                             NSLocalizedString(@"1, 检查出行列表", nil),
                                                                             NSLocalizedString(@"2, 添加自定义项", nil),
                                                                             NSLocalizedString(@"3, 我的出行列表", nil)
                                                                             ])];
        self.segmentedControl.frame = CGRectMake(0, frame.size.height/2, frame.size.width, frame.size.height/2);
        self.segmentedControl.tintColor = [UIColor whiteColor];
        [self.segmentedControl setTitleTextAttributes:(@{
                                                         NSForegroundColorAttributeName: [UIColor blackColor],
                                                         NSFontAttributeName: [UIFont systemFontOfSize:12]
                                                         })
                                             forState:UIControlStateSelected];
        [self.segmentedControl setTitleTextAttributes:(@{
                                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                                         NSFontAttributeName: [UIFont systemFontOfSize:12]
                                                         })
                                             forState:UIControlStateNormal];
        [self.segmentedControl setBackgroundImage:[UIImage imageNamed:@"Button-Background"]
                                         forState:UIControlStateNormal
                                       barMetrics:UIBarMetricsDefault];
        [self.segmentedControl setBackgroundImage:[UIImage imageNamed:@"Button-Blank"]
                                         forState:UIControlStateSelected
                                       barMetrics:UIBarMetricsDefault];
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

- (void)setSelectedIndex:(NSInteger)index
{
    self.segmentedControl.selectedSegmentIndex = index;
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
