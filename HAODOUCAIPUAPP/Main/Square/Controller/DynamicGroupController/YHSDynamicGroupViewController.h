//
//  YHSDynamicGroupViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicNetworkReachabilityViewController.h"

@interface YHSDynamicGroupViewController : YHSBasicNetworkReachabilityViewController

@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *uid;

@end
