//
//  YHSCookBookDishPictureDetailStepTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookDishStepsModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_STEP;

@protocol YHSCookBookDishPictureDetailStepTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithDishPictureStepModel:(YHSCookBookDishStepsModel *)model;
@end


@interface YHSCookBookDishPictureDetailStepTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookDishStepsModel *model;

@property (nonatomic, strong) id<YHSCookBookDishPictureDetailStepTableViewCellDelegate> delegate;

@end



