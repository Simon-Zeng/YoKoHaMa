//
//  HMCommonViewModel.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMCommonViewModel.h"

#import "HMAPI.h"
#import "HMFocus.h"
#import "HMHelper.h"
#import "HMWebViewController.h"

@interface HMCommonViewModel ()

@end

@implementation HMCommonViewModel

- (RACSignal *)refreshFocusSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        RACSignal * signal = [[HMAPI apiCenter] refreshFocusForCategory:@33];
        
        RACDisposable * disposable = [signal subscribe:subscriber];
        
        return [RACDisposable disposableWithBlock:^{
            [disposable dispose];
        }];
    }];
}


- (void)showListFor:(NSString *)stype withCatID:(NSNumber *)cid
{
    NSString * urlString = [NSString stringWithFormat:@"http://youke.feelpoid.com/index.php?a=lists&catid=%@&stype=%@", cid, stype];
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];

}

- (void)showDetailForFocus:(HMFocus *)focus
{
    NSString * urlString = [NSString stringWithFormat:@"http://youke.feelpoid.com/index.php?a=shows&catid=1&id=%@", focus.identifier];
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];

}

- (void)showDetailForListCommand:(NSString *)command
{
    if([command isEqualToString:@"装备指导"])
    {
        [self showEquipmentGuide];
    }
    else if([command isEqualToString:@"自驾指导"])
    {
        [self showRoadTripGuide];
    }
    else if([command isEqualToString:@"自驾帮助"])
    {
        [self showRoadTripHelp];
    }

}

- (void)showEquipmentGuide
{
    NSString * urlString = @"http://youke.feelpoid.com/zbzd.html";
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];
}

- (void)showRoadTripGuide
{
    NSString * urlString = @"http://youke.feelpoid.com/zjzd.html";
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];
}

- (void)showRoadTripHelp
{
    NSString * urlString = @"http://youke.feelpoid.com/zjbz.html";
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];
}


- (void)feeCalculate
{
    
}


- (void)shareScreen
{

}

- (void)shareURLString:(NSString *)string
{
    
}



@end
