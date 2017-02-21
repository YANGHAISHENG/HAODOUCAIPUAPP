//
//  YHSBasicWithCollectShareBarItemViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

@interface YHSBasicWithCollectShareBarItemViewController : YHSBasicWithBackBarItemViewController

@property (nonatomic, strong) UIButton *shareNavItem; // 导航条分享选项

@property (nonatomic, strong) UIButton *collectNavItem; // 导航条收藏选项

#pragma mark - 触发分享按钮事件
- (void)naviShareBarButtonItemClicked:(UIButton *)button;


#pragma mark - 触发收藏按钮事件
- (void)naviCollectBarButtonItemClicked:(UIButton *)button;


@end
