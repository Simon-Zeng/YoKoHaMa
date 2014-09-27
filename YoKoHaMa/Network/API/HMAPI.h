//
//  HMAPI.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  HMAPI implements all the APIs that comunicate with server side.
 */
@interface HMAPI : NSObject

/**
 *  @brief Singleton method to get an instance of HMAPI. The base url is setted for the instance in init method
 *
 *  @return Shared instance of HMAPI
 */
+ (instancetype) apiCenter;

/**
 *  @brief Request the Ad for the top area.
 *
 *  @param catID Category id for the Ad.
 *
 *  @return A signal that will pipe the url response
 */
- (RACSignal *)refreshFocusForCategory:(NSNumber *)catID;

@end
