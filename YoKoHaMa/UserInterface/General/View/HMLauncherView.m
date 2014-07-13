//
//  HMLauncherView.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMLauncherView.h"

@interface HMLauncherView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray * lauchImageViews;

@property (nonatomic, strong) UIScrollView * pageScrollView;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) RACSubject * subjectClose;


- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end

@implementation HMLauncherView


- (instancetype)initWithLaunchImages:(NSArray *)images
{
    if (self = [super init]) {
        self.autoresizesSubviews = YES;
        
        self.lauchImageViews = [[NSMutableArray alloc] init];
        for (UIImage * image in images)
        {
            UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
            imageView.contentMode = UIViewContentModeCenter;
            
            [self.lauchImageViews addObject:imageView];
        }
        
        _currentPage = 0;
        
        UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        // a page is the width of the scroll view
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * images.count, scrollView.frame.size.height);
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.delegate = self;
        
        [self addSubview:scrollView];
        
        self.pageScrollView = scrollView;
        
        // pages are created on demand
        // load the visible page
        // load the page on either side to avoid flashes when the user starts scrolling
        [self loadScrollViewWithPage:_currentPage];
        
        UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(tapped:)];
        tapRecognizer.numberOfTapsRequired = 1;
        tapRecognizer.numberOfTouchesRequired = 1;
        
        [self addGestureRecognizer:tapRecognizer];
        
        self.subjectClose = [[RACSubject alloc] init];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Layout subviews
    CGRect bounds = self.bounds;
    
    self.pageScrollView.frame = bounds;
    self.pageScrollView.contentSize = CGSizeMake(bounds.size.width * _lauchImageViews.count, bounds.size.height);
    
    [self loadScrollViewWithPage:_currentPage];
}


- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= _lauchImageViews.count) return;
    
    // replace the placeholder if necessary
    UIImageView *imageView = [_lauchImageViews objectAtIndex:page];
    
    // add the view to the scroll view
    if (nil == imageView.superview)
    {
        CGRect frame = _pageScrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        imageView.frame = frame;
        [_pageScrollView addSubview:imageView];
    }
    else
    {
        CGRect frame = _pageScrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        imageView.frame = frame;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _pageScrollView.frame.size.width;
    int page = floor((_pageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)tapped:(UIGestureRecognizer *)recognizer
{
    if (_currentPage == _lauchImageViews.count - 1)
    {
        [self.subjectClose sendNext:[NSNumber numberWithBool:YES]];
    }
}

#pragma mark - Public
- (RACSignal *)closeSignal
{
    @weakify(self);
    RACSignal * signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self);
        RACDisposable * disposable = [self.subjectClose subscribe:subscriber];
        
        return [RACDisposable disposableWithBlock:^{
            [disposable dispose];
        }];
    }];
    
    return signal;
}

@end
