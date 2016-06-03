//
//  YHSBackHomeMainViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSAllButton.h"
#import "YHSPopMenu.h"

#import "YHSBackHomeMainViewController.h"
#import "YHSCookBookSearchViewController.h"


@interface YHSBackHomeMainViewController ()

@property (nonatomic, strong) UIView *searchAreaView; // 导航条搜索按钮区域
@property (nonatomic, strong) UIImageView *searchIconImageView; // 导航条搜索图标
@property (nonatomic, strong) UILabel *searchTitleLable; // 导航条搜索标题
@property (nonatomic, assign) NSInteger allItemCurrentIndex; // 全部按钮当前选中项的下标

@end

@implementation YHSBackHomeMainViewController




#pragma mark - 自定义配置导航栏
- (void)customNavigationBar
{
    [super customNavigationBar];
    
    // 自定义导航栏
    if (self.navigationController) {
        
        CGFloat margin = 10;

        // 1.自定义导航条
        self.navBarCustomView = [[YHSNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
        [self.navBarCustomView setBackgroundColor:COLOR_NAVIGATION_BAR_WHITE];
        [self.navigationItem setTitleView:self.navBarCustomView];
        
        // 2.到家
        CGFloat iconWidth = 50.0f;
        CGFloat iconHeight = 22.0f;
        UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(margin, ((HEIGHT_NAVIGATION_BAR-iconHeight)/2.0), iconWidth, iconHeight)];
        [leftIcon setImage:[UIImage imageNamed:@"logo_daojia"]];
        [leftIcon.layer setMasksToBounds:YES];
        [self.navBarCustomView addSubview:leftIcon];

        // 3.定位
        CGFloat locationWidth = 35.0;
        UILabel *loactionNavItem = ({
            UILabel *label = [[UILabel alloc] init];
            [label setText:@"[武汉]"];
            [label setFont:[UIFont systemFontOfSize:12.0]];
            [label setTextColor:COLOR_NAVIGATION_BAR_TITLE];
            [label setUserInteractionEnabled:YES];
            [self.navBarCustomView addSubview:label];
            
            // 添加点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviLocationBarButtonItemClicked:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1，注意在iOS中很少用双击操作
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [label addGestureRecognizer:tapGesture];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftIcon.mas_right).offset(margin/2.0);
                make.bottom.equalTo(leftIcon.mas_bottom).offset(0.0);
                make.size.mas_equalTo(CGSizeMake(locationWidth, 15));
            }];
            
            label;
        });
        self.loactionNavItem  = loactionNavItem;
        
        // 3.全部
        CGFloat allWidth = 50.0; // 最大值为44
        CGFloat allHeight = 25.0;
        UIButton *allItem = ({
            YHSAllButton *button = [[YHSAllButton alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-margin/2.0-allWidth, ((HEIGHT_NAVIGATION_BAR-allHeight)/2.0), allWidth, allHeight)];
            [button.layer setMasksToBounds:YES];
            [button setAdjustsImageWhenHighlighted:NO];
            [button setTitle:@"全部" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
            [button setTitleColor:COLOR_NAVIGATION_BAR_TITLE_YELLOW forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"btn_weaken_arrowdown_orange"] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(naviAllBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.navBarCustomView addSubview:button];
            
            button;
        });
        self.allItem  = allItem;
        _allItemCurrentIndex = 0;
        
        // 4.导航条搜索按钮区域
        {
            // 4.1搜索区域主容器
            UIView *searchAreaView = ({
               UIView *searchAreaView = [[UIView alloc] initWithFrame:CGRectMake(2*margin+iconWidth+locationWidth, 7, self.navigationController.navigationBar.frame.size.width-iconWidth-locationWidth-allWidth-3.5*margin, self.navigationController.navigationBar.frame.size.height-14)];
                [searchAreaView.layer setBorderWidth:1.0f];
                [searchAreaView.layer setCornerRadius:6.0f];
                [searchAreaView.layer setBorderColor:COLOR_NAVIGATION_BAR_SEARCH.CGColor];
                [searchAreaView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]];
                [self.navBarCustomView addSubview:searchAreaView];
                
                // 添加点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressSearchArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1，注意在iOS中很少用双击操作
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [searchAreaView addGestureRecognizer:tapGesture];
                
                searchAreaView;
            });
            self.searchAreaView  = searchAreaView;
            
            // 4.2导航条搜索图标
            UIImageView *searchIconImageView = ({
                UIImageView *searchIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 22, 22)];
                [searchIconImageView setImage:[UIImage imageNamed:@"action_search_gray"]];
                [searchAreaView addSubview:searchIconImageView];
                
                searchIconImageView;
            });
            self.searchIconImageView = searchIconImageView;
            
            // 4.3导航条搜索标题
            UILabel *searchTitleLable = ({
                UILabel *searchTitleLable = [[UILabel alloc] init];
                [searchTitleLable setText:@"搜索商品"];
                [searchTitleLable setTextColor:COLOR_NAVIGATION_BAR_SEARCH_TITLE_GRAY];
                [searchTitleLable setFont:[UIFont boldSystemFontOfSize:13.0]];
                [searchAreaView addSubview:searchTitleLable];
                
                [searchTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(searchAreaView.mas_top).offset(5);
                    make.left.equalTo(searchIconImageView.mas_right).offset(5);
                    make.right.equalTo(searchAreaView.mas_right).offset(-5);
                    make.height.equalTo(@22);
                }];
                
                searchTitleLable;
            });
            self.searchTitleLable = searchTitleLable;
        }

        
        
    }
    
}

#pragma mark - 触发导航栏按钮事件

// 触发全部按钮事件
- (void)naviLocationBarButtonItemClicked:(UITapGestureRecognizer *)gesture
{
    [self alertPromptMessage:@""];
}

// 触发搜索按钮事件
- (void)pressSearchArea:(UITapGestureRecognizer *)gesture
{
    YHSCookBookSearchViewController *searchViewController = [YHSCookBookSearchViewController new];
    [self.navigationController pushViewController:searchViewController animated:YES];
}

// 触发全部按钮事件
- (void)naviAllBarButtonItemClicked:(UIButton *)button
{
    [button setImage:[UIImage imageNamed:@"btn_weaken_arrowup_orange"] forState:UIControlStateNormal];
    
    NSArray<NSString *> *itemTiltes = @[@"全部", @"附近", @"全国"];
    [YHSPopMenu popFromView:self.allItem rect:CGRectMake(0, 0, 50, 40*itemTiltes.count) itemTitles:itemTiltes selectedIndex:_allItemCurrentIndex dismiss:^(NSInteger selected) {
        
        _allItemCurrentIndex = selected;
        
        [button setTitle:itemTiltes[selected] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_weaken_arrowdown_orange"] forState:UIControlStateNormal];
    }];

}




@end
