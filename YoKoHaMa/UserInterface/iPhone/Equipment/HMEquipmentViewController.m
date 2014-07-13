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

@interface HMEquipmentViewController ()

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
    
    // Request data from SS, and Update view
    [self.focusView updateWithFocus:nil];
    
    NSMutableArray * focuses = [[NSMutableArray alloc] init];
    
#if DEBUG
    NSInteger numberOfFocuses = arc4random()%6 +1;
    for (int i = 0; i< numberOfFocuses; i++)
    {
        HMFocus * focus = [[HMFocus alloc] init];
        
        focus.title = [NSString stringWithFormat:@"Item %d", i ];
        focus.identifier = @(i);
        focus.imageURLString = nil;
        
        [focuses addObject:focus];
    }
#endif
    [self.gridContent updateWithFocuses:focuses];

    [self.focusView.openSignal subscribeNext:^(id x) {
        NSLog(@"Open focus: %@", x);
    }];
    
    [self.listMenu.openSignal subscribeNext:^(id x) {
        NSLog(@"List Menu selected: %@", x);
    }];
    
    [self.gridContent.openSignal subscribeNext:^(id x) {
        NSLog(@"Content Menu selected: %@", x);
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
