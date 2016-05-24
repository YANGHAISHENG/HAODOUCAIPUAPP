//
//  YHSBasicWithBackBarItemViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicNetworkReachabilityViewController.h"

@interface YHSBasicWithBackBarItemViewController : YHSBasicNetworkReachabilityViewController

@property (nonatomic, strong) UIButton *backNavItem; // 导航条返回选项

@property (nonatomic, strong) UILabel *titleNavItem; // 导航条标题选项


#pragma mark - 触发返回按钮事件
- (void)naviBackBarButtonItemClicked:(UIButton *)button;

#pragma mark - 设置返回标题
- (NSString *)naviBackBarButtonItemTitle;

@end
