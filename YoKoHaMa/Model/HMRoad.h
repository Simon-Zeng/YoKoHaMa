//
//  HMRoad.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-16.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMEntity.h"

@interface HMRoad : NSObject<HMEntity>

@property (nonatomic, strong) NSNumber * identifier;
@property (nonatomic, strong) NSString * name;

@end
