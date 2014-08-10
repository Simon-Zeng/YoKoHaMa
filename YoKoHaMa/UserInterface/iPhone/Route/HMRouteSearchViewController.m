//
//  HMRouteSearchViewController.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-8-10.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMRouteSearchViewController.h"

#import "HMSearchView.h"
#import "HMNetwork.h"

@interface HMRouteSearchViewController ()

@property (nonatomic, strong) HMSearchView * searchView;

@end

@implementation HMRouteSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.searchView = [[HMSearchView alloc] initWithFrame:CGRectMake(0, 44, 320, 75)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view addSubview:self.searchView];
    
    @weakify(self);
    [self.searchView.searchSignal subscribeNext:^(id x) {
        if (x && [x isKindOfClass:[NSString class]])
        {
            @strongify(self);
            
            NSString * baseURLString = [HMNetwork sharedNetwork].baseURL.absoluteString;
            
            NSMutableString * pathComponent = [NSMutableString stringWithString:@"/index.php?a=lists&catid=1"];
            
            if ([x length] > 0)
            {
                [pathComponent appendFormat:@"&keyword=%@", [x stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"&="]]];
            }
            
            NSString * urlString = [baseURLString stringByAppendingPathComponent:pathComponent];
            
            [self loadURL:[NSURL URLWithString:urlString]];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Update UI layout
    CGRect newFrame = self.webView.frame;
    newFrame.size.height -= self.searchView.bounds.size.height;
    newFrame.origin.y += self.searchView.bounds.size.height;
    
    self.webView.frame = newFrame;
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
