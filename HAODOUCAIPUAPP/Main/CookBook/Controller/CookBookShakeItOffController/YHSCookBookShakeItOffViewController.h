//
//  YHSCookBookShakeItOffViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "YHSBasicWithBackBarItemViewController.h"
@class YHSCookBookShakeItOffModel;

@interface YHSCookBookShakeItOffViewController : YHSBasicWithBackBarItemViewController

/**
 * 搜索结果
 */
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *tableData; // 数据源
@property (nonatomic, strong) NSMutableArray<NSString *> *sectionTitle; // 数据源标题


/**
 * 是否振动
 */
@property (nonatomic, assign) BOOL isShakeItOff;


@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, strong) NSString *uuid;


#pragma mark - 根据网络请求进行处理
- (void)viewDidLoadWithNetworkingStatus;
- (void)createUITable;

#pragma mark - 请求网络数据
- (void)loadData;
- (void)loadMoreData;
- (void)loadDataThen:(void (^)(BOOL success, NSUInteger count))then andWritingLoading:(BOOL)showWritingLoading;

#pragma mark - 触发点击事件
- (void)didClickElementOfCellWithCookBookShakeItOffModel:(YHSCookBookShakeItOffModel *)model;

#pragma mark - 振动
void soundCompleteCallback(SystemSoundID sound, void * clientData);



@end
