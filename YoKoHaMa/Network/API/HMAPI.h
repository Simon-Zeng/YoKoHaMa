//
//  HMAPI.h
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMAPI : NSObject

+ (instancetype) apiCenter;

- (RACSignal *)refreshFocusForCategory:(NSNumber *)catID;

@end
