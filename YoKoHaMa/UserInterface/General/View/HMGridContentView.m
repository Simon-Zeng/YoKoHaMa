//
//  HMGridContentView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMGridContentView.h"
#import "HMFocus.h"

#import "HMGridMenuViewCell.h"
#import "HMCollectionViewLayout.h"

@interface HMGridContentView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) NSArray * entities;

@property (nonatomic, strong, readwrite) RACSubject * openSignal;

@end

@implementation HMGridContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        HMCollectionViewLayout * layout = [[HMCollectionViewLayout alloc] init];
        
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        
        [collectionView registerClass:[HMGridMenuViewCell class]
           forCellWithReuseIdentifier:@"Cell"];

        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.bounces = YES;
        collectionView.alwaysBounceVertical = YES;
        
        
        [self addSubview:collectionView];
        
        RACSubject * signal = [RACSubject subject];
        
        self.openSignal = signal;
    }
    return self;
}

- (void)dealloc
{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    
    _collectionView = nil;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    self.collectionView.frame = bounds;

}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<HMEntity> entity = [self.entities objectAtIndex:indexPath.row];
    
    [(RACSubject *)self.openSignal sendNext:entity];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.entities.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMGridMenuViewCell * cell = (HMGridMenuViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    id<HMEntity> entity = [self.entities objectAtIndex:indexPath.row];
    
    cell.title = entity.name;
    
    return cell;
}



#pragma mark -

- (void)updateWithEntities:(NSArray *)entities
{
    self.entities = entities;
    
    [self.collectionView reloadData];
}

@end
