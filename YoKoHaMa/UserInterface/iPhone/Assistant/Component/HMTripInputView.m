//
//  HMTripInputView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-15.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMTripInputView.h"

@interface HMTripInputView ()

@property (nonatomic, strong, readwrite) RACSubject * addTripItemSignal;

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
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width, 20)];
        self.nameLabel.font = [UIFont systemFontOfSize:13.0];
        self.nameLabel.textColor = [UIColor grayColor];
        
        [self addSubview:self.nameLabel];
        
        self.nameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 25, 200, 31)];
        [self addSubview:self.nameField];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addButton setImage:[UIImage imageNamed:@"Button-Add"]
                        forState:UIControlStateNormal];
        [self addSubview:self.addButton];
        
        self.addButton.rac_command = [self addButtonCommand];
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
                                       RACObserve(self.nameField, text)
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
