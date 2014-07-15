//
//  HMEntity.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef YoKoHaMa_HMEntity_h
#define YoKoHaMa_HMEntity_h

@protocol HMEntity <NSObject>

@property (nonatomic, strong) NSNumber * identifier;
@property (nonatomic, strong) NSString * name;

@end

#endif
