//
//  HMTripViewModel.m
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import "HMTripViewModel.h"

#import "HMItem.h"
#import "HMTrip.h"

@interface HMTripViewModel ()

@property (nonatomic, strong) HMTrip * trip;
@property (nonatomic, strong) NSMutableDictionary * itemsMap;
@property (nonatomic, strong) NSArray * dataSource;


@property (nonatomic, strong, readwrite) RACSubject * updateContentSignal;

@end

@implementation HMTripViewModel

- (instancetype)initWithTripIdentifier:(NSNumber *)tid
{
    if (self = [super init])
    {
        self.trip = nil;
        self.itemsMap = [[NSMutableDictionary alloc] init];
        self.dataSource = nil;
        
        _updateContentSignal = [RACSubject subject];
    }
    
    return self;
}

- (void)reloadData
{
    self.dataSource = [self.itemsMap keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    [(RACSubject *)_updateContentSignal sendNext:self.dataSource];
}

#pragma mark - Getters/Setters


#pragma mark - Public Methods
- (void)addItem:(HMItem *)aItem
{
    NSMutableArray * itemsGroup = [self.itemsMap objectForKey:aItem.categoryIdentifier];
    
    if (!itemsGroup)
    {
        itemsGroup = [[NSMutableArray alloc] init];
    }
    
    [itemsGroup addObject:aItem];
    
    [self.itemsMap setObject:itemsGroup forKey:aItem.categoryIdentifier];
    
    [self reloadData];
}

- (void)removeItem:(HMItem *)aItem
{
    NSMutableArray * itemsGroup = [self.itemsMap objectForKey:aItem.categoryIdentifier];
    
    if (itemsGroup)
    {
        [itemsGroup removeObject:aItem];
    }
    
    [self reloadData];
}

- (RACSignal *)shareImage:(UIImage *)image
{
    RACSignal * signal = [RACSignal empty];
    
    // TODO: Share
    
    return signal;
}


#pragma mark -
- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
}

- (HMItem *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    HMItem * aItem = nil;
    
    if (indexPath.section < self.itemsMap.count)
    {
        NSArray * itemsInSection = [self.dataSource objectAtIndex:indexPath.section];
        if (indexPath.row < itemsInSection.count)
        {
            aItem = [itemsInSection objectAtIndex:indexPath.row];
        }
    }
    
    return aItem;
}


@end
