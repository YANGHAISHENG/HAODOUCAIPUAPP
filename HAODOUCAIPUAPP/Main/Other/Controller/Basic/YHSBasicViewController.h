//
//  YHSBasicViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHSBasicViewController : UIViewController

@property (nonatomic,strong) UIView *navBarCustomView; // 自定义导航栏

@property (nonatomic,weak) UIImageView *navBarHairlineImageView; // 系统自带导航栏底部1px横线

@property (nonatomic,copy) NSString *naviBackBarButtonItemTitle; // 自定义导航栏返回按钮标题

#pragma mark - 自定义配置导航栏
- (void)customNavigationBar;

#pragma mark - 实现找出底部横线的函数
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;

- (void)setupNaviBackBarButtonItemTitle;

- (void)naviBackBarButtonItemClicked:(UIButton *)button;



#pragma mark - 提示信息
- (void)alertPromptMessage:(NSString *)message;


@end
