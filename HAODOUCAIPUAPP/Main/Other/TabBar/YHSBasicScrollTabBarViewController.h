//
//  YHSBasicScrollTabBarViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/1.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "WXTabBarController.h"

@interface YHSBasicScrollTabBarViewController : WXTabBarController

#pragma mark 添加子导航控制器
- (void)addChildNavigationController:(Class)navigationControllerClass
                  rootViewController:(Class)rootViewControllerClass
                               title:(NSString *)title
                     tabBarImageName:(NSString *)name
               tabBarSelectImageName:(NSString *)selectName;

@end
