//
//  UILabel+AttributedString.m
//  YoKoHaMa
//
//  Created by simon.zeng on 8/4/14.
//  Copyright (c) 2014 Conggen. All rights reserved.
//

#import "UILabel+AttributedString.h"

#import <objc/runtime.h>

NSString * const UILabelSelectedStringToAttributeKey = @"UILabelSelectedStringToAttributeKey";

@implementation UILabel (AttributedString)

- (void)setToAttributeText:(NSString *)text
{
    objc_setAssociatedObject(self, UILabelSelectedStringToAttributeKey.UTF8String, text, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)selectedText
{
    return objc_getAssociatedObject(self, UILabelSelectedStringToAttributeKey.UTF8String);
}

#pragma mark -

-(void)addLableAttributes:(NSDictionary *)attributes range:(NSRange)range
{
    if (range.location != NSNotFound)
    {
        NSMutableAttributedString *matt = [self.attributedText mutableCopy];
        [matt addAttributes:attributes range:range];
        self.attributedText = matt;
    }
    
}

-(void)addSelectedWordAttributes:(NSDictionary *)attributes
{
    if (self.selectedText)
    {
        NSRange range = [[self.attributedText string] rangeOfString:[self selectedText]];
        [self addLableAttributes:attributes range:range];
    }
}



- (void)underline
{
    NSDictionary *underlineDictAtt = @{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)};
    [self addSelectedWordAttributes:underlineDictAtt];
}

- (void)unUnderline
{
    NSDictionary *unUnderlinAttrDict = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)};
    [self addSelectedWordAttributes:unUnderlinAttrDict];
}



- (void)fontSize:(NSUInteger)newFontSize
{
    UIFont *font = [self.font fontWithSize:newFontSize];
    
    NSDictionary *fontSizeAttr = @{NSFontAttributeName: font};
    [self addSelectedWordAttributes:fontSizeAttr];
}

- (void)color:(UIColor *)color
{
    NSDictionary *colorAttribute = @{NSForegroundColorAttributeName: color};
    [self addSelectedWordAttributes:colorAttribute];
}

- (void)font:(UIFont *)font
{
    NSDictionary *newForntAtt = @{NSFontAttributeName: font};
    
    [self addSelectedWordAttributes:newForntAtt];
}

@end
