//
//  YHSCookBookHotsAlbumDetailViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithCollectShareBarItemViewController.h"

typedef NS_ENUM(NSInteger, YHSCookBookHotsAlbumDetailSection) {
    YHSCookBookHotsAlbumDetailSectionInfo, // 头部图片
    YHSCookBookHotsAlbumDetailSectionShare, // 说明信息
    YHSCookBookHotsAlbumDetailSectionElem, // 详细列表
};

@interface YHSCookBookHotsAlbumDetailViewController : YHSBasicWithCollectShareBarItemViewController

@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, strong) NSString *aid; // 对应YHSCookBookAlbumElemModel属性Url中的?后的id


@end


