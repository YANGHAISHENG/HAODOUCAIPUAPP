//
//  YHSCookBookSearchTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/20.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHSCookBookSearchModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_SEARCH;

@protocol YHSCookBookSearchTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookSearchModel:(YHSCookBookSearchModel *)model;
@end


@interface YHSCookBookSearchTableViewCell : MGSwipeTableCell

@property (nonatomic, strong) YHSCookBookSearchModel *model;

@property (nonatomic, strong) id<YHSCookBookSearchTableViewCellDelegate> searchDelegate;


@end

