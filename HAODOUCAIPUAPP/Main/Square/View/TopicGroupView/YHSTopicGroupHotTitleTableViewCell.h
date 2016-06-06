//
//  YHSTopicGroupHotTitleTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSTopicGroupHotTitleModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_TOPIC_GROUP_HOTTITLE;

@protocol YHSTopicGroupHotTitleTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithTopicGroupHotTitleModel:(YHSTopicGroupHotTitleModel *)model;
@end


@interface YHSTopicGroupHotTitleTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSTopicGroupHotTitleModel *model;

@property (nonatomic, strong) id<YHSTopicGroupHotTitleTableViewCellDelegate> delegate;

@end


