//
//  HMLauncherViewController.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMLauncherViewController.h"

#import "HMLauncherView.h"

@interface HMLauncherViewController ()

@property (nonatomic, strong) HMLauncherView * launcherView;

@end

@implementation HMLauncherViewController

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
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    UIView * aView = [[UIView alloc] initWithFrame:bounds];
    
    NSArray * laucherImages = nil;
    
    if ([self firstLaunch])
    {
        laucherImages = @[[UIImage imageNamed:@"Launcher1"],
                          [UIImage imageNamed:@"Launcher2"],
                          [UIImage imageNamed:@"Launcher3"]
                          ];
    }
    else
    {
        laucherImages = @[[UIImage imageNamed:@"NormalLaucher"]];
    }
    
    HMLauncherView * launcherView = [[HMLauncherView alloc] initWithLaunchImages:laucherImages];
    launcherView.frame = bounds;
    [launcherView layoutSubviews];
    
    [aView addSubview:launcherView];
    
    self.launcherView = launcherView;
    
    self.view = aView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    // Do any additional setup after loading the view.
    [self.launcherView setNeedsLayout];
    
    @weakify(self);
    [self.launcherView.closeSignal subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            });

        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [UIApplication sharedApplication].statusBarHidden = NO;
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

- (BOOL)firstLaunch
{
    BOOL laterLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"Non-firstLaunch"];
    
    if (!laterLaunch)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Non-firstLaunch"];
    }
    
    return !laterLaunch;
}

@end
