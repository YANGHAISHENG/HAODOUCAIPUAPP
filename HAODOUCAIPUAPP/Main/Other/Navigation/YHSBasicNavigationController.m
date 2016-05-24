//
//  YHSBasicNavigationController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicNavigationController.h"

@interface YHSBasicNavigationController ()

@end

@implementation YHSBasicNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    // 配置导航控制器
    [[self navigationBar] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor]}];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [viewController.navigationItem.backBarButtonItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated title:(NSString *)title
{
    
    [viewController setTitle:title];
    
    [self pushViewController:viewController animated:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
