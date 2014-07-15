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

#import "HMNetwork.h"

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

- (RACSignal *)refreshTypesSignalForCID:(NSNumber *)cid
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        RACSignal * signal = [[HMAPI apiCenter] refreshTypesForCategory:cid];
        
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
                        
                        focus.name = [NSString stringWithFormat:@"Item %d", i ];
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
    NSString * baseURLString = [HMNetwork sharedNetwork].baseURL.absoluteString;
    
    NSString * pathComponent = [NSString stringWithFormat:@"/index.php?a=lists&catid=%@&stype=%@", cid, stype];

    NSString * urlString = [baseURLString stringByAppendingPathComponent:pathComponent];
    
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];

}

- (void)showDetailForFocus:(HMFocus *)focus
{
    
    NSString * baseURLString = [HMNetwork sharedNetwork].baseURL.absoluteString;
    
    NSString * pathComponent = [NSString stringWithFormat:@"/index.php?a=shows&catid=1&id=%@", focus.identifier];
    
    NSString * urlString = [baseURLString stringByAppendingPathComponent:pathComponent];
    
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
    else if ([command isEqual:@"花销统计"])
    {
        [self feeCalculate];
    }
}

- (void)showEquipmentGuide
{
    
    NSString * baseURLString = [HMNetwork sharedNetwork].baseURL.absoluteString;
    
    NSString * pathComponent = [NSString stringWithFormat:@"/zbzd.html"];
    
    NSString * urlString = [baseURLString stringByAppendingPathComponent:pathComponent];
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];
}

- (void)showRoadTripGuide
{
    NSString * baseURLString = [HMNetwork sharedNetwork].baseURL.absoluteString;
    
    NSString * pathComponent = [NSString stringWithFormat:@"/zjzd.html"];
    
    NSString * urlString = [baseURLString stringByAppendingPathComponent:pathComponent];
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];
}

- (void)showRoadTripHelp
{
    NSString * baseURLString = [HMNetwork sharedNetwork].baseURL.absoluteString;
    
    NSString * pathComponent = [NSString stringWithFormat:@"/zjbz.html"];
    
    NSString * urlString = [baseURLString stringByAppendingPathComponent:pathComponent];
    
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

@end
