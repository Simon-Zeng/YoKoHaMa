//
//  HMAddFeeView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMAddFeeView.h"

#import "HMFee.h"

@interface HMAddFeeView ()

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
        // Initialization code
        self.addFeeSignal = [RACSubject subject];
        
        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 50, 20)];
        nameLabel.font = [UIFont systemFontOfSize:14.0];
        nameLabel.text = NSLocalizedString(@"标题: ", nil);
        [self addSubview:nameLabel];
        
        self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), 3, 150, 31)];
        [self addSubview:self.nameField];
        
        UILabel * costLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.nameField.frame)+ 5, 8, 50, 20)];
        costLabel.font = [UIFont systemFontOfSize:14.0];
        costLabel.text = NSLocalizedString(@"费用: ", nil);
        [self addSubview:costLabel];
        
        self.costField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(costLabel.frame), 8, frame.size.width - CGRectGetMaxX(costLabel.frame) - 5, 31)];
        self.costField.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.costField];
        
        UILabel * descLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.nameField.frame) + 10, 50, 20)];
        descLabel.font = [UIFont systemFontOfSize:14.0];
        descLabel.text = NSLocalizedString(@"说明: ", nil);
        [self addSubview:descLabel];
        
        self.descField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(descLabel.frame), CGRectGetMaxY(self.nameField.frame) + 5, frame.size.width - CGRectGetMaxX(descLabel.frame) - 5, 31)];
        [self addSubview:self.descField];
        
        self.addFeeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.addFeeButton.backgroundColor = [UIColor blueColor];
        self.addFeeButton.frame = CGRectMake(20, CGRectGetMaxY(self.descField.frame) + 5, 280, 31);
        [self addSubview:self.addFeeButton];
        
        self.addFeeButton.rac_command = [self addFeeCommand];
    }
    return self;
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
                                                     RACObserve(self, nameField),
                                                     RACObserve(self, costField),
                                                     RACObserve(self, descField)
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
