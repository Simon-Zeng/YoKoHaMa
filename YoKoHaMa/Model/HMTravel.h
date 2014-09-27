//
//  HMTravel.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMEntity.h"
/**
 *  花销统计中，花销所属旅行对象。在1.0版本中，只有默认的一个id为0的HMTravel对象。
 */
@interface HMTravel : NSObject<HMEntity>
/**
 *  旅行id
 */
@property (nonatomic, strong) NSNumber * identifier;
/**
 *  旅行名称
 */
@property (nonatomic, strong) NSString * name;
/**
 *  旅行人数
 */
@property (nonatomic, strong) NSNumber * membersCount;
/**
 *  人均花销
 */
@property (nonatomic, strong) NSNumber * averageCost;

@end
