//
//  HMNetwork.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMNetwork.h"

#define kBaseURLDomain @"youke.feelpoid.com"
#define kAdminURLDomain @"youke.feelpoid.com"

@implementation HMNetwork
#pragma mark Class methods

+ (instancetype) sharedNetwork
{
    static HMNetwork * network = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[self alloc] init];
    });
    
    return network;
}

#pragma mark - Instance Methods

@synthesize reachabilityManager = _reachabilityManager;
@synthesize isOnline = _isOnline;

#pragma mark Life Cycle
- (id)init
{
    if (self = [super init])
    {
        _isOnline = YES;
        
        _reachabilityManager = [AFNetworkReachabilityManager managerForDomain:kBaseURLDomain];
        
        @weakify(self);
        [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            @strongify(self);
            
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWiFi:
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {
                    self.isOnline = YES;
                }
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                {
                    self.isOnline = NO;
                }
                    break;
                    
                default:
                    break;
            }
        }];
        
        [_reachabilityManager startMonitoring];
    }
    
    return self;
}

- (void)dealloc
{
    [_reachabilityManager stopMonitoring];
}


- (NSURL *)baseURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/", kBaseURLDomain]];
}

- (NSURL *)adminURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/", kAdminURLDomain]];
}

@end
