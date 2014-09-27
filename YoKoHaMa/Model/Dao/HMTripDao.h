//
//  HMTripDao.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMTrip.h"
/**
 *  HMTrip对象的数据库访问适配器
 */
@interface HMTripDao : NSObject

+ (NSNumber *)saveTrip:(HMTrip *)aTrip;

+ (NSArray *)allTrips;
+ (HMTrip *)tripWithIdentifier:(NSNumber *)identifier;

+ (BOOL)updateTrip:(HMTrip *)aTrip;

+ (BOOL)deleteTripWithIdentifier:(NSNumber *)identifier;

@end
