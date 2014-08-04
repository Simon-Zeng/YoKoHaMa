//
//  HMTripInputView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-15.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMTripInputView.h"

@interface HMTripInputView ()<UITextFieldDelegate>

@property (nonatomic, strong, readwrite) RACSubject * addTripItemSignal;

@property (nonatomic, strong, readwrite) RACSubject * frameChangedSignal;

@property (nonatomic, strong) RACCommand * addButtonCommand;

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UITextField * nameField;
@property (nonatomic, strong) UIButton * addButton;

@end

@implementation HMTripInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.addTripItemSignal = [RACSubject subject];
        self.frameChangedSignal = [RACSubject subject];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, frame.size.width, 20)];
        self.nameLabel.font = [UIFont systemFontOfSize:13.0];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.text = NSLocalizedString(@"请添加自定义项", nil);
        self.nameLabel.textColor = [UIColor redColor];
        
        [self addSubview:self.nameLabel];
        
        self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 25, 260, 24)];
        self.nameField.borderStyle = UITextBorderStyleRoundedRect;
        self.nameField.returnKeyType = UIReturnKeyDone;
        self.nameField.delegate = self;
        [self addSubview:self.nameField];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addButton setImage:[UIImage imageNamed:@"Button-Add"]
                        forState:UIControlStateNormal];
        self.addButton.frame = CGRectMake(frame.size.width-47, 25, 27, 24);
        [self addSubview:self.addButton];
        
        self.addButton.rac_command = [self addButtonCommand];
    }
    return self;
}

- (void)setInputFieldHidden:(BOOL)inputFieldHidden
{
    self.nameLabel.hidden = inputFieldHidden;
    self.nameField.hidden = inputFieldHidden;
    self.addButton.hidden = inputFieldHidden;
    
    [self updateLayout];
}

- (BOOL)inputFieldHidden
{
    return self.nameField.hidden;
}

- (void)updateLayout
{
    CGRect frame = self.frame;
    
    if (self.inputFieldHidden)
    {
        frame.size.height = 0;
    }
    else
    {
        frame.size.height = CGRectGetMaxY(self.addButton.frame);
    }
    
    self.frame = frame;
    
    [(RACSubject *)self.frameChangedSignal sendNext:NSStringFromCGRect(frame)];
}

- (void)setTitle:(NSString *)title
{
    self.nameLabel.text = title;
}

- (NSString *)title
{
    return self.nameLabel.text;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (RACCommand *)addButtonCommand
{
    @weakify(self);
    
    return [[RACCommand alloc] initWithEnabled:[self isNameValidSignal]
                                   signalBlock:^RACSignal *(id input) {
                                       return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                           @strongify(self);
                                           NSString * name = [self.nameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                           
                                           [(RACSubject *)self.addTripItemSignal sendNext:name];
                                           
                                           [subscriber sendCompleted];
                                           
                                           return [RACDisposable disposableWithBlock:^{
                                               
                                           }];
                                       }];
                                   }];
}

- (RACSignal *)isNameValidSignal
{
    return [RACSignal combineLatest:(@[
                                       self.nameField.rac_textSignal
                                       ])
                             reduce:^id(NSString * name){
                                 NSString * trimmedName = [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                 if (trimmedName.length > 0)
                                 {
                                     return @(YES);
                                 }
                                 else
                                 {
                                     return @(NO);
                                 }
                             }];
}

@end
