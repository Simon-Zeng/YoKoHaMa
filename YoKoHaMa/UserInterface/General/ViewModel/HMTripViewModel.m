//
//  HMTripViewModel.m
//  MVVM IOS Example
//
//  Created by simon.zeng on 7/14/14.
//  Copyright (c) 2014 Colin Wheeler. All rights reserved.
//

#import "HMTripViewModel.h"

#import "HMItem.h"
#import "HMItemDao.h"
#import "HMTrip.h"
#import "HMTripDao.h"
#import "HMTripItem.h"
#import "HMTripItemDao.h"

@interface HMTripViewModel ()

@property (nonatomic, strong, readwrite) HMTrip * trip;
@property (nonatomic, strong) NSMutableDictionary * itemsMap;
@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) NSMutableDictionary * cachedTripItems;
@property (nonatomic, strong) NSMutableDictionary * cachedItemCategories;

@property (nonatomic, strong, readwrite) RACSubject * updateContentSignal;

@end

@implementation HMTripViewModel

- (instancetype)initWithTripIdentifier:(NSNumber *)tid
{
    if (self = [super init])
    {
        self.trip = [HMTripDao tripWithIdentifier:tid];
        self.itemsMap = [[NSMutableDictionary alloc] init];
        self.dataSource = nil;
        
        self.cachedTripItems = [[NSMutableDictionary alloc] init];
        self.cachedItemCategories = [[NSMutableDictionary alloc] init];
        
        _updateContentSignal = [RACSubject subject];
        
        _listMode = TripListModeCheck;
        
        [self loadInitialData];
    }
    
    return self;
}

- (void)loadInitialData
{
    NSArray * allItems = [HMTripItemDao itemsWithTripIdentifier:self.trip.identifier];
    NSArray * allTripItems = [HMTripItemDao tripItemsWithTripIdentifier:self.trip.identifier];
    
    for (HMTripItem * aTripItem in allTripItems)
    {
        [self.cachedTripItems setObject:aTripItem forKey:aTripItem.itemIdentifier];
    }
    
    for (HMItem * anItem in allItems)
    {
        NSMutableArray * itemsGroup = [self.itemsMap objectForKey:anItem.categoryIdentifier];
        
        if (!itemsGroup)
        {
            itemsGroup = [[NSMutableArray alloc] init];
        }
        
        [itemsGroup addObject:anItem];
        
        [self.itemsMap setObject:itemsGroup forKey:anItem.categoryIdentifier];
    }
    
    [self reloadData];
}

- (void)reloadData
{
    self.dataSource = [self.itemsMap keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    [(RACSubject *)_updateContentSignal sendNext:self.dataSource];
}

#pragma mark - Getters/Setters

-(RACCommand *) saveCommand
{
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            // Save
            
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
}

-(RACCommand *) recheckCommand
{
    @weakify(self);
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            
            self.listMode = TripListModeCheck;
            
            [subscriber sendCompleted];
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
}

#pragma mark - Public Methods
- (void)addItem:(HMItem *)aItem
{
    if (!aItem.identifier)
    {
        NSNumber * identifier = [HMItemDao saveItem:aItem];
        aItem.identifier = identifier;
    }
    
    NSMutableArray * itemsGroup = [self.itemsMap objectForKey:aItem.categoryIdentifier];
    
    if (!itemsGroup)
    {
        itemsGroup = [[NSMutableArray alloc] init];
    }
    
    [itemsGroup addObject:aItem];
    
    [self.itemsMap setObject:itemsGroup forKey:aItem.categoryIdentifier];
    
    [self reloadData];
}

- (void)removeTripItem:(HMTripItem *)aTripItem
{
    HMItem * anItem = [HMItemDao itemWithIdentifier:aTripItem.itemIdentifier];
    
    if (anItem)
    {
        NSMutableArray * itemsGroup = [self.itemsMap objectForKey:anItem.categoryIdentifier];
        
        if (itemsGroup)
        {
            [itemsGroup removeObject:anItem];
        }
        
        [self reloadData];

    }
}

#pragma mark -
- (NSInteger)numberOfSections
{
    return [self.dataSource count];
}
    
- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    return [[self.dataSource objectAtIndex:section] count];
}

- (NSString *)titleForSection:(NSInteger)section
{
    HMItem * aItem = nil;
    
    if (section < self.itemsMap.count)
    {
        NSArray * itemsInSection = [self.dataSource objectAtIndex:section];
        aItem = [itemsInSection firstObject];
    }
    
    if (aItem)
    {
        HMItemCategory * category = [self.cachedItemCategories objectForKey:aItem.categoryIdentifier];
        
        if (!category)
        {
            category = [HMItemCategoryDao ItemCategoryWithIdentifier:aItem.categoryIdentifier];
            [self.cachedItemCategories setObject:category forKey:aItem.identifier];
        }
        
        return category.name;
    }
    else
    {
        return nil;
    }
}

- (HMTripItem *)itemAtIndexPath:(NSIndexPath *)indexPath
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
    
    if (aItem)
    {
        HMTripItem * aTripItem = [self.cachedTripItems objectForKey:aItem.identifier];
        
        if (!aTripItem)
        {
            aTripItem = [HMTripItemDao tripItemWithTripIdentifier:self.trip.identifier
                                                   itemIdentifier:aItem.identifier];
            [self.cachedTripItems setObject:aTripItem forKey:aItem.identifier];
        }
        
        return aTripItem;
    }
    else
    {
        return nil;
    }
}


@end
