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
#import "HMTripDao.h"

#import "HMRoute.h"
#import "HMRoad.h"

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
            else if ([x isKindOfClass:[NSData class]])
            {
                NSString * xString = [[NSString alloc] initWithBytes:[x bytes]
                                                              length:[x length]
                                                            encoding:NSUTF8StringEncoding];
                
                NSString * responseString = [xString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                
                NSArray * pieces = [responseString componentsSeparatedByString:@","];
                
                
                HMFocus * focus = [[HMFocus alloc] init];
                
                for (NSString * aPair in pieces)
                {
                    NSArray * keyValues = [aPair componentsSeparatedByString:@":"];
                    
                    if (keyValues.count == 2)
                    {
                        NSString * key = keyValues[0];
                        if ([key isEqual:@"id"])
                        {
                            focus.identifier = keyValues[1];
                        }
                        else if ([key isEqual:@"title"])
                        {
                            focus.name = keyValues[1];
                        }
                        else if ([key isEqual:@"image"])
                        {
                            focus.imageURLString = keyValues[1];
                        }
                    }
                }
                
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
- (RACSignal *)refreshRoutesSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSMutableArray * allRoutes = [[NSMutableArray alloc] init];
        
        NSArray * routeNames = @[@"北上广城市周边", @"探险自驾", @"人文之路", @"民俗之路", @"休闲之路"];
        
        for (int i = 0; i < routeNames.count; i++) {
            HMRoute * route = [[HMRoute alloc] init];
            route.identifier = @(i);
            route.name = routeNames[i];
            
            [allRoutes addObject:route];
        }
        
        // Add search
        HMRoute * route = [[HMRoute alloc] init];
        route.identifier = nil;
        route.name = NSLocalizedString(@"搜索", nil);
        [allRoutes addObject:route];
        
        [subscriber sendNext:allRoutes];
        
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (RACSignal *)refreshRoadsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSMutableArray * allRoads = [[NSMutableArray alloc] init];
        
        NSArray * roadNames = @[@"冰雪路面", @"雨水路面", @"高速公路", @"泥泞路面"];
        
        for (int i = 0; i < roadNames.count; i++) {
            HMRoad * road = [[HMRoad alloc] init];
            road.identifier = @(i);
            road.name = roadNames[i];
            
            [allRoads addObject:road];
        }
//        
//        // Add search
//        HMRoad * road = [[HMRoad alloc] init];
//        road.identifier = nil;
//        road.name = NSLocalizedString(@"搜索", nil);
//        [allRoads addObject:road];
        
        [subscriber sendNext:allRoads];
        
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}


- (RACSignal *)refreshTripsSignal
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSArray * allTrips = [HMTripDao allTrips];
        
        [subscriber sendNext:allTrips];
        
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (void)showRoute:(NSNumber *)routeIdentifier
{
    NSString * baseURLString = [HMNetwork sharedNetwork].baseURL.absoluteString;
    
    NSMutableString * pathComponent = [NSMutableString stringWithString:@"/index.php?a=lists&catid=1"];
    if (routeIdentifier)
    {
        [pathComponent appendFormat:@"&stype=%@", routeIdentifier];
    }
    
    NSString * urlString = [baseURLString stringByAppendingPathComponent:pathComponent];
    
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    webViewController.title = NSLocalizedString(@"优路线", nil);
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];

}

- (void)showRoad:(NSNumber *)roadIdentifier
{
    NSString * baseURLString = [HMNetwork sharedNetwork].baseURL.absoluteString;
    
    NSString * pathComponent = [NSString stringWithFormat:@"/index.php?a=lists&catid=32&stype=%@", roadIdentifier];
    
    NSString * urlString = [baseURLString stringByAppendingPathComponent:pathComponent];
    
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    webViewController.title = NSLocalizedString(@"优装备", nil);
    
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
    webViewController.title = NSLocalizedString(@"优装备", nil);
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];
}

- (void)showRoadTripGuide
{
    NSString * baseURLString = [HMNetwork sharedNetwork].baseURL.absoluteString;
    
    NSString * pathComponent = [NSString stringWithFormat:@"/zjzd.html"];
    
    NSString * urlString = [baseURLString stringByAppendingPathComponent:pathComponent];
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    webViewController.title = NSLocalizedString(@"优助手", nil);
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];
}

- (void)showRoadTripHelp
{
    NSString * baseURLString = [HMNetwork sharedNetwork].baseURL.absoluteString;
    
    NSString * pathComponent = [NSString stringWithFormat:@"/zjbz.html"];
    
    NSString * urlString = [baseURLString stringByAppendingPathComponent:pathComponent];
    
    HMWebViewController * webViewController = [[HMWebViewController alloc] init];
    webViewController.title = NSLocalizedString(@"优助手", nil);
    
    [[HMHelper rootNavigationController] pushViewController:webViewController animated:YES];
    
    [webViewController loadURL:[NSURL URLWithString:urlString]];
}


- (void)feeCalculate
{
    HMFeeViewController * feeViewController = [[HMFeeViewController alloc] init];
    feeViewController.title = NSLocalizedString(@"优助手", nil);
    
    [[HMHelper rootNavigationController] pushViewController:feeViewController animated:YES];
}


- (void)showTripGuideForTrip:(HMTrip *)aTrip
{
    HMTripViewModel * viewModel = [[HMTripViewModel alloc] initWithTripIdentifier:aTrip.identifier];
    
    HMTripViewController * tripViewController = [[HMTripViewController alloc] init];
    tripViewController.viewModel = viewModel;
    tripViewController.title = NSLocalizedString(@"优助手", nil);
    
    [[HMHelper rootNavigationController] pushViewController:tripViewController animated:YES];
}

@end
