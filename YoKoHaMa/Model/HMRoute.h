//
//  HMRoute.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-16.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMEntity.h"
/**
 *  优路线对象
 */
@interface HMRoute : NSObject<HMEntity>
/**
 *  路线id
 */
@property (nonatomic, strong) NSNumber * identifier;
/**
 *  路线名称
 */
@property (nonatomic, strong) NSString * name;

@end
