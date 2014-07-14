//
//  HMDatabaseQueue.h
//  YoKoHaMa
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Conggen. All rights reserved.
//

#import "FMDatabaseQueue.h"

@interface HMDatabaseQueue : FMDatabaseQueue

+ (instancetype)sharedDBQueue;

@end
