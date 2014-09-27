//
//  HMRoad.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-16.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMEntity.h"
/**
 *  优装备中的路况对象，用以归纳各路况中的所推荐的装备
 */
@interface HMRoad : NSObject<HMEntity>
/**
 *  路况id
 */
@property (nonatomic, strong) NSNumber * identifier;
/**
 *  路况名称
 */
@property (nonatomic, strong) NSString * name;

@end
