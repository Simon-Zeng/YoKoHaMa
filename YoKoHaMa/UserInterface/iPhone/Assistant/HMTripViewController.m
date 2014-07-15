//
//  HMTripViewController.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMTripViewController.h"

#import "HMTrip.h"
#import "HMItem.h"
#import "HMTripItem.h"

#import "HMTripViewModel.h"

#import "HMTripStepView.h"
#import "HMTripInputView.h"

#import "HMTripCheckItemTableViewCell.h"
#import "HMTripAddItemTableViewCell.h"
#import "HMTripListItemTableViewCell.h"

typedef NS_ENUM(NSUInteger, TripListMode){
    TripListModeCheck,
    TripListModeAdd,
    TripListModeDone
};

@interface HMTripViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) TripListMode listMode;

@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * shareButton;
@property (nonatomic, strong) UIButton * saveButton;
@property (nonatomic, strong) UIButton * recheckButton;

@property (nonatomic, strong) HMTripStepView * stepView;
@property (nonatomic, strong) HMTripInputView * inputView;

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation HMTripViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    UIView * aView = [[UIView alloc] initWithFrame:bounds];
    
    
    UINavigationItem * topItem = [[UINavigationItem alloc] init];

    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"Button-Back"]
                forState:UIControlStateNormal];
    UIBarButtonItem * logoItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.backButton = backButton;
    
    topItem.leftBarButtonItem = logoItem;
    
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"Button-Share"]
                 forState:UIControlStateNormal];
    UIBarButtonItem * dotItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    self.shareButton = shareButton;
    
    topItem.rightBarButtonItem = dotItem;
    
    UINavigationBar * navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
    navigationBar.items = @[topItem];
    
    [aView addSubview:navigationBar];
    
    self.stepView = [[HMTripStepView alloc] initWithFrame:CGRectMake(0, 44, bounds.size.width, 60)];
    [aView addSubview:self.stepView];
    
    self.inputView = [[HMTripInputView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addFeeView.frame), bounds.size.width, 50)];
    [aView addSubview:self.inputView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.inputView.frame), bounds.size.width, bounds.size.height-44)
                                                  style:UITableViewStyleGrouped];
    [self.tableView registerClass:[HMTripAddItemTableViewCell class]
           forCellReuseIdentifier:@"AddCell"];
    [self.tableView registerClass:[HMTripCheckItemTableViewCell class]
           forCellReuseIdentifier:@"CheckCell"];
    [self.tableView registerClass:[HMTripListItemTableViewCell class]
           forCellReuseIdentifier:@"ListCell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [aView addSubview:self.tableView];
    
    self.view = aView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self.stepView.changeStepSignal subscribeNext:^(id x) {
        @strongify(self);
        TripListMode listMode = (TripListMode)[x longLongValue];
        self.listMode = listMode;
    }];
    
    [self.inputView.addTripItemSignal subscribeNext:^(id x) {
        @strongify(self);
        if ([x isKindOfClass:[HMItem class]])
        {
            [self.viewModel addItem:x];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listMode == TripListModeAdd)
    {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listMode == TripListModeAdd &&
        editingStyle == UITableViewCellEditingStyleDelete)
    {
        HMTripItem * anItem = [self.viewModel itemAtIndexPath:indexPath];
        
        [self.viewModel removeTripItem:anItem];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    
    HMTripItem * tripItem = [self.viewModel itemAtIndexPath:indexPath];
    
    switch (self.listMode)
    {
        case TripListModeCheck:
        {
            HMTripCheckItemTableViewCell * checkCell = [tableView dequeueReusableCellWithIdentifier:@"CheckCell"
                                                                                       forIndexPath:indexPath];
            [checkCell updateWithItem:tripItem];
            
            cell = checkCell;
        }
            break;
        case TripListModeAdd:
        {
            HMTripAddItemTableViewCell * addCell = [tableView dequeueReusableCellWithIdentifier:@"AddCell"
                                                                                       forIndexPath:indexPath];
            [addCell updateWithItem:tripItem];
            
            cell = addCell;
        }
            break;
            
        case TripListModeDone:
        {
            HMTripListItemTableViewCell * listCell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"
                                                                                       forIndexPath:indexPath];
            [listCell updateWithItem:tripItem];
            
            cell = listCell;
        }
            break;
            

        default:
            break;
    }
    
    return cell;
}

@end
