//
//  YHSCookBookDishDetailRelatedTagTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookDishModel, YHSCookBookDishTagsModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_RELATED_TAG;

@protocol YHSCookBookDishDetailRelatedTagTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithDishDetailTagsModel:(YHSCookBookDishTagsModel *)model;
@end


@interface YHSCookBookDishDetailRelatedTagTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookDishModel *model;

@property (nonatomic, strong) id<YHSCookBookDishDetailRelatedTagTableViewCellDelegate> delegate;

@end



