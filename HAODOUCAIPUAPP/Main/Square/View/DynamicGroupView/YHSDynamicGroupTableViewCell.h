//
//  YHSDynamicGroupTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/7.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSDynamicGroupModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_DYNAMIC_GROUP;

@protocol YHSDynamicGroupTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithDynamicGroupModel:(YHSDynamicGroupModel *)model;
@end


@interface YHSDynamicGroupTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSDynamicGroupModel *model;

@property (nonatomic, strong) id<YHSDynamicGroupTableViewCellDelegate> delegate;

@end


