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

@interface HMGridContentView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) NSArray * focuses;
@property (nonatomic, strong) HMFocus * selectedFocus;

@end

@implementation HMGridContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.bounds];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        [collectionView registerClass:[HMGridMenuViewCell class]
           forCellWithReuseIdentifier:@"Cell"];
        
        [self addSubview:collectionView];
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
    HMFocus * focus = [self.focuses objectAtIndex:indexPath.row];
    
    self.selectedFocus = focus;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.focuses.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMGridMenuViewCell * cell = (HMGridMenuViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    HMFocus * focus = [self.focuses objectAtIndex:indexPath.row];
    
    cell.title = focus.title;
    
    return cell;
}



#pragma mark -
- (RACSignal *)openSignal
{
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return [RACObserve(self, selectedFocus) subscribeNext:^(id x) {
            [subscriber sendNext:x];
        }];
    }];
    
    return signal;
}

- (void)updateWithFocuses:(NSArray *)focuses
{
    self.focuses = focuses;
    
    [self.collectionView reloadData];
}

@end
