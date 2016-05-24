//
//  YHSCookBookMainViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicNetworkReachabilityViewController.h"


typedef NS_ENUM(NSInteger, YHSCookBookTableSection) {
    YHSCookBookTableSectionBanner, // 广告横幅
    YHSCookBookTableSectionTools, // 分类工具
    YHSCookBookTableSectionHotsAlbum, // 热门专辑
    YHSCookBookTableSectionYourLove, // 猜你喜欢
    YHSCookBookTableSectionRecommed, // 热门推荐
    YHSCookBookTableSectionGoods, // 到家商品
    YHSCookBookTableSectionQualityRead, // 精品阅读
    YHSCookBookTableSectionHotsActivity, // 热门活动
    YHSCookBookTableSectionHaoDouVIP, // 好豆达人
    YHSCookBookTableSectionPublish, // 分享美食
};

@interface YHSCookBookMainViewController : YHSBasicNetworkReachabilityViewController

@end
