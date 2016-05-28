//
//  YHSCookBookDishDetailFoodMaterialTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/27.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookDishFoodMaterialModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_FOOD_MATERIAL;

@protocol YHSCookBookDishDetailFoodMaterialTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookDishDetailFoodMaterialModel:(YHSCookBookDishFoodMaterialModel *)model;
@end


@interface YHSCookBookDishDetailFoodMaterialTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookDishFoodMaterialModel *model;

@property (nonatomic, strong) id<YHSCookBookDishDetailFoodMaterialTableViewCellDelegate> delegate;

@end

