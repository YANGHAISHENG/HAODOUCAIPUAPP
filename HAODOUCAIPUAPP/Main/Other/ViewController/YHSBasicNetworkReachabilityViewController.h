//
//  YHSBasicNetworkReachabilityViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/17.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicViewController.h"
#import "YHSNetworkingManager.h"
#import "YHSBasicViewController+EmptyDataSet.h"

@interface YHSBasicNetworkReachabilityViewController : YHSBasicViewController

@property (nonatomic, strong) UILabel *currentNetworkReachabilityStatusLabel; // 显示网络状态提示信息

// 监听网络变化后执行
- (void)doWithNetworkReachabilityStatus:(YHSNetworkReachabilityStatus)networkReachabilityStatus;

// 根据网络状态进行加载处理
- (void)viewDidLoadWithNetworkingStatus;

// 根据网络状态进行加载处理
- (void)viewDidLoadWithNoNetworkingStatus;


@end
