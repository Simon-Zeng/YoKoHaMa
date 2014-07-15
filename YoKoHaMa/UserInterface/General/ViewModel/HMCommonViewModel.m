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
#import "HMTrip.h"

#import "HMFeeViewController.h"
#import "HMTripViewController.h"
#import "HMWebViewController.h"

#import "HMTripViewModel.h"

@interface HMCommonViewModel ()

@end

@implementation HMCommonViewModel

- (RACSignal *)refreshFocusSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        RACSignal * signal = [[HMAPI apiCenter] refreshFocusForCategory:@33];
        
        RACDisposable * disposable = [signal subscribeNext:^(id x) {
            if ([x isKindOfClass:[NSDictionary class]])
            {
                HMFocus * focus = [HMFocus focusFromDictionary:x];
                
                [subscriber sendNext:focus];
            }
            else
            {
                [subscriber sendNext:nil];
            }
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [disposable dispose];
        }];
    }];
}

- (RACSignal *)refreshTypesSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        RACSignal * signal = [[HMAPI apiCenter] refreshTypesForCategory:@33];
        
        RACDisposable * disposable = [signal subscribeNext:^(id x) {
            if ([x isKindOfClass:[NSArray class]])
            {
                NSArray * response = (NSArray *)x;
                NSMutableArray * array = [NSMutableArray array];
                
                for (int i=0; i < response.count; i++)
                {
                    HMFocus * focus = [HMFocus focusFromDictionary:[response objectAtIndex:i]];
                    [array addObject:focus];
                }
                
#if DEBUG
                if (array.count == 0)
                {
                    NSInteger numberOfFocuses = arc4random()%6 +1;
                    for (int i = 0; i< numberOfFocuses; i++)
                    {
                        HMFocus * focus = [[HMFocus alloc] init];
                        
                        focus.title = [NSString stringWithFormat:@"Item %d", i ];
                        focus.identifier = @(i);
                        focus.imageURLString = nil;
                        
                        [array addObject:focus];
                    }
                }
#endif
                
                [subscriber sendNext:array];
            }
            else
            {
                [subscriber sendNext:nil];
            }
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        
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
    HMFeeViewController * feeViewController = [[HMFeeViewController alloc] init];
    
    
    [[HMHelper rootNavigationController] pushViewController:feeViewController animated:YES];
}


- (void)showTripGuideForTrip:(HMTrip *)aTrip
{
    
    HMTripViewModel * viewModel = [[HMTripViewModel alloc] initWithTripIdentifier:aTrip.identifier];
    
    HMTripViewController * tripViewController = [[HMTripViewController alloc] init];
    tripViewController.viewModel = viewModel;
    
    [[HMHelper rootNavigationController] pushViewController:tripViewController animated:YES];
}

- (void)shareScreen
{

}

- (void)shareURLString:(NSString *)string
{
    
}



@end
