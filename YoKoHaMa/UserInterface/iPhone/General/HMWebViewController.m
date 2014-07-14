//
//  HMWebViewController.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMWebViewController.h"

#import "SVProgressHUD.h"

@interface HMWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation HMWebViewController

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
    
    UINavigationItem * topItem = [[UINavigationItem alloc] init];
    
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"Button-Back"]
                forState:UIControlStateNormal];
    UIBarButtonItem * logoItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    topItem.leftBarButtonItem = logoItem;
    
    UIButton * shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"Button-Share"]
                forState:UIControlStateNormal];
    UIBarButtonItem * dotItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    topItem.rightBarButtonItem = dotItem;
    
    CGRect bounds = self.view.bounds;
    UINavigationBar * navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
    navigationBar.items = @[topItem];
    
    [self.view addSubview:navigationBar];
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, bounds.size.width, bounds.size.height-44)];
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
    self.webView = webView;
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


#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"加载中...", nil)
                         maskType:SVProgressHUDMaskTypeGradient];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:NSLocalizedString(@"加载失败.\n错误：:%@", nil),error]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

#pragma mark -
- (void)loadURL:(NSURL *)url
{
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:url];
    
    [self.webView loadRequest:request];
}

@end
