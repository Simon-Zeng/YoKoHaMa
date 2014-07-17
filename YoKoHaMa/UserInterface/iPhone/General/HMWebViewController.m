//
//  HMWebViewController.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-13.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMWebViewController.h"

#import "SVProgressHUD.h"
#import "HMNavigationView.h"

#import "HMHelper.h"
#import "HMCommonViewModel.h"

@interface HMWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) HMCommonViewModel * viewModel;

@property (nonatomic, strong) HMNavigationView * navigationBar;
@property (nonatomic, strong) UIWebView * webView;

@end

@implementation HMWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.viewModel = [[HMCommonViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect bounds = self.view.bounds;
    
    self.navigationBar = [[HMNavigationView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 44)];
    self.navigationBar.shareButtonEnabled = YES;
    [self.view addSubview:self.navigationBar];

    
    @weakify(self);
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
            HMContentCategory category = self.category;
            
            NSString * message = nil;
            NSString * urlLink = self.webView.request.URL.absoluteString;
            
            switch (category)
            {
                case HMContentCategoryRoute:
                {
                    message = [NSString stringWithFormat:NSLocalizedString(@"优科豪马自驾指南优路线推荐: %@", nil), urlLink];
                }
                    break;
                case HMContentCategoryEquipment:
                {
                    message = [NSString stringWithFormat:NSLocalizedString(@"优科豪马自驾指南优设备推荐: %@", nil), urlLink];
                }
                    break;
                case HMContentCategoryAssistant:
                {
                    message = [NSString stringWithFormat:NSLocalizedString(@"优科豪马自驾指南优助手推荐: %@", nil), urlLink];
                }
                    break;
                case HMContentCategoryMore:
                {
                    message = [NSString stringWithFormat:NSLocalizedString(@"优科豪马自驾指南更多推荐: %@", nil), urlLink];
                }
                    break;
                default:
                    break;
            }
            
            if (message)
            {
                [self.viewModel shareURLString:self.webView.request.URL.absoluteString message:message];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView
{
    if (!_webView)
    {
        CGRect bounds = self.view.bounds;
        
        UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, bounds.size.width, bounds.size.height-44)];
        webView.scalesPageToFit = YES;
        webView.delegate = self;
        
        [self.view addSubview:webView];
        
        self.webView = webView;
    }
    
    return _webView;
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
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

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
