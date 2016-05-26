//
//  AppDelegate.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/10.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "AppDelegate.h"
#import "YHSRootViewController.h"
#import "YHSNetworkingManager.h"

@interface AppDelegate ()
{
    BOOL _isFullScreen;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 设置根视图控制器
    [self setRootViewController];
    
    // 设置状态栏样式
    [self setStatusBarStyle];
    
    // 设置网络服务
    [self startNetWorkingService];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - 设置根视图控制器
- (void)setRootViewController
{
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    
    [[self window] makeKeyAndVisible];
    
    [[self window] setRootViewController:[[YHSRootViewController alloc] init]];
}


#pragma mark - 设置状态栏样式
- (void)setStatusBarStyle
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

#pragma mark - 非全屏状态禁止横屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    _isFullScreen = YES; // 测试用，可以旋转屏幕
    
    if (_isFullScreen) {
        return UIInterfaceOrientationMaskAll;
    }
    
    return UIInterfaceOrientationMaskPortrait; // 禁止横屏
}

#pragma mark - 设置网络服务
- (void)startNetWorkingService
{
    [YHSNetworkingManager sharedYHSNetworkingManagerInstance];
}

@end



