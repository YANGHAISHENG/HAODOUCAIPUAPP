//
//  YHSBasicWithBackBarItemViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"
#import "YHSBasicSearchViewController.h"

@implementation YHSBasicWithBackBarItemViewController


#pragma mark - 自定义配置导航栏
- (void)customNavigationBar
{
    [super customNavigationBar];
    
    WEAKSELF(weakSelf);
    
    // 自定义导航栏
    if (self.navigationController) {
        
        CGFloat margin = 10;
        CGFloat width = 36.0; // 最大值为44
        
        // 1.自定义导航条
        self.navBarCustomView = [[YHSNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
        [self.navBarCustomView setBackgroundColor:COLOR_NAVIGATION_BAR];
        [self.navigationItem setTitleView:self.navBarCustomView];
        
        
        // 2.导航条返回选项
        UIButton *backNavItem = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(margin, ((44-width)/2.0), width, width)];
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:width/2.0];
            [button setAdjustsImageWhenHighlighted:NO];
            UIImage *image = [[[UIImage imageNamed:@"btn_header_back_sec"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] transformtoSize:CGSizeMake(width, width)];
            [button setImage:image forState:UIControlStateNormal];
            [button setImage:image forState:UIControlStateSelected];
            [button addTarget:self action:@selector(naviBackBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.navBarCustomView addSubview:button];
            
            /* 如果使用Masonry，从其它页面返回时，导航栏有跳动现象
             [button mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(weakSelf.navBarCustomView.mas_top).offset((44-width)/2.0);
             make.left.equalTo(weakSelf.navBarCustomView.mas_left).offset(margin);
             make.size.mas_equalTo(CGSizeMake(width, width));
             }];
             */
            
            button;
        });
        self.backNavItem  = backNavItem;
        
        // 3.标题
        UILabel *titleNavItem = ({
            
            NSString *title = [self naviBackBarButtonItemTitle];
            title = title.length > 0 ? title : self.title;
            
            UILabel *label = [[UILabel alloc] init];
            [label setText:title];
            [label setTextColor:COLOR_NAVIGATION_BAR_TITLE];
            [label setFont:[UIFont boldSystemFontOfSize:FONT_SIZE_NAVIGATION]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [self.navBarCustomView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.navBarCustomView.mas_top).offset((44-width)/2.0);
                make.left.equalTo(weakSelf.backNavItem.mas_right).offset(margin);
                make.bottom.equalTo(weakSelf.navBarCustomView.mas_bottom).offset(-(44-width)/2.0);
                make.right.equalTo(weakSelf.navBarCustomView.mas_right).offset(-margin);
            }];
            
            label;
        });
        self.titleNavItem  = titleNavItem;
        
    }
    
}


#pragma mark - 触发返回按钮事件
- (void)naviBackBarButtonItemClicked:(UIButton *)button
{
    [[self navigationController] popViewControllerAnimated:YES];
}


#pragma mark - 触发搜索按钮事件
- (void)naviSearchBarButtonItemClicked:(UIButton *)button
{
    YHSBasicSearchViewController *searchViewController = [YHSBasicSearchViewController new];
    [self.navigationController pushViewController:searchViewController animated:YES];
}


#pragma mark - 设置返回标题
- (NSString *)naviBackBarButtonItemTitle
{
    return @"";
}

@end
