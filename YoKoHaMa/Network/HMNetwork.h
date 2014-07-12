//
//  HMNetwork.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMNetwork : NSObject

@property (nonatomic, readonly) AFNetworkReachabilityManager * reachabilityManager;
@property (nonatomic, readonly) NSURL * baseURL;
@property (nonatomic, readonly) NSURL * adminURL;

@property (nonatomic, assign) BOOL isOnline;

+ (instancetype) sharedNetwork;

@end
