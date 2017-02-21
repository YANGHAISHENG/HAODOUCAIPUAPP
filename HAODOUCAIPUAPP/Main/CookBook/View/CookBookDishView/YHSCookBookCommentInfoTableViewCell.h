//
//  YHSCookBookCommentInfoTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookCommentModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_COMMENT;

@protocol YHSCookBookCommentInfoTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCommentModel:(YHSCookBookCommentModel *)model;
@end


@interface YHSCookBookCommentInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookCommentModel *model;

@property (nonatomic, strong) id<YHSCookBookCommentInfoTableViewCellDelegate> delegate;

@end


