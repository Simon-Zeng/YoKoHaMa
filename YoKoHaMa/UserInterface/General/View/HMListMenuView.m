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

@property (nonatomic, strong, readwrite) RACSubject * openSignal;


@end

@implementation HMListMenuView

- (instancetype)initWithTitle:(NSString *)title
                      options:(NSArray *)options
{
    if (self = [super init])
    {
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
        
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
            
            buttonFrame.origin.x += containerWidth - button.bounds.size.width;
            buttonFrame.size.height = containerHeight;
            
            button.frame = buttonFrame;
            
            [self.optionsContainer addSubview:button];
        }
        
        CGRect containerFrame = self.optionsContainer.frame;
        
        containerFrame.size.width = containerWidth;
        
        self.optionsContainer.frame = containerFrame;
        
        RACSubject * signal = [RACSubject subject];
        
        self.openSignal = signal;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    CGRect titleFrame = bounds;
    titleFrame.origin.x += 8.0f;
    titleFrame.size.width -= 8.0f;
    
    self.titleLabel.frame = titleFrame;
    
    
    CGRect optionsFrame = self.optionsContainer.bounds;
    optionsFrame.size.height = bounds.size.height;
    optionsFrame.origin.x = bounds.size.width - CGRectGetWidth(optionsFrame) - 10.0f;
    optionsFrame.origin.y = truncf((bounds.size.height- optionsFrame.size.height)/2);
    
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
                NSString * option = button.accessibilityIdentifier;
                
                if (option) {
                    [(RACSubject *)self.openSignal sendNext:option];
                }
            }
            
            // Must send completed signal to enable button command again.
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
}


#pragma mark -

@end
