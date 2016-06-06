//
//  YHSSquareMainViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

@interface YHSSquareMainViewController : YHSBasicWithBackBarItemViewController

@property (nonatomic, strong) UIView *searchAreaView; // 导航条搜索按钮区域
@property (nonatomic, strong) UIImageView *searchIconImageView; // 导航条搜索图标
@property (nonatomic, strong) UILabel *searchTitleLable; // 导航条搜索标题


@property (nonatomic, strong) UIButton *rightOneItem;

@end
