//
//  YHSCategorySearchResultTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/19.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookMenuTableViewCell.h"
@class YHSCategorySearchResultModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_CATEGORY_SEARCH_RESULT;

@protocol YHSCategorySearchResultTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCategorySearchResultModel:(YHSCategorySearchResultModel *)model;
@end


@interface YHSCategorySearchResultTableViewCell : YHSCookBookMenuTableViewCell

@property (nonatomic, strong) YHSCategorySearchResultModel *model;

@property (nonatomic, strong) id<YHSCategorySearchResultTableViewCellDelegate> delegate;


@end

