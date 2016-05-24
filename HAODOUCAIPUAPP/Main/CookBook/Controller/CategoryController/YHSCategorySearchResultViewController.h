//
//  YHSCategorySearchResultViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/19.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicNetworkReachabilityViewController.h"

@interface YHSCategorySearchResultViewController : YHSBasicNetworkReachabilityViewController

@property (nonatomic, strong) NSString *tagId; // 搜索标签ID
@property (nonatomic, strong) NSString *tagName; // 搜索标签Name
@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, strong) NSString *scene;
@property (nonatomic, strong) NSString *uuid;

@end
