//
//  YHSBasicWithSearchBarItemViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

@interface YHSBasicWithSearchBarItemViewController : YHSBasicWithBackBarItemViewController

@property (nonatomic, strong) UIButton *searchNavItem; // 导航条搜索选项

#pragma mark - 触发搜索按钮事件
- (void)naviSearchBarButtonItemClicked:(UIButton *)button;


@end
