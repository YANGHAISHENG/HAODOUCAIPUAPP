//
//  YHSBackHomeMainViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

@interface YHSBackHomeMainViewController : YHSBasicWithBackBarItemViewController

@property (nonatomic, strong) UILabel *loactionNavItem;

@property (nonatomic, strong) UIButton *allItem;

#pragma mark - 触发全部按钮事件
- (void)naviLocationBarButtonItemClicked:(UIButton *)button;

#pragma mark - 触发全部按钮事件
- (void)naviAllBarButtonItemClicked:(UIButton *)button;

@end
