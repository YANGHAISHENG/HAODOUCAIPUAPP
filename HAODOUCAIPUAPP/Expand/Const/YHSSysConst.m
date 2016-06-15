//
//  YHSSysConst.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSSysConst.h"

@implementation YHSSysConst

#pragma mark 状态栏高度
CGFloat const HEIGHT_NAVIGATION_STATUS = 20.0;

#pragma mark 导航条高度
CGFloat const HEIGHT_NAVIGATION_BAR = 44.0;

#pragma mark 导航条按钮字体大小
CGFloat const FONT_SIZE_NAVIGATION = 18.0;
CGFloat const FONT_SIZE_NAVIGATION_20 = 20.0;

#pragma mark 标签栏按钮字体大小
CGFloat const FONT_SIZE_TABBAR = 12.0;


#pragma mark 是否显示引导页面
NSString * const YHSIntroductionKey = @"YHSAppIntroduction";

#pragma mark 占位图片
NSString * const PICTURE_PLACEHOLDER = @"default_big.png";

#pragma mark 网络状态监听的广播频段
NSString * const NOTIFICATION_NETWORKING_STATUS_FREQUENCY  = @"ReachabilityNetWorkingStatusFrequency";

#pragma mark 测试数据加载时SLEEP延迟动画显示时间
CGFloat const LOADING_SLEEP_TIME = 0.0;

#pragma mark 网络状态提示信息字体
CGFloat const LOADING_FONT_SIZE = 12.0;

#pragma mark 网络状态提示容器高度
CGFloat const LOADING_VIEW_HEIGHT = 35.0;

#pragma mark 表格底部分割视图
CGFloat const TABLE_FOOTER_SEPARATOR_VIEW_HEIGHT = 6.0;

#pragma mark 表格底部分割线
CGFloat const TABLE_FOOTER_SEPARATOR_LINE_HEIGHT = 1.0;

#pragma mark 上拉刷新提示信息
CGFloat const YHSRefreshAutoFooterFontSize = 14.0;
NSString *const YHSRefreshAutoFooterIdleText = @"点击或上拉加载更多";
NSString *const YHSRefreshAutoFooterRefreshingText = @"正在加载更多的数据...";
NSString *const YHSRefreshAutoFooterNoMoreDataText = @"已经全部加载完毕";

#pragma mark 广告栏数据过滤
NSString *const YHS_BANNER_FILTER_COLLECT = @"haodou.com/collect/info/?id=";
NSString *const YHS_BANNER_FILTER_RECIPE = @"haodou.com/recipe/info/?id=";







@end
