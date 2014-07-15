//
//  HMFocus.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMEntity.h"

@interface HMFocus : NSObject<HMEntity>

@property (nonatomic, strong) NSNumber * identifier;
@property (nonatomic, strong) NSNumber * categoryIdentifier;
@property (nonatomic, strong) NSString * imageURLString;
@property (nonatomic, strong) NSString * name;

+ (HMFocus *)focusFromDictionary:(NSDictionary *)dict;

@end
