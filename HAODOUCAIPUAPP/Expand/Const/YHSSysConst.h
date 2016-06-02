//
//  YHSSysConst.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHSSysConst : NSObject

#pragma mark 状态栏高度
UIKIT_EXTERN CGFloat const HEIGHT_NAVIGATION_STATUS;

#pragma mark 导航条高度
UIKIT_EXTERN CGFloat const HEIGHT_NAVIGATION_BAR;

#pragma mark 导航条按钮字体大小
UIKIT_EXTERN CGFloat const FONT_SIZE_NAVIGATION;
UIKIT_EXTERN CGFloat const FONT_SIZE_NAVIGATION_20;

#pragma mark 标签栏按钮字体大小
UIKIT_EXTERN CGFloat const FONT_SIZE_TABBAR;

#pragma mark 占位图片
UIKIT_EXTERN NSString * const PICTURE_PLACEHOLDER;

#pragma mark 网络状态监听的广播频段
UIKIT_EXTERN NSString * const NOTIFICATION_NETWORKING_STATUS_FREQUENCY;

#pragma mark 测试数据加载时SLEEP延迟动画显示时间
UIKIT_EXTERN CGFloat const LOADING_SLEEP_TIME;

#pragma mark 网络状态提示信息字体
UIKIT_EXTERN CGFloat const LOADING_FONT_SIZE;

#pragma mark 网络状态提示容器高度
UIKIT_EXTERN CGFloat const LOADING_VIEW_HEIGHT;

#pragma mark 上拉刷新提示信息
UIKIT_EXTERN CGFloat const YHSRefreshAutoFooterFontSize;
UIKIT_EXTERN NSString *const YHSRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const YHSRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const YHSRefreshAutoFooterNoMoreDataText;
#define YHSRefreshAutoFooterTextColor [UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00]


#pragma mark 广告栏数据过滤
UIKIT_EXTERN NSString *const YHS_BANNER_FILTER_COLLECT;
UIKIT_EXTERN NSString *const YHS_BANNER_FILTER_RECIPE;

@end
