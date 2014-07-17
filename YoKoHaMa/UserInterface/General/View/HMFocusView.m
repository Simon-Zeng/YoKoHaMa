//
//  HMFocusView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMFocusView.h"

#import "HMNetwork.h"
#import "UIImageView+WebCache.h"

@interface HMFocusView ()

@property (nonatomic, strong) UIImageView * focusImageView;
@property (nonatomic, strong) HMFocus * focus;

@property (nonatomic, strong) UITapGestureRecognizer * tapRecognizer;
@property (nonatomic, strong, readwrite) RACSignal * openSignal;

@end

@implementation HMFocusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _focusImageView = [[UIImageView alloc] init];
        _focusImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _focusImageView.image = [UIImage imageNamed:@"Focus-Default"];
        
        [self addSubview:_focusImageView];
        
        
        UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] init];
        tapRecognizer.numberOfTapsRequired = 1;
        tapRecognizer.numberOfTouchesRequired = 1;
        
        [self addGestureRecognizer:tapRecognizer];
        
        self.tapRecognizer = tapRecognizer;
        
        @weakify(self);
        RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            RACDisposable *disposable = [self.tapRecognizer.rac_gestureSignal subscribeNext:^(id x) {
                [subscriber sendNext:self.focus];
            }];
            
            return [RACDisposable disposableWithBlock:^{
                [disposable dispose];
            }];
        }];
        
        self.openSignal = signal;
    }
    return self;
}

- (void)updateWithFocus:(HMFocus *)focus
{
    if (_focus != focus)
    {
        self.focus = focus;
        
        NSURL * baseURL = [HMNetwork sharedNetwork].baseURL;
        
        [self.focusImageView sd_setImageWithURL:[baseURL URLByAppendingPathComponent:focus.imageURLString]
                            placeholderImage:[UIImage imageNamed:@"Focus-Default"]];
    }
}

@end
