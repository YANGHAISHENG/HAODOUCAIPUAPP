//
//  YHSCookBookShowVideoViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

@interface YHSCookBookShowVideoViewController : YHSBasicWithBackBarItemViewController

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *cate_id;
@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量

@end
