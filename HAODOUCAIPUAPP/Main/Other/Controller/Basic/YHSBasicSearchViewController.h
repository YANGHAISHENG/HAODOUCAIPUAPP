//
//  YHSBasicSearchViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicNetworkReachabilityViewController.h"
@class TBAnimationButton;

typedef NS_ENUM(NSInteger, YHSCookBookSearchTableSection) {
    YHSCookBookTableSectionClearAll, // 清空所有历史记录
    YHSCookBookTableSectionHistoryElem, // 关键字历史记录
    YHSCookBookTableSectionSearchFriends, // 搜索菜谱逗友
};

@interface YHSBasicSearchViewController : YHSBasicNetworkReachabilityViewController

#pragma mark - 导航栏区域
@property (nonatomic, strong) UIButton *backNavBtn; // 导航条返回选项
@property (nonatomic, strong) UIView *searchAreaView; // 导航条搜索区域
@property (nonatomic, strong) UITextField *searchTextField; // 导航条搜索输入
@property (nonatomic, strong) UIImageView *searchIconImage; // 导航条搜索按钮
@property (nonatomic, strong) TBAnimationButton *searchCrossButton; // 导航条搜索按钮


#pragma mark - 触发搜索按钮关闭事件
- (void)naviSearchBarCrossItemClicked:(TBAnimationButton *)button;

#pragma mark - 触发搜索按钮搜索事件
- (void)naviSearchBarFindItemClicked:(UITapGestureRecognizer *)gesture;



@end
