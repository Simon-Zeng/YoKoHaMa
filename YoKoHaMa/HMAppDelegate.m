//
//  HMAppDelegate.m
//  YoKoHaMa
//
//  Created by zeng songgen on 14-7-7.
//  Copyright (c) 2014年 Conggen. All rights reserved.
//

#import "HMAppDelegate.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#import "HMTabBarController.h"
#import "HMNavigationController.h"

#import "HMLauncherViewController.h"
#import "HMRouteViewController.h"
#import "HMEquipmentViewController.h"
#import "HMAssistantViewController.h"
#import "HMMoreViewController.h"

@implementation HMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [UMSocialData setAppKey:kUMengAppKey];
    
    //设置微信AppId，和分享url
    [UMSocialWechatHandler setWXAppId:kWeChatAppID url:kWeChatCallBackURL];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBackground"]
                                       forBarMetrics:UIBarMetricsDefault];
    [[UILabel appearance] setTextColor:[UIColor whiteColor]];
    
    NSDictionary * barButtonItemTitleAttribute = @{
                                                   NSForegroundColorAttributeName: [UIColor whiteColor]
                                                   };
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:barButtonItemTitleAttribute
                                                                                            forState:UIControlStateNormal];
    
    UIColor * cursorColor = [UIColor blackColor];
    
    [[UITextField appearance] setTintColor:cursorColor];
    [[UITextView appearance] setTintColor:cursorColor];
    
    // Setup window
    self.window.tintColor = [UIColor whiteColor];
    
    // Set up view controllers
    NSMutableArray * viewControllers = [NSMutableArray array];
    
    HMRouteViewController * routeViewController = [[HMRouteViewController alloc] init];
    routeViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"优路线", nil)
                                                                   image:[UIImage imageNamed:@"Tab-Route"]
                                                           selectedImage:[UIImage imageNamed:@"Tab-Route"]];
    
    [viewControllers addObject:routeViewController];
    
    HMEquipmentViewController * equipViewController = [[HMEquipmentViewController alloc] init];
    equipViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"优装备", nil)
                                                                   image:[UIImage imageNamed:@"Tab-Equipment"]
                                                           selectedImage:[UIImage imageNamed:@"Tab-Equipment"]];
    [viewControllers addObject:equipViewController];
    
    HMAssistantViewController * assisViewController = [[HMAssistantViewController alloc] init];
    assisViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"优助手", nil)
                                                                   image:[UIImage imageNamed:@"Tab-Assistant"]
                                                           selectedImage:[UIImage imageNamed:@"Tab-Assistant"]];
    [viewControllers addObject:assisViewController];

    HMMoreViewController * moreViewController = [[HMMoreViewController alloc] init];
    moreViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"更多", nil)
                                                                  image:[UIImage imageNamed:@"Tab-More"]
                                                          selectedImage:[UIImage imageNamed:@"Tab-More"]];
    [viewControllers addObject:moreViewController];

    UITabBarController * rootTabController = [[HMTabBarController alloc] init];
    [rootTabController setViewControllers:viewControllers];
    
    HMNavigationController * rootNavController = [[HMNavigationController alloc] initWithRootViewController:rootTabController];
    rootNavController.navigationBarHidden = YES;
    // Push launcher
    HMLauncherViewController * laucherViewController = [[HMLauncherViewController alloc] init];
    [rootNavController pushViewController:laucherViewController animated:NO];
    
    self.window.rootViewController = rootNavController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Umeng share
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

@end
