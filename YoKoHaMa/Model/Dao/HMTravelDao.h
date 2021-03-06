//
//  HMTravelDao.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMTravel.h"
/**
 *  HMTravel对象的数据库访问适配器
 */
@interface HMTravelDao : NSObject

+ (NSNumber *)saveTravel:(HMTravel *)aTravel;

+ (HMTravel *)travelWithIdentifier:(NSNumber *)identifier;

+ (BOOL)updateTravel:(HMTravel *)aTravel;

+ (BOOL)deleteTravelWithIdentifier:(NSNumber *)identifier;

@end
