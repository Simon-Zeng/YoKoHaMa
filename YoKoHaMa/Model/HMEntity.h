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
/**
 *  HMEntity定义一个实体对象所需实现的协议，供优装备、优路线、优指导中各对象实现，用以实现某些功能中的多态性
 */
@protocol HMEntity <NSObject>
/**
 *  实体id
 */
@property (nonatomic, strong) NSNumber * identifier;
/**
 *  实体名称
 */
@property (nonatomic, strong) NSString * name;

@end

#endif
