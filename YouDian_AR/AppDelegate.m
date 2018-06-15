//
//  AppDelegate.m
//  YouDian_AR
//
//  Created by youdian on 2018/5/18.
//  Copyright © 2018年 YouDian. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+AR.h"
#import "MainViewController.h"
#import "ARScanViewController.h"
#import "UserInfoViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setWindowRootViewController];
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    return YES;
}


-(void)setWindowRootViewController{
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    MainViewController *main  = [MainViewController new];
    UINavigationController *mainNav =[[UINavigationController alloc]initWithRootViewController:main];
    ARScanViewController *ARScan = [ARScanViewController new];
    UINavigationController *scanNav = [[UINavigationController alloc]initWithRootViewController:ARScan];
    UserInfoViewController *userInfo = [UserInfoViewController new];
    UINavigationController *userNav  = [[UINavigationController alloc]initWithRootViewController:userInfo];
    mainNav.tabBarItem.title = @"首页";
    userNav.tabBarItem.title = @"个人中心";
    mainNav.tabBarItem.image = IMAGE_NAME(@"main_activity_main_no");
    mainNav.tabBarItem.selectedImage = [IMAGE_NAME(@"main_activity_main_yes") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    scanNav.tabBarItem.image = [IMAGE_NAME(@"ficon5") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    scanNav.tabBarItem.selectedImage = [IMAGE_NAME(@"ficon5") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    userNav.tabBarItem.image = IMAGE_NAME(@"main_activity_center_no");
    userNav.tabBarItem.selectedImage = [IMAGE_NAME(@"main_activity_center_yes") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBar.viewControllers = @[mainNav,scanNav,userNav];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:THEME_COLOR];
    [[UINavigationBar appearance]  setTranslucent:YES];
    [[UINavigationBar appearance]  setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    self.window.rootViewController = tabBar;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
