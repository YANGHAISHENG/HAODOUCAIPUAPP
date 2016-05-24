//
//  YHSBasicViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicViewController.h"
#import "YHSSysConst.h"


@interface YHSBasicViewController ()

@end

@implementation YHSBasicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置背景色
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    
    // 自定义导航栏
    [self customNavigationBar];
}


#pragma mark - 自定义配置导航栏
- (void)customNavigationBar
{
    // 导航条背影图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation"]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    
    // 找出底部横线并隐藏
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    [self.navBarHairlineImageView setHidden:NO];
    
    // 设置 title 颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    // 使用自己的导航栏返回按钮
    {
        // 设置返回按钮标题
        [self setupNaviBackBarButtonItemTitle];
        
        // 隐藏原有的导航栏返回按钮
        [[self navigationItem] setHidesBackButton:NO];
        
        // 返回按钮标题
        NSString *title = [self naviBackBarButtonItemTitle];
        NSMutableAttributedString *attributedTitle = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedTitle addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, title.length)];
        [attributedTitle addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:FONT_SIZE_NAVIGATION] range:NSMakeRange(0, title.length)];
        CGSize titleSize = [title sizeWithAttributes:@{ NSFontAttributeName:[UIFont boldSystemFontOfSize:FONT_SIZE_NAVIGATION] }];
        
        // 自定义按钮
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, titleSize.width, titleSize.height)];
        [leftButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(naviBackBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置的按钮会显示在导航栏左边，返回按钮的位置
        UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        [[self navigationItem] setLeftBarButtonItem:backBarButtonItem  animated:NO];
    }
}

- (void)setupNaviBackBarButtonItemTitle {
    [self setNaviBackBarButtonItemTitle:@""];
}

- (void)naviBackBarButtonItemClicked:(UIButton *)button {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 实现找出底部横线的函数
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


#pragma mark - 提示信息
- (void)alertPromptMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@功能模块正在开发中，请使用其它功能！", message] preferredStyle:UIAlertControllerStyleAlert];
    
    // 取消
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancleAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



@end
