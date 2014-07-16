//
//  HMNavigationView.h
//  YoKoHaMa
//
//  Created by simon.zeng on 7/16/14.
//  Copyright (c) 2014 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMNavigationView : UIView

@property (nonatomic, strong, readonly) RACSignal * backSignal;
@property (nonatomic, strong, readonly) RACSignal * shareSignal;

@property (nonatomic, assign) BOOL shareButtonEnabled;

@end
