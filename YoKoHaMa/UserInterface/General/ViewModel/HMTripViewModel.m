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

@interface HMTripViewModel ()

@property (nonatomic, strong, readwrite) HMTrip * trip;
@property (nonatomic, strong) NSMutableDictionary * itemsMap;
@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) NSMutableDictionary * cachedTripCategories;
@property (nonatomic, strong) NSNumber * customCategoryIdentifier;

@property (nonatomic, strong) NSArray * sectionKeys;

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
        
        self.cachedTripCategories = [[NSMutableDictionary alloc] init];
        
        _updateContentSignal = [RACSubject subject];
        
        _listMode = TripListModeCheck;
        
        [self loadInitialData];
    }
    
    return self;
}

- (void)loadInitialData
{
    NSArray * allTripCategories = [HMItemCategoryDao itemCategoriesWithTripIdentifier:self.trip.identifier];
    
    for (HMItemCategory * aTripCategory in allTripCategories)
    {
        [self.cachedTripCategories setObject:aTripCategory forKey:aTripCategory.identifier];
        
        if ([aTripCategory.name isEqual:@"自定义"])
        {
            self.customCategoryIdentifier = aTripCategory.identifier;
        }
        
        NSArray * itemsInCategory = [HMItemDao itemsWithCategoryIdentifier:aTripCategory.identifier];
        
        NSMutableArray * itemsGroup = [NSMutableArray arrayWithArray:itemsInCategory];
        
        [self.itemsMap setObject:itemsGroup forKey:aTripCategory.identifier];
    }
    
    [self reloadData];
}

- (void)reloadData
{
    self.sectionKeys = [[self.itemsMap allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    for (NSNumber * cid in self.sectionKeys)
    {
        if (_listMode == TripListModeCheck)
        {
            [array addObject:self.itemsMap[cid]];
        }
        else
        {
            // Only show those state = 1;
            NSPredicate * precidate = [NSPredicate predicateWithFormat:@"SELF.state == %@", @1];
            NSArray * filtered = [NSArray arrayWithArray:[self.itemsMap[cid] filteredArrayUsingPredicate:precidate]];
            
            [array addObject:filtered];
        }
    }
    
    self.dataSource = array;
    
    [(RACSubject *)_updateContentSignal sendNext:self.dataSource];
}

#pragma mark - Getters/Setters

- (void)setListMode:(TripListMode)listMode
{
    if (_listMode != listMode)
    {
        _listMode = listMode;
        
        [self reloadData];
    }
}

-(RACCommand *) saveCommand
{
    @weakify(self);
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            @strongify(self);
            
            self.listMode = TripListModeAdd;
            
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
        aItem.categoryIdentifier = self.customCategoryIdentifier;
        aItem.state = @1;
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

- (void)removeItem:(HMItem *)anItem
{
    if (anItem.categoryIdentifier.longLongValue == self.customCategoryIdentifier.longLongValue)
    {
        [HMItemDao deleteItemWithIdentifier:anItem.identifier];
    }
    else
    {
        anItem.state = @0;
    }

    [self reloadData];
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
    if (section < self.sectionKeys.count)
    {
        NSNumber * itemCategoryIdentifier = [self.sectionKeys objectAtIndex:section];
        
        HMItemCategory * category = [self.cachedTripCategories objectForKey:itemCategoryIdentifier];
        
        return category.name;
    }
    else
    {
        return nil;
    }
}

- (HMItem *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    HMItem * aItem = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return aItem;
}


@end
