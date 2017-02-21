//
//  YHSTopicGroupTodayStarTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSTopicGroupTodayStarModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_TOPIC_GROUP_TODAY_STAR;

@protocol YHSTopicGroupTodayStarTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithTopicGroupTodayStarModel:(YHSTopicGroupTodayStarModel *)model;
@end


@interface YHSTopicGroupTodayStarTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray<YHSTopicGroupTodayStarModel *> *model;

@property (nonatomic, strong) id<YHSTopicGroupTodayStarTableViewCellDelegate> delegate;

@end


