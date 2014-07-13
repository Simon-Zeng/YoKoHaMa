//
//  HMFocus.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMFocus.h"

@implementation HMFocus

- (NSString *)description
{
    NSMutableString * description = [super.description mutableCopy];
    
    [description appendFormat:@"_identifier: %@, ", _identifier];
    [description appendFormat:@"_title: %@, ", _title];
    [description appendFormat:@"_imageURLString: %@, ", _imageURLString];
    
    return description;
}

@end
