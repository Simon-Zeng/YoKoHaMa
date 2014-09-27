//
//  HMItem.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMEntity.h"

/**
 *  出行列表中，需要准备的物件对象
 */
@interface HMItem : NSObject<HMEntity>

/**
 *  物件id
 */
@property (nonatomic, strong) NSNumber * identifier;
/**
 *  物件所属类别
 */
@property (nonatomic, strong) NSNumber * categoryIdentifier;
/**
 *  物件名称
 */
@property (nonatomic, strong) NSString * name;
/**
 *  物件准备状态
 */
@property (nonatomic, strong) NSNumber * state;

@end

/**
 *  物件类别对象
 */
@interface HMItemCategory : NSObject<HMEntity>
/**
 *  类别id
 */
@property (nonatomic, strong) NSNumber * identifier;
/**
 *  出行id
 */
@property (nonatomic, strong) NSNumber * tripIdentifier;
/**
 *  类别名称
 */
@property (nonatomic, strong) NSString * name;

@end