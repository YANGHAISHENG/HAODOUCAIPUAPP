//
//  YHSCookBookSearchDetailTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/20.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookMenuTableViewCell.h"
@class YHSCookBookSearchDetailModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_SEARCH_DETAIL;

@protocol YHSCookBookSearchDetailTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookSearchDetailModel:(YHSCookBookSearchDetailModel *)model;
@end


@interface YHSCookBookSearchDetailTableViewCell : YHSCookBookMenuTableViewCell
@property (nonatomic, strong) YHSCookBookSearchDetailModel *model;
@property (nonatomic, strong) id<YHSCookBookSearchDetailTableViewCellDelegate> delegate;
@end

