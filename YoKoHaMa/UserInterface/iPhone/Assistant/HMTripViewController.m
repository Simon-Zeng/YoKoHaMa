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

#import "HMHelper.h"

#import "HMTripViewModel.h"

#import "HMTripStepView.h"
#import "HMTripInputView.h"
#import "HMNavigationView.h"
#import "HMTripHeaderView.h"

#import "HMTripCheckItemTableViewCell.h"
#import "HMTripAddItemTableViewCell.h"
#import "HMTripListItemTableViewCell.h"

@interface HMTripViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HMNavigationView * navigationBar;

@property (nonatomic, strong) UIButton * saveButton;

@property (nonatomic, strong) HMTripStepView * stepView;
@property (nonatomic, strong) HMTripInputView * inputView;

@property (nonatomic, strong) UILabel * tableHeaderLabel;

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
    
    self.navigationBar = [[HMNavigationView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
    self.navigationBar.shareButtonEnabled = YES;
    [aView addSubview:self.navigationBar];
    
    self.stepView = [[HMTripStepView alloc] initWithFrame:CGRectMake(0, 44, bounds.size.width, 60)];
    [aView addSubview:self.stepView];
    
    self.inputView = [[HMTripInputView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.stepView.frame), bounds.size.width, 50)];
    [aView addSubview:self.inputView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.inputView.frame), bounds.size.width, bounds.size.height-44)
                                                  style:UITableViewStylePlain];
    [self.tableView registerClass:[HMTripAddItemTableViewCell class]
           forCellReuseIdentifier:@"AddCell"];
    [self.tableView registerClass:[HMTripCheckItemTableViewCell class]
           forCellReuseIdentifier:@"CheckCell"];
    [self.tableView registerClass:[HMTripListItemTableViewCell class]
           forCellReuseIdentifier:@"ListCell"];
    [self.tableView registerClass:[HMTripHeaderView class]
forHeaderFooterViewReuseIdentifier:@"TripHeader"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    // Table Header View
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, bounds.size.width, 30)];
    UILabel * tableHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, bounds.size.width-20, 30)];
    tableHeaderLabel.text = NSLocalizedString(@"您已添加的检查项目", nil);
    tableHeaderLabel.font = [UIFont systemFontOfSize:13.0];
    tableHeaderLabel.textAlignment = NSTextAlignmentLeft;
    tableHeaderLabel.textColor = [UIColor redColor];
    [headerView addSubview:tableHeaderLabel];
    self.tableView.tableHeaderView = headerView;
    self.tableHeaderLabel = tableHeaderLabel;
    
    // Table Footer View
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, bounds.size.width, 34)];
    self.saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.saveButton setTitle:NSLocalizedString(@"下一步，添加自定义项", nil)
                     forState:UIControlStateNormal];
    self.saveButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Button-Background"]];
    self.saveButton.frame = CGRectMake(80, 3, 160, 28);
    
    [footerView addSubview:self.saveButton];
    
    self.tableView.tableFooterView = footerView;
    
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
        self.viewModel.listMode = listMode;
        [self.stepView setSelectedIndex:listMode];
    }];
    
    [self.inputView.addTripItemSignal subscribeNext:^(id x) {
        @strongify(self);
        if ([x isKindOfClass:[NSString class]] && [x length] > 0)
        {
            HMItem * anItem = [[HMItem alloc] init];
            anItem.identifier = nil;
            anItem.name = x;
            
            [self.viewModel addItem:anItem];
        }
    }];
    [self.inputView.frameChangedSignal subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            CGRect bounds = self.view.bounds;
            
            CGRect tableViewFrame = self.tableView.frame;
            tableViewFrame.origin.y = CGRectGetMaxY(self.inputView.frame);
            tableViewFrame.size.height = bounds.size.height - CGRectGetMaxY(self.inputView.frame);
            
            self.tableView.frame = tableViewFrame;
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
            NSString * message = NSLocalizedString(@"我的出行准备", nil); ;
            
            [self.viewModel shareImage:screenShot message:message];
        }
    }];
    
    [self.viewModel.updateContentSignal subscribeNext:^(id x) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self);
            [self.tableView reloadData];
        });
    }];
    
    [RACObserve(self.viewModel, listMode) subscribeNext:^(id x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view endEditing:YES];
            
            TripListMode mode = (TripListMode)[x longLongValue];
            switch (mode)
            {
                case TripListModeCheck:
                {
                    self.tableHeaderLabel.text = NSLocalizedString(@"请在您需要的选项打勾", nil);
                }
                    break;
                default:
                {
                    self.tableHeaderLabel.text = NSLocalizedString(@"您已添加的项目", nil);
                }
                    
                    break;
            }
            
            [self updateLayout];
            [self.tableView reloadData];
        });
    }];
    
    self.saveButton.rac_command = self.viewModel.saveCommand;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.stepView setSelectedIndex:0];
    
    self.stepView.title = [NSString stringWithFormat:@"%@出行列表", self.viewModel.trip.name];
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


- (void)updateLayout
{
    TripListMode mode = self.viewModel.listMode;
    
    if (mode == TripListModeAdd)
    {
        self.inputView.inputFieldHidden = NO;
    }
    else
    {
        self.inputView.inputFieldHidden = YES;    }
    
    if (mode == TripListModeCheck || mode == TripListModeDone)
    {
        self.tableView.tableHeaderView.hidden = NO;
        self.tableView.tableFooterView.hidden = NO;
    }
    else
    {
        self.tableView.tableHeaderView.hidden = YES;
        self.tableView.tableFooterView.hidden = YES;
    }
    
    if (mode == TripListModeDone || mode == TripListModeAdd)
    {
        self.navigationBar.shareButtonEnabled = YES;
    }
    else
    {
        self.navigationBar.shareButtonEnabled = NO;
    }
}

#pragma mark - UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TripListMode mode = self.viewModel.listMode;
    
    if (mode == TripListModeAdd)
    {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TripListMode mode = self.viewModel.listMode;
    
    if (mode == TripListModeAdd &&
        editingStyle == UITableViewCellEditingStyleDelete)
    {
        HMItem * anItem = [self.viewModel itemAtIndexPath:indexPath];
        
        [self.viewModel removeItem:anItem];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMItem * tripItem = [self.viewModel itemAtIndexPath:indexPath];
    
    if ([tripItem.state boolValue])
    {
        tripItem.state = @0;
    }
    else
    {
        tripItem.state = @1;
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
    
    HMItem * tripItem = [self.viewModel itemAtIndexPath:indexPath];
    
    TripListMode mode = self.viewModel.listMode;
    
    switch (mode)
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect bounds = tableView.bounds;
    
    HMTripHeaderView * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TripHeader"];
    headerView.frame = CGRectMake(0, 0, bounds.size.width, 44);
//    headerView.contentView.backgroundColor = [UIColor redColor];
    headerView.textLabel.text = [self.viewModel titleForSection:section];
    headerView.textLabel.textColor = [UIColor grayColor];
    
    return headerView;
}

@end
