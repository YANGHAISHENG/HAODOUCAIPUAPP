//
//  YHSCookBookSearchDetailViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/20.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

typedef NS_ENUM(NSInteger, YHSCookBookSearchDetailSection) {
    YHSCookBookSearchDetailSectionAlum, // 结果集合
    YHSCookBookSearchDetailSectionDetail, // 搜索详情
};

@interface YHSCookBookSearchDetailViewController : YHSBasicWithBackBarItemViewController

@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, strong) NSString *tagId; // 搜索标签ID
@property (nonatomic, strong) NSString *keyWord; // 搜索关键字
@property (nonatomic, strong) NSString *scene;
@property (nonatomic, strong) NSString *uuid;

@end
