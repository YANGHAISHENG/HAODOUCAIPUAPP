//
//  YHSBasicTabBarController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicTabBarController.h"
#import "YHSSysConst.h"

@interface YHSBasicTabBarController ()

@end

@implementation YHSBasicTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // default view color
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 添加子控制器
    [self addChildControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 添加视图控制器
- (void)addChildViewController:(Class)viewControllerClass
                         title:(NSString *)title
               tabBarImageName:(NSString *)name
         tabBarSelectImageName:(NSString *)selectName
{
    // 创建视图控制器
    UIViewController *viewController = [[viewControllerClass alloc] init];
    if (title && title.length > 0) {
        viewController.title = title;
    }
    viewController.automaticallyAdjustsScrollViewInsets = NO;
    viewController.tabBarItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    // 主标签控制器中添加视图控制器
    [self addChildViewController:viewController];
}

#pragma mark 添加导航控制器
- (void)addChildNavigationController:(Class)navigationControllerClass
                  rootViewController:(Class)rootViewControllerClass
                               title:(NSString *)title
                     tabBarImageName:(NSString *)name
               tabBarSelectImageName:(NSString *)selectName
{
    // 创建视图控制器
    UIViewController *rootViewController = [[rootViewControllerClass alloc] init];
    rootViewController.automaticallyAdjustsScrollViewInsets = NO;
    
    // 创建导航控制器
    UINavigationController *naviViewController = [[navigationControllerClass  alloc] initWithRootViewController:rootViewController];
    naviViewController.automaticallyAdjustsScrollViewInsets = NO;
    // 字体
    naviViewController.tabBarItem.title = title;
    [naviViewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:FONT_SIZE_TABBAR],
                                                            NSForegroundColorAttributeName:[UIColor colorWithRed:0.58 green:0.58 blue:0.58 alpha:1.00]}
                                                 forState:UIControlStateNormal];
    [naviViewController.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:FONT_SIZE_TABBAR],
                                                            NSForegroundColorAttributeName:[UIColor colorWithRed:0.49 green:0.71 blue:0.27 alpha:1.00]}
                                                 forState:UIControlStateSelected];
    // 标签栏图片
    naviViewController.tabBarItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    naviViewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 主标签控制器中添加子导航控制器
    [self addChildViewController:naviViewController];
}


#pragma mark 设置子控制器，子类继承并重写
- (void)addChildControllers
{
    // add view controllers in subviews
    
}


@end
