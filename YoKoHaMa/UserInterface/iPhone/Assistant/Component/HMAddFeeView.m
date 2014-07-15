//
//  HMAddFeeView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMAddFeeView.h"

#import "HMFee.h"

@interface HMAddFeeView ()<UITextFieldDelegate>

@property (nonatomic, strong, readwrite) RACSubject * addFeeSignal;

@property (nonatomic, strong) RACCommand * addFeeCommand;

@property (nonatomic, strong) UITextField * nameField;
@property (nonatomic, strong) UITextField * costField;
@property (nonatomic, strong) UITextField * descField;

@property (nonatomic, strong) UIButton * addFeeButton;

@end

@implementation HMAddFeeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // Initialization code
        self.addFeeSignal = [RACSubject subject];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, 290, 20)];
        titleLabel.font = [UIFont systemFontOfSize:12.0];
        titleLabel.text = NSLocalizedString(@"请输入你需要统计的项目", nil);
        [self addSubview:titleLabel];

        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, 35, 20)];
        nameLabel.font = [UIFont systemFontOfSize:12.0];
        nameLabel.text = NSLocalizedString(@"名称: ", nil);
        [self addSubview:nameLabel];
        
        self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), 30, 100, 20)];
        self.nameField.borderStyle = UITextBorderStyleRoundedRect;
        self.nameField.returnKeyType = UIReturnKeyNext;
        self.nameField.delegate = self;
        [self addSubview:self.nameField];
        
        UILabel * costLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 30, 35, 20)];
        costLabel.font = [UIFont systemFontOfSize:12.0];
        costLabel.text = NSLocalizedString(@"费用: ", nil);
        [self addSubview:costLabel];
        
        self.costField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(costLabel.frame), 30, 100, 20)];
        self.costField.borderStyle = UITextBorderStyleRoundedRect;
        self.costField.keyboardType = UIKeyboardTypeNumberPad;
        self.costField.returnKeyType = UIReturnKeyNext;
        self.costField.delegate = self;
        [self addSubview:self.costField];
        
        UILabel * yuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.costField.frame)+5.0f, 30, 20, 20)];
        yuanLabel.font = [UIFont systemFontOfSize:12.0];
        yuanLabel.text = NSLocalizedString(@"元", nil);
        [self addSubview:yuanLabel];
        
        UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.nameField.frame) + 10, 35, 20)];
        descLabel.font = [UIFont systemFontOfSize:12.0];
        descLabel.text = NSLocalizedString(@"备注: ", nil);
        [self addSubview:descLabel];
        
        self.descField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(descLabel.frame), CGRectGetMaxY(self.nameField.frame) + 4, 245, 20)];
        self.descField.borderStyle = UITextBorderStyleRoundedRect;
        self.descField.returnKeyType = UIReturnKeyDone;
        self.descField.delegate = self;
        [self addSubview:self.descField];
        
        self.addFeeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.addFeeButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Button-Background"]];
        [self.addFeeButton setTitle:NSLocalizedString(@"+                 添加计算                 ", nil)
                           forState:UIControlStateNormal];
        [self.addFeeButton setTitleColor:[UIColor whiteColor]
                                forState:UIControlStateNormal];
        self.addFeeButton.titleEdgeInsets = UIEdgeInsetsZero;
        self.addFeeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.addFeeButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        self.addFeeButton.frame = CGRectMake(15, CGRectGetMaxY(self.descField.frame) + 5, 290, 28);
        [self addSubview:self.addFeeButton];
        
        self.addFeeButton.rac_command = [self addFeeCommand];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameField)
    {
        [self.costField becomeFirstResponder];
    }
    else if (textField == self.costField)
    {
        [self.descField becomeFirstResponder];
    }
    else
    {
        [self.descField resignFirstResponder];
    }
    
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

- (RACCommand *)addFeeCommand
{
    @weakify(self);
    RACCommand * command = [[RACCommand alloc] initWithEnabled:[self isFeeValidSignal]
                                                   signalBlock:^RACSignal *(id input) {
                                                       return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                                           @strongify(self);
                                                           HMFee * aFee = [[HMFee alloc] init];
                                                           aFee.identifier = nil;
                                                           aFee.name = self.nameField.text;
                                                           aFee.desc = self.descField.text;
                                                           aFee.cost = @(self.costField.text.longLongValue);
                                                           
                                                           [(RACSubject *)self.addFeeSignal sendNext:aFee];
                                                           
                                                           [subscriber sendCompleted];
                                                           
                                                           return [RACDisposable disposableWithBlock:^{
                                                               
                                                           }];
                                                       }];
                                                   }];
    
    return command;
}

- (RACSignal *)isFeeValidSignal
{
    RACSignal * signal = [RACSignal combineLatest:(@[
                                                     self.nameField.rac_textSignal,
                                                     self.costField.rac_textSignal,
                                                     self.descField.rac_textSignal
                                                     ])
                                           reduce:^id(NSString * name, NSString * cost, NSString * desc){
                                               if (name.length > 0 && cost.length > 0 && desc.length > 0)
                                               {
                                                   return @(YES);
                                               }
                                               else
                                               {
                                                   return @(NO);
                                               }
                                           }];
    
    return signal;
}

@end
