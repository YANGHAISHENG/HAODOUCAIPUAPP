//
//  YHSTopicGroupGroupTitleTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSTopicGroupGroupTitleModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_TOPIC_GROUP_GROUPTITLE;

@protocol YHSTopicGroupGroupTitleTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithTopicGroupGroupTitleModel:(YHSTopicGroupGroupTitleModel *)model;
@end


@interface YHSTopicGroupGroupTitleTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSTopicGroupGroupTitleModel *model;

@property (nonatomic, strong) id<YHSTopicGroupGroupTitleTableViewCellDelegate> delegate;

@end



