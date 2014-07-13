//
//  HMCollectionViewLayout.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMCollectionViewLayout.h"

@implementation HMCollectionViewLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(100, 100);
    self.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.minimumInteritemSpacing = 5.0f;
    self.minimumLineSpacing = 5.0f;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return self;
}

@end
