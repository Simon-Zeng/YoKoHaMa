//
//  HMCommonViewModel.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMBasicViewModel.h"

@class HMFocus;
@class HMTrip;
/**
 *  优装备、优路线、优指导公用ViewModel
 */
@interface HMCommonViewModel : HMBasicViewModel
/**
 *  分类id
 */
@property (nonatomic, strong) NSNumber * catID;
/**
 *  刷新广告信号，可以订阅该对象以触发一个刷新事件，并追踪其结果
 */
@property (nonatomic, strong, readonly) RACSignal * refreshFocusSignal;
/**
 *  刷新优路线信号，可以订阅该对象以触发一个刷新事件，并追踪其结果
 */
@property (nonatomic, strong, readonly) RACSignal * refreshRoutesSignal;
/**
 *  刷新优装备路况信号，可以订阅该对象以触发一个刷新事件，并追踪其结果
 */
@property (nonatomic, strong, readonly) RACSignal * refreshRoadsSignal;
/**
 *  刷新优指导出行列表信号，可以订阅该对象以触发一个刷新事件，并追踪其结果
 */
@property (nonatomic, strong, readonly) RACSignal * refreshTripsSignal;

/**
 *  @brief 展示一条优路线具体信息
 *
 *  @param routeIdentifier 优路线id
 */
- (void)showRoute:(NSNumber *)routeIdentifier;

/**
 *  @brief 展示一条路况推荐的优装备具体信息
 *
 *  @param roadIdentifier 优装备路况id
 */
- (void)showRoad:(NSNumber *)roadIdentifier;

/**
 *  @brief 展示一条广告具体信息
 *
 *  @param focus 广告对象
 */
- (void)showDetailForFocus:(HMFocus *)focus;

/**
 *  @brief 打开条形菜单中对应选项对应的页面
 *
 *  @param command 条形菜单中的命令名称
 */
- (void)showDetailForListCommand:(NSString *)command;

/**
 *  @brief 打开花销统计
 */
- (void)feeCalculate;

/**
 *  @brief 打开出行列表对象, 展示出行所需准备
 *
 *  @param aTrip 出行列表对象
 */
- (void)showTripGuideForTrip:(HMTrip *)aTrip;


@end
