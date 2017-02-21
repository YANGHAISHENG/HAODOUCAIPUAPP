//
//  YHSCookBookDishDetailProductTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookDishModel, YHSCookBookDishProductModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_PRODUCT;

@protocol YHSCookBookDishDetailProductTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithDishDetailProductModel:(YHSCookBookDishProductModel *)model;
- (void)didClickElementOfCellWithAllProductModel:(YHSCookBookDishModel *)model;
@end


@interface YHSCookBookDishDetailProductTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookDishModel *model;

@property (nonatomic, strong) id<YHSCookBookDishDetailProductTableViewCellDelegate> delegate;

@end



