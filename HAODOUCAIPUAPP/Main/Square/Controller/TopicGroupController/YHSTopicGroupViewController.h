//
//  YHSTopicGroupViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicNetworkReachabilityViewController.h"

typedef NS_ENUM(NSInteger, YHSTopicGroupTableSection) {
    YHSTopicGroupTableSectionAD, // 广告横幅
    YHSTopicGroupTableSectionHotTitle, // 实时热点
    YHSTopicGroupTableSectionGroupTitle, // 话题小组
    YHSTopicGroupTableSectionTodayStar, // 活跃豆亲
};


@interface YHSTopicGroupViewController : YHSBasicNetworkReachabilityViewController

@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量

@end
