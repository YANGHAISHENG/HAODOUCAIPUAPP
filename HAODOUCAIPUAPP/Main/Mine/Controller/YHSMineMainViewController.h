//
//  YHSMineMainViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

@interface YHSMineMainViewController : YHSBasicWithBackBarItemViewController


@property (nonatomic, strong) UIButton *settingItem;

#pragma mark - 触发设置按钮事件
- (void)naviSettingBarButtonItemClicked:(UIButton *)button;


@end
