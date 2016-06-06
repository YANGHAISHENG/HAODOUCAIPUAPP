//
//  YHSTopicGroupADTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSTopicGroupADModel;

UIKIT_EXTERN CGFloat const TOPICGROUP_SCROLL_AD_HEIGHT;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_TOPIC_GROUP_AD;

@protocol YHSTopicGroupADTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithTopicGroupADModel:(YHSTopicGroupADModel *)model;
@end


@interface YHSTopicGroupADTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray<YHSTopicGroupADModel *> *model;

@property (nonatomic, strong) id<YHSTopicGroupADTableViewCellDelegate> delegate;

@end


