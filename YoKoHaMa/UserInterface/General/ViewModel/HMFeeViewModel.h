//
//  HMFeeViewModel.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HMFee.h"
#import "HMBasicViewModel.h"

/**
 *  花销统计ViewModel
 */
@interface HMFeeViewModel : HMBasicViewModel
/**
 *  成员数量
 */
@property (nonatomic, strong) NSNumber * membersCount;

/**
 *  计算人均花销命令，用于绑定到计算按钮
 */
@property (nonatomic, readonly) RACCommand * calculateAverageCommand;

/**
 *  内容更新信号，通知外面viewcontroller需要刷新ui
 */
@property (nonatomic, readonly) RACSignal * updateContentSignal;

/**
 *  @brief 初始化花销统计ViewModel
 *
 *  @param tid 花销对应的旅行id
 *
 *  @return 花销统计ViewModel
 */
- (instancetype)initWithTravelIdentifier:(NSNumber *)tid;

/**
 *  @brief 添加一项花销
 *
 *  @param aFee 花销
 */
- (void)addFee:(HMFee *)aFee;

/**
 *  @brief 删除一项花销
 *
 *  @param aFee 花销
 */
- (void)removeFee:(HMFee *)aFee;

/**
 *  @brief 加载已保存的花销
 */
- (void)loadSavedFee;

#pragma mark - 
/**
 *  @brief 花销条目总算
 *
 *  @return 总数
 */
- (NSInteger)numberOfFees;
/**
 *  @brief 获取indexpath对应的花销对象
 *
 *  @param indexPath 列表中位置
 *
 *  @return 花销对象
 */
- (HMFee *)feeAtIndexPath:(NSIndexPath *)indexPath;

@end
