//
//  HMTripDao.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMTrip.h"

@interface HMTripDao : NSObject

+ (BOOL)saveTrip:(HMTrip *)aTrip;

+ (HMTrip *)tripWithIdentifier:(NSNumber *)identifier;

+ (BOOL)updateTrip:(HMTrip *)aTrip;

+ (BOOL)deleteTripWithIdentifier:(NSNumber *)identifier;

@end