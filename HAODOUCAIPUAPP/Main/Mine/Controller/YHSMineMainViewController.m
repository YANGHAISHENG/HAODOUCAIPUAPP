//
//  YHSMineMainViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSMineMainViewController.h"

@interface YHSMineMainViewController ()

@end

@implementation YHSMineMainViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navBarHairlineImageView setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navBarHairlineImageView setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
}


#pragma mark - 自定义配置导航栏
- (void)customNavigationBar
{
    [super customNavigationBar];
    
    WEAKSELF(weakSelf);
    
    // 自定义导航栏
    if (self.navigationController) {
        
        CGFloat margin = 10;
        CGFloat width = 26.0; // 最大值为44
        
        // 1.自定义导航条
        self.navBarCustomView = [[YHSNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
        [self.navBarCustomView setBackgroundColor:COLOR_NAVIGATION_BAR_WHITE];
        [self.navigationItem setTitleView:self.navBarCustomView];
        
        // 2.设置
        UIButton *settingItem = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-margin-width, ((44-width)/2.0), width, width)];
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:width/2.0];
            [button setAdjustsImageWhenHighlighted:NO];
            UIImage *image = [[[UIImage imageNamed:@"ico_user_operate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] transformtoSize:CGSizeMake(width, width)];
            [button setImage:image forState:UIControlStateNormal];
            [button setImage:image forState:UIControlStateSelected];
            [button addTarget:self action:@selector(naviSettingBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.navBarCustomView addSubview:button];
            
            button;
        });
        self.settingItem  = settingItem;
        
        // 3.标题
        self.title = @"我的";
        UILabel *titleNavItem = ({
            UILabel *label = [[UILabel alloc] init];
            [label setText:self.title];
            [label setTextColor:COLOR_NAVIGATION_BAR_TITLE_YELLOW];
            [label setFont:[UIFont boldSystemFontOfSize:FONT_SIZE_NAVIGATION_20]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [self.navBarCustomView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.navBarCustomView.mas_centerX);
                make.centerY.equalTo(weakSelf.navBarCustomView.mas_centerY);
                make.top.equalTo(weakSelf.navBarCustomView.mas_top).offset(0.0);
                make.bottom.equalTo(weakSelf.navBarCustomView.mas_bottom).offset(0.0);
            }];
            
            label;
        });
        self.titleNavItem  = titleNavItem;
        
    }
    
}


#pragma mark - 触发设置按钮事件
- (void)naviSettingBarButtonItemClicked:(UIButton *)button
{
    [self alertPromptMessage:@""];
}







@end
