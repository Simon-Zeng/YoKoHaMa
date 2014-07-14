//
//  HMItem.h
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMItem : NSObject

@property (nonatomic, strong) NSNumber * identifier;
@property (nonatomic, strong) NSNumber * categoryIdentifier;
@property (nonatomic, strong) NSString * name;

@end

@interface HMItemCategory : NSObject

@property (nonatomic, strong) NSNumber * identifier;
@property (nonatomic, strong) NSString * name;

@end