//
//  YHSCookBookDishDetailHeadTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/27.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookDishModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_HEADER;

@protocol YHSCookBookDishDetailHeadTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookDishModel:(YHSCookBookDishModel *)model;
- (void)pressRelationImageViewArea:(YHSCookBookDishModel *)model;
- (void)didFoodIntroLabelWithCookBookDishModel:(YHSCookBookDishModel *)model expandedAllWithIndexPath:(NSIndexPath *)index;
@end


@interface YHSCookBookDishDetailHeadTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookDishModel *model;

@property (nonatomic, strong) id<YHSCookBookDishDetailHeadTableViewCellDelegate> delegate;

- (void)setModel:(YHSCookBookDishModel *)model indexPath:(NSIndexPath *)indexPath;

@end


