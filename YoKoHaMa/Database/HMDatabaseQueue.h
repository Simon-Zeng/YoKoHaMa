//
//  HMDatabaseQueue.h
//  YoKoHaMa
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Conggen. All rights reserved.
//

#import "FMDatabaseQueue.h"

/**
 *  HMDatabaseQueue is used to initialize the database queue for data saving in YoKoHaMa.
 *  The initialize data is also loaded by the queue when the application is first installed
 */
@interface HMDatabaseQueue : FMDatabaseQueue

/**
 *  @brief Singleton method for the whole application to access database changes
 *
 *  @return shared instance of HMDatabaseQueue
 */
+ (instancetype)sharedDBQueue;

@end
