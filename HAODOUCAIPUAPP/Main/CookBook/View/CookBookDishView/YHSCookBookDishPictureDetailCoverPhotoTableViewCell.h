//
//  YHSCookBookDishPictureDetailCoverPhotoTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookDishModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_COVER_PHOTO;

@protocol YHSCookBookDishPictureDetailCoverPhotoTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithDishPictureDetailCoverPhotoModel:(YHSCookBookDishModel *)model;
@end


@interface YHSCookBookDishPictureDetailCoverPhotoTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookDishModel *model;

@property (nonatomic, strong) id<YHSCookBookDishPictureDetailCoverPhotoTableViewCellDelegate> delegate;

@end


