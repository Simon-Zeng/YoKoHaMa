//
//  HMTabBarController.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-12.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMTabBarController.h"

@interface HMTabBarController ()

@end

@implementation HMTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.barTintColor = [UIColor colorWithRed:0./255
                                               green:2.0/255
                                                blue:11.0/255
                                               alpha:1.0];
    
    UINavigationItem * topItem = [[UINavigationItem alloc] init];
    
    
    UIImageView * logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    UIBarButtonItem * logoItem = [[UIBarButtonItem alloc] initWithCustomView:logoView];
    
    topItem.leftBarButtonItem = logoItem;
    
    UIImageView * dotView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Nav-Dot"]];
    UIBarButtonItem * dotItem = [[UIBarButtonItem alloc] initWithCustomView:dotView];
    
    topItem.rightBarButtonItem = dotItem;
    
    CGRect bounds = self.view.bounds;
    UINavigationBar * navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(-10, 0, bounds.size.width+20, 44)];
    navigationBar.items = @[topItem];
    
    [self.view addSubview:navigationBar];
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
