//
//  HMTripViewModel.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMBasicViewModel.h"

@class HMItem;
@class HMTrip;

/**
 *  出行列表各阶段
 */
typedef NS_ENUM(NSUInteger, TripListMode){
    /**
     *  检查出行列表阶段
     */
    TripListModeCheck,
    /**
     *  添加自定义出行准备项阶段
     */
    TripListModeAdd,
    /**
     *  确认保存阶段
     */
    TripListModeDone
};

/**
 *  出行列表ViewModel
 */
@interface HMTripViewModel : HMBasicViewModel
/**
 *  出行列表对象
 */
@property (nonatomic, readonly) HMTrip * trip;
/**
 *  内容更新信号
 */
@property (nonatomic, readonly) RACSignal * updateContentSignal;
/**
 *  保存命令
 */
@property (nonatomic, readonly) RACCommand * saveCommand;
/**
 *  当前处理阶段
 */
@property (nonatomic, assign) TripListMode listMode;

/**
 *  @brief 初始化出行列表ViewModel
 *
 *  @param tid 出行列表id
 *
 *  @return 出行列表ViewModel
 */
- (instancetype)initWithTripIdentifier:(NSNumber *)tid;

/**
 *  @brief 添加一个出行准备项
 *
 *  @param aItem 出行准备项
 */
- (void)addItem:(HMItem *)aItem;
/**
 *  @brief 删除一个出行准备项
 *
 *  @param aItem 出行准备项
 */
- (void)removeItem:(HMItem *)aItem;

#pragma mark -
/**
 *  @brief 出行准备项类别总数
 *
 *  @return 类别总数
 */
- (NSInteger)numberOfSections;
/**
 *  @brief 每个出行列表类别中包含的出行准备项数量
 *
 *  @param section 出行列表类别索引号
 *
 *  @return 类别中出行准备项数量
 */
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
/**
 *  @brief 出行列表对应索引的出行类别的名称
 *
 *  @param section 出行列表类别索引
 *
 *  @return 类别名称
 */
- (NSString *)titleForSection:(NSInteger)section;
/**
 *  @brief 列表中对应位置出行准备项
 *
 *  @param indexPath 列表位置
 *
 *  @return 出行准备项
 */
- (HMItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
