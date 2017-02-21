//
//  YHSBasicTabBarController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHSBasicTabBarController : UITabBarController

#pragma mark 添加子视图控制器
- (void)addChildViewController:(Class)viewControllerClass
                         title:(NSString *)title
               tabBarImageName:(NSString *)name
         tabBarSelectImageName:(NSString *)selectName;

#pragma mark 添加子导航控制器
- (void)addChildNavigationController:(Class)navigationControllerClass
                  rootViewController:(Class)rootViewControllerClass
                               title:(NSString *)title
                     tabBarImageName:(NSString *)name
               tabBarSelectImageName:(NSString *)selectName;

@end
