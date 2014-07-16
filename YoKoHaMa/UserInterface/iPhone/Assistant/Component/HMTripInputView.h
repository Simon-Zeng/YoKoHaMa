//
//  HMTripInputView.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-15.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTripInputView : UIView


@property (nonatomic, strong, readonly) RACSignal * addTripItemSignal;

@property (nonatomic, strong, readonly) RACSignal * frameChangedSignal;

//@property (nonatomic, strong) NSString * title;

@property (nonatomic, assign) BOOL inputFieldHidden;

@end
