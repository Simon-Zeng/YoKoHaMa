//
//  HMFocus.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMEntity.h"

/**
 *  广告对象，优装备，优路线等上方大广告
 */
@interface HMFocus : NSObject<HMEntity>
/**
 *  广告id
 */
@property (nonatomic, strong) NSNumber * identifier;
/**
 *  分类id
 */
@property (nonatomic, strong) NSNumber * categoryIdentifier;
/**
 *  广告图片地址
 */
@property (nonatomic, strong) NSString * imageURLString;
/**
 *  广告标题
 */
@property (nonatomic, strong) NSString * name;

/**
 *  将服务器返回的数据转换为一个广告对象
 *
 *  @param dict 服务器返回的广告数据字典
 *
 *  @return 广告对象
 */
+ (HMFocus *)focusFromDictionary:(NSDictionary *)dict;

@end
