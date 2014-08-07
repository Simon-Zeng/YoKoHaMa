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

#import "HMHelper.h"

#import "HMAddFeeView.h"
#import "HMSubtitleView.h"
#import "HMSumFeeView.h"
#import "HMNavigationView.h"

#import "HMFeeTableViewCell.h"


@interface HMFeeViewController ()<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) HMFeeViewModel * viewModel;

@property (nonatomic, strong) HMNavigationView * navigationBar;
@property (nonatomic, strong) HMSubtitleView * subtitleView;
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
    
    self.navigationBar = [[HMNavigationView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
    self.navigationBar.shareButtonEnabled = YES;
    [aView addSubview:self.navigationBar];
    
    self.subtitleView = [[HMSubtitleView alloc] initWithFrame:CGRectMake(0, 44, bounds.size.width, 30)];
    [self.subtitleView setTitle:NSLocalizedString(@"花销统计", nil)];
    [aView addSubview:self.subtitleView];
    
    self.addFeeView = [[HMAddFeeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.subtitleView.frame), bounds.size.width, 106)];
    [aView addSubview:self.addFeeView];
    
    self.sumFeeView = [[HMSumFeeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.addFeeView.frame), bounds.size.width, 65)];
    [aView addSubview:self.sumFeeView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sumFeeView.frame), bounds.size.width, bounds.size.height-44)
                                                  style:UITableViewStyleGrouped];
    [self.tableView registerClass:[HMFeeTableViewCell class]
           forCellReuseIdentifier:@"Cell"];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    [aView addSubview:self.tableView];
    
    [aView sendSubviewToBack:self.tableView];
    
    self.view = aView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.title = self.title;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(hideKeyboard:)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    
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
    
    [self.sumFeeView.memberCountsSignal subscribeNext:^(id x) {
        @strongify(self);
        self.viewModel.membersCount = x;
    }];

    self.sumFeeView.calculateAverageCommand = self.viewModel.calculateAverageCommand;
    
    [[self.sumFeeView.calculateAverageCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
        if (x)
        {
            [self.sumFeeView updateWithFees:x];
        }
    }];
    
    [self.viewModel.updateContentSignal subscribeNext:^(id x) {
        @strongify(self);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([x isKindOfClass:[NSArray class]])
            {
                [self.sumFeeView updateWithFees:x];
                [self.tableView reloadData];
            }
        });
    }];
    [self.navigationBar.backSignal subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue])
        {
            [self.viewModel back];
        }
    }];
    
    [self.navigationBar.shareSignal subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue])
        {
            UIImage * screenShot = [HMHelper screenShot:self.view.window];
            NSString * message = NSLocalizedString(@"我的出行费用", nil); ;
            
            [self.viewModel shareImage:screenShot message:message];
        }
    }];
    
    // Load old saved fee
    [self.viewModel loadSavedFee];
}

- (void)hideKeyboard:(UITapGestureRecognizer *)recognizer
{
    [self.view endEditing:YES];
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

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"您已输入的费用明细清单:", nil);
}

@end
