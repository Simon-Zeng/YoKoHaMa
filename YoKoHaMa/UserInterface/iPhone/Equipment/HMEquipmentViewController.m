//
//  HMEquipmentViewController.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMEquipmentViewController.h"

#import "HMFocusView.h"
#import "HMListMenuView.h"
#import "HMGridContentView.h"

#import "HMCommonViewModel.h"

@interface HMEquipmentViewController ()

@property (nonatomic, strong) HMCommonViewModel * viewModel;

@property (nonatomic, strong) HMFocusView * focusView;
@property (nonatomic, strong) HMListMenuView * listMenu;
@property (nonatomic, strong) HMGridContentView * gridContent;

@end


@implementation HMEquipmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.viewModel = [[HMCommonViewModel alloc] init];
    }
    return self;
}

- (void)loadView
{
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    UIView * aView = [[UIView alloc] initWithFrame:bounds];
    
    self.focusView = [[HMFocusView alloc] initWithFrame:CGRectMake(0, 44, bounds.size.width, 186)];
    
    [aView addSubview:self.focusView];
    
    NSArray * options = @[
                          NSLocalizedString(@"装备指导", nil),
                          ];
    
    self.listMenu = [[HMListMenuView alloc] initWithTitle:NSLocalizedString(@"轮胎装备", nil)
                                                  options:options];
    self.listMenu.frame = CGRectMake(0, 230, bounds.size.width, 44);
    
    [aView addSubview:self.listMenu];
    
    self.gridContent = [[HMGridContentView alloc] initWithFrame:CGRectMake(0, 274, bounds.size.width, bounds.size.height - 322)];
    self.gridContent.autoresizingMask = UIViewAutoresizingFlexibleHeight;

    [aView addSubview:self.gridContent];
    
    [aView addSubview:self.listMenu];
    
    self.view = aView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    
    // Request data from SS, and Update view
    [self.viewModel.refreshFocusSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.focusView updateWithFocus:x];
    } error:^(NSError *error) {
        NSLog(@"Error in refreshing focus: %@", error);
    }];
    
    [self.viewModel.refreshTypesSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.gridContent updateWithFocuses:nil];
    } error:^(NSError *error) {
        NSLog(@"Error in refreshing types: %@", error);
    }];

    [self.focusView.openSignal subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"Open focus: %@", x);
        if (x)
        {
            [self.viewModel showDetailForFocus:x];
        }
    }];
    
    [self.listMenu.openSignal subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"List Menu selected: %@", x);
        [self.viewModel showDetailForListCommand:x];
    }];
    
    [self.gridContent.openSignal subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"Content Menu selected: %@", x);
        HMFocus * focus = (HMFocus *)x;
        [self.viewModel showListFor:focus.title
                          withCatID:focus.identifier];
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

@end
