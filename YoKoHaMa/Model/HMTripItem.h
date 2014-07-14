//
//  HMTripItem.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTripItem : NSObject

@property (nonatomic, strong) NSNumber * tripIdentifier;
@property (nonatomic, strong) NSNumber * itemIdentifier;
@property (nonatomic, strong) NSNumber * required;
@property (nonatomic, strong) NSNumber * state;

@end
