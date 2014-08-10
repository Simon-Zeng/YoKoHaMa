//
//  HMSearchView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-8-10.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMSearchView.h"

@interface HMSearchView ()<UITextFieldDelegate>

@property (nonatomic, strong, readwrite) RACSubject * searchSignal;

@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) UIButton * searchButton;

@end

@implementation HMSearchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _searchSignal = [RACSubject subject];
        
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 4, 290, 31)];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.placeholder = NSLocalizedString(@"请输入搜索的关键字", nil);
        self.textField.returnKeyType = UIReturnKeyDone;
        self.textField.delegate = self;
        [self addSubview:self.textField];
        
        self.searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.searchButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Button-Background"]];
        [self.searchButton setTitle:NSLocalizedString(@"搜   索", nil)
                           forState:UIControlStateNormal];
        [self.searchButton setTitleColor:[UIColor whiteColor]
                                forState:UIControlStateNormal];
        self.searchButton.titleEdgeInsets = UIEdgeInsetsZero;
        self.searchButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.searchButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        self.searchButton.frame = CGRectMake(15, CGRectGetMaxY(self.textField.frame) + 5, 290, 29);
        [self addSubview:self.searchButton];
        
//        // separator
//        UIView * separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.searchButton.frame) + 5, 320, 14)];
//        separatorView.backgroundColor = [UIColor colorWithRed:30/255.0 green:39/255.0 blue:72/255.0 alpha:1.0];
//        
//        [self addSubview:separatorView];
//        [self sendSubviewToBack:separatorView];
        
        self.searchButton.rac_command = [self searchCommand];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    
    return NO;
}


- (RACCommand *)searchCommand
{
    @weakify(self);
    RACCommand * command = [[RACCommand alloc] initWithEnabled:[self isSearchValidSignal]
                                                   signalBlock:^RACSignal *(id input) {
                                                       return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                                           @strongify(self);
                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                               
                                                               [self.textField resignFirstResponder];
                                                           });
                                                           
                                                           NSString * keywords = self.textField.text;
                                                           
                                                           NSString * trimmedName = [keywords stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                                           
                                                           [(RACSubject *)self.searchSignal sendNext:trimmedName];
                                                           
                                                           [subscriber sendCompleted];
                                                           
                                                           return [RACDisposable disposableWithBlock:^{
                                                               
                                                           }];
                                                       }];
                                                   }];
    
    return command;
}

- (RACSignal *)isSearchValidSignal
{
    RACSignal * signal = [RACSignal combineLatest:(@[
                                                     self.textField.rac_textSignal
                                                     ])
                                           reduce:^id(NSString * keywords){
//                                               NSString * trimmedName = [keywords stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//                                               
//                                               if (trimmedName.length > 0)
//                                               {
//                                                   return @(YES);
//                                               }
//                                               else
//                                               {
//                                                   return @(NO);
//                                               }
                                               
                                               return @(YES);
                                           }];
    
    return signal;
}


@end
