//
//  YHSCookBookSearchClearAllTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookSearchModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_SEARCH_CLEAR_ALL;

@protocol YHSCookBookSearchClearAllTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookSearchClearAllModel:(YHSCookBookSearchModel *)model;
@end


@interface YHSCookBookSearchClearAllTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookSearchModel *model;

@property (nonatomic, strong) id<YHSCookBookSearchClearAllTableViewCellDelegate> delegate;


@end


