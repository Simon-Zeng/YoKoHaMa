//
//  HMSegmentedCotnrol.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-16.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMSegmentedCotnrol.h"

@interface HMSegmentedCotnrol ()

-(void)setInitialMode;
-(void)toggleHighlightColors;

@end

@implementation HMSegmentedCotnrol

-(id)initWithItems:(NSArray *)items offColor:(UIColor*)offcolor onColor:(UIColor*)oncolor
{
    if (self = [super initWithItems:items])
    {
        // Initialization code
        self.offColor = offcolor;
        self.onColor = oncolor;
        [self setInitialMode];
        
        // default to 0, other values cause arbitrary highlighting bug
        [self setSelectedSegmentIndex:0];
    }
    return self;
}
- (void)awakeFromNib
{
    // default colors
    self.offColor = [UIColor colorWithWhite:0.8 alpha:1];
    self.onColor = self.tintColor;
    [self setInitialMode];
    
    [self setSelectedSegmentIndex:0];
}

-(void)setInitialMode
{
    // set essential properties
    [self setBackgroundColor:[UIColor clearColor]];
    [self setSegmentedControlStyle:UISegmentedControlStyleBar];
    
    // loop through children and set initial tint
    for( int i = 0; i < [self.subviews count]; i++ )
    {
        [[self.subviews objectAtIndex:i] setTintColor:nil];
        [[self.subviews objectAtIndex:i] setTintColor:_offColor];
    }
    
    // listen for updates, [self setSelectedSegmentIndex:0] triggers UIControlEventValueChanged in 5.0, 4.3 doesn't (facepalm), use  if( self.window ) to fix this
    [self addTarget:self action:@selector(toggleHighlightColors) forControlEvents:UIControlEventValueChanged];
}

// ---------------
// hlung's version
// ---------------
-(void)toggleHighlightColors
{
    // the subviews array order randomly changes all the time, change to check for "isSelected" instead
    for (id v in self.subviews) {
        if ([v isSelected]) [v setTintColor:_onColor];
        else [v setTintColor:_offColor];
    }
}
// override: update color when set selection
- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    [super setSelectedSegmentIndex:selectedSegmentIndex];
    [self toggleHighlightColors];
}

@end
