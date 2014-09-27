//
//  HMFee.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMEntity.h"

/**
 *  花销统计中的一条记录
 */
@interface HMFee : NSObject<HMEntity>
/**
 *  记录id
 */
@property (nonatomic, strong) NSNumber * identifier;
/**
 *  旅行id. 本版本中尚未使用，默认为0
 */
@property (nonatomic, strong) NSNumber * travelIdentifier;
/**
 *  花销名目
 */
@property (nonatomic, strong) NSString * name;
/**
 *  花销金额
 */
@property (nonatomic, strong) NSNumber * cost;
/**
 *  花销备注信息
 */
@property (nonatomic, strong) NSString * desc;

@end
