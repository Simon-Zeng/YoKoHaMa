//
//  HMNetwork.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  HMNetwork configs the base url and network related properties.
 */
@interface HMNetwork : NSObject

/**
 *  @brief The inside reachabilityManager
 */
@property (nonatomic, readonly) AFNetworkReachabilityManager * reachabilityManager;
/**
 *  @brief The base url for the server
 */
@property (nonatomic, readonly) NSURL * baseURL;
/**
 *  @brief The admin url for the server
 */
@property (nonatomic, readonly) NSURL * adminURL;
/**
 *  @brief A boolean value indicate whether the network is ON or OFF
 */
@property (nonatomic, assign) BOOL isOnline;

/**
 *  @brief Singleton method to get a shared instance of HMNetwork
 *
 *  @return shared instance of HMNetwork
 */
+ (instancetype) sharedNetwork;

@end
