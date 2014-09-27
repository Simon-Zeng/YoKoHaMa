//
//  HMTrip.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMEntity.h"
/**
 *  出行列表对象，用于用户出行指导
 */
@interface HMTrip : NSObject<HMEntity>
/**
 *  出行列表id
 */
@property (nonatomic, strong) NSNumber * identifier;
/**
 *  出行列表名称
 */
@property (nonatomic, strong) NSString * name;

@end
