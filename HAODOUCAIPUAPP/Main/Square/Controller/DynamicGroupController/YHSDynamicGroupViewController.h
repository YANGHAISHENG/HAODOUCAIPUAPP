//
//  YHSDynamicGroupViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSSquareBasicViewController.h"

@interface YHSDynamicGroupViewController : YHSSquareBasicViewController

@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *uid;

@end
