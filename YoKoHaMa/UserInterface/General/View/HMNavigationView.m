//
//  HMNavigationView.m
//  YoKoHaMa
//
//  Created by simon.zeng on 7/16/14.
//  Copyright (c) 2014 Conggen. All rights reserved.
//

#import "HMNavigationView.h"

@interface HMNavigationView ()

@property (nonatomic, strong, readwrite) RACSubject * backSignal;
@property (nonatomic, strong, readwrite) RACSubject * shareSignal;

@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * shareButton;


@end

@implementation HMNavigationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavigationBackground"]];
        self.backSignal = [RACSubject subject];
        self.shareSignal = [RACSubject subject];
        
        self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backButton setBackgroundImage:[UIImage imageNamed:@"Button-Back"]
                              forState:UIControlStateNormal];
        [self.backButton sizeToFit];
        self.backButton.frame = CGRectMake(8, 16, 90, 12);
        [self addSubview:self.backButton];
        
        self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shareButton setBackgroundImage:[UIImage imageNamed:@"Button-Share"]
                                    forState:UIControlStateNormal];
        [self.shareButton sizeToFit];
        
        self.shareButton.frame = CGRectMake(frame.size.width - 22 - 10, 16, 22, 12);
        [self addSubview:self.shareButton];
        
        self.backButton.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [(RACSubject *)self.backSignal sendNext:@(YES)];
                
                [subscriber sendCompleted];
                
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
        
        self.shareButton.rac_command = [[RACCommand alloc] initWithEnabled:RACObserve(self, shareButtonEnabled)
                                                               signalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [(RACSubject *)self.shareSignal sendNext:@(YES)];
                
                [subscriber sendCompleted];
                
                return [RACDisposable disposableWithBlock:^{
                    
                }];
            }];
        }];
    }
    return self;
}

- (void)setShareButtonEnabled:(BOOL)shareButtonEnabled
{
    if (_shareButtonEnabled != shareButtonEnabled)
    {
        _shareButtonEnabled = shareButtonEnabled;
    }
    
    if (shareButtonEnabled)
    {
        self.shareButton.hidden = NO;
    }
    else
    {
        self.shareButton.hidden = YES;
    }
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
