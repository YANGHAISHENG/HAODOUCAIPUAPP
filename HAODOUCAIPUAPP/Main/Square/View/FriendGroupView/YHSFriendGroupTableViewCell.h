//
//  YHSFriendGroupTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSFriendGroupModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_FRIEND_GROUP;

@protocol YHSFriendGroupTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellUserInfoWithFriendGroupModel:(YHSFriendGroupModel *)model;
- (void)didClickElementOfCellRelationWithFriendGroupModel:(YHSFriendGroupModel *)model;
- (void)didClickElementOfCellCommonInfoWithFriendGroupModel:(YHSFriendGroupModel *)model;
@end


@interface YHSFriendGroupTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSFriendGroupModel *model;

@property (nonatomic, strong) id<YHSFriendGroupTableViewCellDelegate> delegate;

@end


