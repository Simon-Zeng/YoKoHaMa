//
//  HMWebViewController.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HMContentCategory)
{
    HMContentCategoryRoute,
    HMContentCategoryEquipment,
    HMContentCategoryAssistant,
    HMContentCategoryMore
};

@interface HMWebViewController : UIViewController

@property (nonatomic, assign) HMContentCategory category;

- (void)loadURL:(NSURL *)url;

@end
