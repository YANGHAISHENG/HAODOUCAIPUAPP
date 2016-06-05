//
//  YHSBackHomeMainViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

typedef NS_ENUM(NSInteger, YHSBackHomeTableSection) {
    YHSBackHomeTableSectionAD, // 广告横幅
    YHSBackHomeTableSectionFoodieFavoriteGoods, // 吃货最爱
    YHSBackHomeTableSectionGoodList, // 逛逛商品
};


@interface YHSBackHomeMainViewController : YHSBasicWithBackBarItemViewController

@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, assign) NSUInteger RecommendType; // 类型

@property (nonatomic, strong) UILabel *loactionNavItem;

@property (nonatomic, strong) UIButton *allItem;

#pragma mark - 触发全部按钮事件
- (void)naviLocationBarButtonItemClicked:(UIButton *)button;

#pragma mark - 触发全部按钮事件
- (void)naviAllBarButtonItemClicked:(UIButton *)button;

@end
