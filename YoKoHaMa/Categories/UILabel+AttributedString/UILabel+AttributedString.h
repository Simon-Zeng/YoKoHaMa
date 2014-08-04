//
//  UILabel+AttributedString.h
//  YoKoHaMa
//
//  Created by simon.zeng on 8/4/14.
//  Copyright (c) 2014 Conggen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (AttributedString)

- (void)setToAttributeText:(NSString *)text;

#pragma mark - Attribute
- (void)underline;

- (void)unUnderline;

- (void)fontSize:(NSUInteger)newFontSize;

- (void)color:(UIColor *)color;

- (void)font:(UIFont *)font;



@end
