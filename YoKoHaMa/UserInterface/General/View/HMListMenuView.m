//
//  HMListMenu.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMListMenuView.h"

@interface HMListMenuView ()

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSArray * options;

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView * optionsContainer;

@property (nonatomic, strong) NSString * selectedOption;

@end

@implementation HMListMenuView

- (instancetype)initWithTitle:(NSString *)title
                      options:(NSArray *)options
{
    if (self = [super init])
    {
        self.title = title;
        self.options = options;
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        titleLabel.font = [UIFont flatFontOfSize:16.0];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = title;
        
        [self addSubview:titleLabel];
        
        self.titleLabel = titleLabel;
        
        UIView * containerView = [[UIView alloc] initWithFrame:CGRectZero];
        containerView.backgroundColor = [UIColor clearColor];
        
        [self addSubview:containerView];
        
        self.optionsContainer = containerView;
        
        CGFloat containerWidth = 0.0f;
        CGFloat containerHeight = self.bounds.size.height;
        // Add options.
        for (NSString * anOption in options)
        {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:[NSString stringWithFormat:@"• %@", anOption]
                    forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont flatFontOfSize:12.0];
            button.accessibilityIdentifier = anOption;
            button.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            
            button.rac_command = [self buttonCommand];
            
            [button sizeToFit];
            
            containerWidth += button.bounds.size.width + 5.0f;
            
            CGRect buttonFrame = button.frame;
            
            buttonFrame.origin.x += containerWidth;
            buttonFrame.size.height = containerHeight;
            
            button.frame = buttonFrame;
            
            [self.optionsContainer addSubview:button];
        }
        
        CGRect containerFrame = self.optionsContainer.frame;
        
        containerFrame.size.width = containerWidth;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"The designed initializer is not used");
    
    return nil;
}

- (id)init
{
    NSAssert(NO, @"The designed initializer is not used");
    
    return nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    CGRect titleFrame = bounds;
    titleFrame.origin.x -= 8.0f;
    titleFrame.size.width -= 8.0f;
    
    self.titleLabel.frame = titleFrame;
    
    
    CGRect optionsFrame = bounds;
    optionsFrame.origin.x = bounds.size.width - CGRectGetWidth(optionsFrame);
    
    self.optionsContainer.frame = optionsFrame;
}

- (RACCommand *)buttonCommand
{
    @weakify(self);
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {

        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            if ([input isKindOfClass:[UIButton class]])
            {
                UIButton * button = (UIButton *)input;
                self.selectedOption = button.accessibilityIdentifier;
            }
            
            [subscriber sendNext:self.selectedOption];
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
}


#pragma mark -
- (RACSignal *)openSignal
{
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return [RACObserve(self, selectedOption) subscribeNext:^(id x) {
            [subscriber sendNext:x];
        }];
    }];
    
    return signal;
}

@end
