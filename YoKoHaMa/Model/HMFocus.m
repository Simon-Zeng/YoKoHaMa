//
//  HMFocus.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMFocus.h"

@implementation HMFocus

+ (HMFocus *)focusFromDictionary:(NSDictionary *)dict
{
    HMFocus * focus = [[HMFocus alloc] init];
    
    focus.identifier = [dict objectForKey:@"id"];
    focus.title = [dict objectForKey:@"title"];
    focus.imageURLString = [dict objectForKey:@"image"];

    
    return focus;
}

- (NSString *)description
{
    NSMutableString * description = [super.description mutableCopy];
    
    [description appendFormat:@"_identifier: %@, ", _identifier];
    [description appendFormat:@"_categoryIdentifier: %@, ", _categoryIdentifier];
    [description appendFormat:@"_title: %@, ", _title];
    [description appendFormat:@"_imageURLString: %@, ", _imageURLString];
    
    return description;
}

@end
