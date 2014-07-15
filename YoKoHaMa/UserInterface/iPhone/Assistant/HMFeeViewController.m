//
//  HMFeeViewController.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-14.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMFeeViewController.h"

#import "HMFee.h"
#import "HMFeeDao.h"
#import "HMFeeViewModel.h"

#import "HMAddFeeView.h"
#import "HMSumFeeView.h"

#import "HMFeeTableViewCell.h"


@interface HMFeeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HMFeeViewModel * viewModel;

@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * shareButton;

@property (nonatomic, strong) HMAddFeeView * addFeeView;
@property (nonatomic, strong) HMSumFeeView * sumFeeView;


@property (nonatomic, strong) UITableView * tableView;

@end

@implementation HMFeeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.viewModel = [[HMFeeViewModel alloc] initWithTravelIdentifier:nil];
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
    
    self.addFeeView = [[HMAddFeeView alloc] initWithFrame:CGRectMake(0, 44, bounds.size.width, 88)];
    [aView addSubview:self.addFeeView];
    
    self.sumFeeView = [[HMSumFeeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addFeeView.frame), bounds.size.width, 68)];
    [aView addSubview:self.sumFeeView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sumFeeView.frame), bounds.size.width, bounds.size.height-44)
                                                  style:UITableViewStyleGrouped];
    [self.tableView registerClass:[HMFeeTableViewCell class]
           forCellReuseIdentifier:@"Cell"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [aView addSubview:self.tableView];
    
    self.view = aView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    @weakify(self);
    // Do any additional setup after loading the view.
    [self.addFeeView.addFeeSignal subscribeNext:^(id x) {
        @strongify(self);
        
        HMFee * aFee = (HMFee *)x;
        
        if (aFee)
        {
            [self.viewModel addFee:aFee];
        }
    }];

    self.sumFeeView.calculateAverageCommand = self.viewModel.calculateAverageCommand;
    
    [self.viewModel.updateContentSignal subscribeNext:^(id x) {
        @strongify(self);
        
        if ([x isKindOfClass:[NSArray class]])
        {
            [self.sumFeeView updateWithFees:x];
            [self.tableView reloadData];
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
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        HMFee * aFee = [self.viewModel feeAtIndexPath:indexPath];
        
        [self.viewModel removeFee:aFee];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfFees];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMFeeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                                forIndexPath:indexPath];
    
    HMFee * aFee = [self.viewModel feeAtIndexPath:indexPath];
    
    [cell updateWithFee:aFee];
    
    return cell;
}

@end
