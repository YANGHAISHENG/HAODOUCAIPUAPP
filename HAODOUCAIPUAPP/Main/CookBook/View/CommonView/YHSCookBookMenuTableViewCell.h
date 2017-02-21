//
//  YHSCookBookMenuTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHSCookBookMenuTableViewCell : UITableViewCell

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 图片
 */
@property (nonnull, nonatomic, strong) UIImageView *coverImageView;

/**
 * 标题
 */
@property (nonnull, nonatomic, strong) UILabel *titleLabel;

/**
 * 收藏总数/浏览总数
 */
@property (nonnull, nonatomic, strong) UILabel *collectionLabel;

/**
 * 内容详情
 */
@property (nonnull, nonatomic, strong) UILabel *contentLabel;


/**
 * 分割线
 */
@property (nonnull, nonatomic, strong) UIView *separatorLineView;


@end



