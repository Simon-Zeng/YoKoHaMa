//
//  HMFee.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMEntity.h"

@interface HMFee : NSObject<HMEntity>

@property (nonatomic, strong) NSNumber * identifier;
@property (nonatomic, strong) NSNumber * travelIdentifier;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSNumber * cost;
@property (nonatomic, strong) NSString * desc;

@end
