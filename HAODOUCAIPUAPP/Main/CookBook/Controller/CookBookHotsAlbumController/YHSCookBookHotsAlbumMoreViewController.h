//
//  YHSCookBookHotsAlbumMoreViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSUITabPagerViewController.h"

@interface YHSCookBookHotsAlbumMoreViewController : YHSUITabPagerViewController <YHSUITabPagerDataSource, YHSUITabPagerDelegate>

/**
 * 导航栏区域
 */
@property (nonatomic, strong) UIButton *backNavItem; // 导航条返回选项
@property (nonatomic, strong) UILabel *titleNavItem; // 导航条标题选项
@property (nonatomic, strong) UIButton *searchNavItem; // 导航条搜索选项


#pragma mark - 触发返回按钮事件
- (void)naviBackBarButtonItemClicked:(UIButton *)button;


#pragma mark - 触发搜索按钮事件
- (void)naviSearchBarButtonItemClicked:(UIButton *)button;


@property (nonatomic, assign) NSInteger currentSelectedIndex;


@end
