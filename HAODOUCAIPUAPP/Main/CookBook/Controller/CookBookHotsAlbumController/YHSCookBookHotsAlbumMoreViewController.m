//
//  YHSCookBookHotsAlbumMoreViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "Masonry.h"

#import "YHSCookBookHotsAlbumMoreViewController.h"
#import "YHSCookBookHotsAlbumTabRecommendViewController.h"
#import "YHSCookBookHotsAlbumTabAllViewController.h"
#import "YHSSysMacro.h"
#import "YHSSysConst.h"
#import "YHSUtilsMacro.h"
#import "UIImage+Scale.h"
#import "YHSNavigationBarTitleView.h"
#import "YHSBasicSearchViewController.h"


@implementation YHSCookBookHotsAlbumMoreViewController


#pragma mark - View Controller Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDataSource:self];
    [self setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadData];
}


#pragma mark - Tab Pager Data Source

- (NSInteger)numberOfViewControllers {
    return 2;
}

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    
    if (0 == index) {
        YHSCookBookHotsAlbumTabRecommendViewController *recommendController = [[YHSCookBookHotsAlbumTabRecommendViewController alloc] init];
        return recommendController;
    } else if (1 == index) {
        YHSCookBookHotsAlbumTabAllViewController *allController = [[YHSCookBookHotsAlbumTabAllViewController alloc] init];
        return allController;
    }
    
    return nil;
}


- (UIView *)viewForTabAtIndex:(NSInteger)index
{
    UILabel *tablabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40.0)];
    [tablabel setTextAlignment:NSTextAlignmentCenter];
    [tablabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f]];
    
    if (0 == index) {
        [tablabel setText:@"推荐"];
    } else if (1 == index) {
        [tablabel setText:@"全部"];
    }
    
    return tablabel;
}

- (UIColor *)tabColor {
    return [UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00];
}

- (UIColor *)tabBackgroundColor {
    return [UIColor whiteColor];
}

#pragma mark - Tab Pager Delegate

- (void)tabPager:(YHSUITabPagerViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index {
    YHSLogLight(@"Will transition from tab %ld to %ld", [self selectedIndex], (long)index);
}

- (void)tabPager:(YHSUITabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index {
    YHSLogLight(@"Did transition to tab %ld", (long)index);
}


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
        
        
        // 3.导航条搜索选项
        UIButton *searchNavItem = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-margin-width, ((44-width)/2.0), width, width)];
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:width/2.0];
            [button setAdjustsImageWhenHighlighted:NO];
            UIImage *image = [[[UIImage imageNamed:@"action_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] transformtoSize:CGSizeMake(width-10, width-10)];
            [button setImage:image forState:UIControlStateNormal];
            [button setImage:image forState:UIControlStateSelected];
            [button addTarget:self action:@selector(naviSearchBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.navBarCustomView addSubview:button];
            
            /* 如果使用Masonry，从其它页面返回时，导航栏有跳动现象
             [button mas_makeConstraints:^(MASConstraintMaker *make) {
             make.top.equalTo(weakSelf.navBarCustomView.mas_top).offset((44-width)/2.0);
             make.left.equalTo(weakSelf.navBarCustomView.mas_right).offset(-margin-width);
             make.size.mas_equalTo(CGSizeMake(width, width));
             }];
             */
            
            button;
        });
        self.searchNavItem  = searchNavItem;
        
        
        // 4.标题
        UILabel *titleNavItem = ({
            UILabel *label = [[UILabel alloc] init];
            [label setText:self.title];
            [label setTextColor:COLOR_NAVIGATION_BAR_TITLE];
            [label setFont:[UIFont boldSystemFontOfSize:FONT_SIZE_NAVIGATION]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [self.navBarCustomView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.navBarCustomView.mas_top).offset((44-width)/2.0);
                make.left.equalTo(weakSelf.backNavItem.mas_right).offset(margin);
                make.bottom.equalTo(weakSelf.navBarCustomView.mas_bottom).offset(-(44-width)/2.0);
                make.right.equalTo(weakSelf.searchNavItem.mas_left).offset(-margin);
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




@end
