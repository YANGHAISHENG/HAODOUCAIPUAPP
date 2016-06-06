//
//  YHSTopicGroupViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSTopicGroupViewController.h"
#import "YHSTopicGroupTableSectionHeaderView.h"
#import "YHSTopicGroupADTableViewCell.h"
#import "YHSTopicGroupADModel.h"
#import "YHSTopicGroupHotTitleTableViewCell.h"
#import "YHSTopicGroupHotTitleModel.h"
#import "YHSTopicGroupGroupTitleTableViewCell.h"
#import "YHSTopicGroupGroupTitleModel.h"
#import "YHSTopicGroupTodayStarTableViewCell.h"
#import "YHSTopicGroupTodayStarModel.h"
#import "YHSTopicGroupGroupTitleTableViewCell.h"
#import "YHSTopicGroupGroupTitleModel.h"


@interface YHSTopicGroupViewController () <UITableViewDelegate, UITableViewDataSource, YHSTopicGroupTableSectionHeaderViewDelegate, YHSTopicGroupADTableViewCellDelegate, YHSTopicGroupHotTitleTableViewCellDelegate, YHSTopicGroupGroupTitleTableViewCellDelegate>

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;
@property (nonatomic, strong) NSMutableArray<YHSTopicGroupADModel *> *adModels; // 广告栏
@property (nonatomic, strong) NSString *hotUrl; // 实时热点
@property (nonatomic, strong) NSString *hotTitle; // 实时热点
@property (nonatomic, strong) NSMutableArray<YHSTopicGroupHotTitleModel *> *hotTitleModels; // 实时热点
@property (nonatomic, strong) NSString *groupUrl; // 话题小组
@property (nonatomic, strong) NSString *groupTitle; // 话题小组
@property (nonatomic, strong) NSMutableArray<YHSTopicGroupGroupTitleModel *> *groupTitleModels; // 话题小组
@property (nonatomic, strong) NSString *todayStarUrl; // 活跃豆亲
@property (nonatomic, strong) NSString *todayStarTitle; // 活跃豆亲
@property (nonatomic, strong) NSMutableArray<YHSTopicGroupTodayStarModel *> *todayStarModels; // 活跃豆亲
@end

@implementation YHSTopicGroupViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _offset = 0;
        _limit = 20;
    }
    return self;
}

// 监听网络变化后执行
- (void)viewDidLoadWithNetworkingStatus
{
    WEAKSELF(weakSelf);
    
    // 请求网络数据（如果没有请求过数据，则进行数据加载）
    [self loadDataThen:^(BOOL success, NSUInteger count){
        
        // 配置TableView界面
        [weakSelf createUITable];
        
        // 根据请求到数据小于1页，则隐藏上拉刷新控件
        if (count < _limit ) {
            [self.tableView.mj_footer setHidden:YES];;
        }
        
        // 加载成功
        if (success && count) {
            
            // 刷新表格
            [weakSelf.tableView reloadData];
            
            // 增加偏移量
            _offset += _limit;
            YHSLogBlue(@"加载后偏移量 ：%ld", _offset);
        }
        
    } andWritingLoading:(self.tableData.count == 0 ? YES : NO)];
    
}


#pragma mark - 创建界面
- (void)createUITable
{
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    // 表格已经存在或无数据源则无需创建，直接返回
    if (self.tableView) {
        return;
    }
    
    WEAKSELF(weakSelf);
    
    // 根容器组件
    UIView *rootContainerView = ({
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
        }];
        
        view;
    });
    self.rootContainerView = rootContainerView;
    
    // 创建表格
    {
        // 创建表格
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.rootContainerView addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = YES;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 添加约束
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.rootContainerView.mas_top).with.offset(0.0);
            make.left.equalTo(weakSelf.rootContainerView.mas_left).with.offset(0);
            make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).with.offset(0);
            make.right.equalTo(weakSelf.rootContainerView.mas_right).with.offset(0);
        }];
        
        // 自动算高 UITableView+FDTemplateLayoutCell
        self.tableView.estimatedRowHeight = 120; //预算行高
        self.tableView.fd_debugLogEnabled = YES; //开启log打印高度
        
        // 空白数据背景
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        
        // 设置表格背景
        UIView *backView = [[UIView alloc] init];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setBackgroundView:backView];
        
        // 表头表尾
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        
        // 下拉刷新
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
        // 上拉加载
        MJRefreshAutoNormalFooter *autoNormalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [autoNormalFooter setTitle:YHSRefreshAutoFooterIdleText forState:MJRefreshStateIdle];
        [autoNormalFooter setTitle:YHSRefreshAutoFooterRefreshingText forState:MJRefreshStateRefreshing];
        [autoNormalFooter setTitle:YHSRefreshAutoFooterNoMoreDataText forState:MJRefreshStateNoMoreData];
        [autoNormalFooter.stateLabel setFont:[UIFont boldSystemFontOfSize:YHSRefreshAutoFooterFontSize]];
        [autoNormalFooter.stateLabel setTextColor:YHSRefreshAutoFooterTextColor];
        [self.tableView setMj_footer:autoNormalFooter];
        
        // 必须被注册到 UITableView 中
        [self.tableView registerClass:[YHSTopicGroupADTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_AD];
        [self.tableView registerClass:[YHSTopicGroupHotTitleTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_HOTTITLE];
        [self.tableView registerClass:[YHSTopicGroupGroupTitleTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_GROUPTITLE];
    }
    
}


#pragma mark - 自定义配置导航栏
- (void)customNavigationBar
{
    [super customNavigationBar];
    
    [self.navBarCustomView setBackgroundColor:[UIColor whiteColor]];
    
}


#pragma mark - 请求网络数据（下拉刷新数据）
- (void)loadData
{
    // 每次刷新时重置
    _offset = 0;
    
    // 加载更多数据
    [self loadMoreData];
    
}

#pragma mark - 请求网络数据（上拉加载数据）
- (void)loadMoreData
{
    WEAKSELF(weakSelf);
    
    YHSLogBlue(@"%s \n加载前偏移量 ：%ld", __FUNCTION__, _offset);
    
    // 验证网络状态，无网则直接返回
    if ([YHSNetworkingManager sharedYHSNetworkingManagerInstance].networkReachabilityStatus == YHSNetworkReachabilityStatusUnknown
        || [YHSNetworkingManager sharedYHSNetworkingManagerInstance].networkReachabilityStatus == YHSNetworkReachabilityStatusNotReachable) {
        
        // 下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        
        // 上拉刷新控件，结束刷新状态
        [self.tableView.mj_footer endRefreshing];
        
        // 直接返回
        return;
        
    } else {
        
        // 请求数据
        [self loadDataThen:^(BOOL success, NSUInteger count){
            
            if (count < _limit) {
                
                // 下拉刷新控件，没有更多数据
                [weakSelf.tableView.mj_header endRefreshing];
                
                // 上拉刷新控件，没有更多数据
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                
            } else {
                
                // 下拉刷新控件，结束刷新状态
                [weakSelf.tableView.mj_header endRefreshing];
                
                // 上拉刷新控件，结束刷新状态
                [self.tableView.mj_footer endRefreshing];
                
            }
            
            // 加载成功
            if (success && count) {
                
                // 刷新表格
                [weakSelf.tableView reloadData];
                
                // 增加偏移量
                _offset += _limit;
                YHSLogBlue(@"加载后偏移量 ：%ld", _offset);
            }
            
        } andWritingLoading:NO];
        
    }
    
}

#pragma mark - 请求网络数据
- (void)loadDataThen:(void (^)(BOOL success, NSUInteger count))then andWritingLoading:(BOOL)showWritingLoading {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 手写Loading加载动画
    __block UIView *loadingContainerView = nil;
    __block YHSHandWritingLoadingView *writingLoadingVeiw = nil;
    if (showWritingLoading) {
        
        // 加载动画根容器
        loadingContainerView = [[YHSHandWritingLoadingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49)];
        [self.view addSubview:loadingContainerView];
        // 手势Loading动画
        writingLoadingVeiw = [[YHSHandWritingLoadingView alloc] initWithView:loadingContainerView];
        loadingContainerView.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
        [loadingContainerView addSubview:writingLoadingVeiw];
        // 手写Loading加载动画
        [writingLoadingVeiw show];
    }
    
    // 在默认优先级的 Global Dispatch Queue 中执行块(Block)，并行处理
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 请求数据是否成功
        __block BOOL isSuccess = NO;
        __block NSUInteger listCount = 0; // 请求到的数据数量
        
        // 请求地址与参数
        NSString *url = [YHSSquareDataUtil getTopicGroupRequestURLString];
        NSMutableDictionary *params = [YHSSquareDataUtil getTopicGroupRequestParams];
        
        // 初始化Manager
        AFHTTPSessionManager *manager = [YHSNetworkingManager sharedYHSNetworkingManagerInstance].manager;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 设置请求的数据格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 设置返回的数据格式
        
        // 请求网络数据前，先取消之前的请求，再发网络请求
        [manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
        
        // 请求网络数据
        [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 请求成功，解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSDictionary *data = dict[@"result"];
            
            // 数据模型转换
            // 1.广告横幅
            NSMutableArray<YHSTopicGroupADModel *> *adModelArray = [NSMutableArray array];
            [data[@"ad"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                YHSTopicGroupADModel *model = [YHSTopicGroupADModel mj_objectWithKeyValues:dict];
                [adModelArray addObject:model];
            }];
            weakSelf.adModels = adModelArray.mutableCopy;
            
            // 2.实时热点
            NSMutableArray<YHSTopicGroupHotTitleModel *> *hotTitleModelArray = [NSMutableArray array];
            [data[@"hot"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                YHSTopicGroupHotTitleModel *model = [YHSTopicGroupHotTitleModel mj_objectWithKeyValues:dict];
                [hotTitleModelArray addObject:model];
            }];
            weakSelf.hotTitleModels = hotTitleModelArray.mutableCopy;
            weakSelf.hotUrl = data[@"hotUrl"];
            weakSelf.hotTitle = data[@"hotTitle"];
            
            // 3.话题小组
            NSMutableArray<YHSTopicGroupGroupTitleModel *> *groupTitleModelArray = [NSMutableArray array];
            [data[@"group"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                YHSTopicGroupGroupTitleModel *model = [YHSTopicGroupGroupTitleModel mj_objectWithKeyValues:dict];
                [groupTitleModelArray addObject:model];
            }];
            weakSelf.groupTitleModels = groupTitleModelArray.mutableCopy;
            weakSelf.groupUrl = data[@"groupUrl"];
            weakSelf.groupTitle = data[@"groupTitle"];
            
            // 4.活跃豆亲
            NSMutableArray<YHSTopicGroupTodayStarModel *> *todayStarModelArray = [NSMutableArray array];
            [data[@"todayStar"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                YHSTopicGroupTodayStarModel *model = [YHSTopicGroupTodayStarModel mj_objectWithKeyValues:dict];
                [todayStarModelArray addObject:model];
            }];
            weakSelf.todayStarModels = todayStarModelArray.mutableCopy;
            weakSelf.todayStarUrl = data[@"todayStarUrl"];
            weakSelf.todayStarTitle = data[@"todayStarTitle"];
            
            // 设置数据源
            [self.tableData addObject:@[weakSelf.adModels]];
            [self.tableData addObject:weakSelf.hotTitleModels];
            [self.tableData addObject:weakSelf.groupTitleModels];
            
            // 请求数据成功
            isSuccess = YES;
            listCount = self.tableData.count;
            if (listCount > 0) {
                YHSLogRed(@"请求数据成功");
            } else {
                YHSLogRed(@"没有更多数据");
            }
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 删除手写Loading加载动画
                if (showWritingLoading) {
#ifdef DEBUG
                    sleep(LOADING_SLEEP_TIME); // 测试用延迟看效果
#endif
                    [writingLoadingVeiw dismiss];
                    [loadingContainerView removeFromSuperview];
                }
                
                // 刷新界面
                !then ?: then(isSuccess, listCount);
                
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            YHSLogRed(@"请求数据异常：%@", error);
            
            // 请求数据失败
            isSuccess = NO;
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 删除手写Loading加载动画
                if (showWritingLoading) {
#ifdef DEBUG
                    sleep(LOADING_SLEEP_TIME); // 测试用延迟看效果
#endif
                    [writingLoadingVeiw dismiss];
                    [loadingContainerView removeFromSuperview];
                }
                
                // 刷新界面
                !then ?: then(isSuccess, listCount);
                
            });
            
        }];
        
    }); // dispatch_async
    
}

- (NSMutableArray *)tableData
{
    if (!_tableData) {
        _tableData = [NSMutableArray array];
    }
    return _tableData;
}

#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableData.count > 0 && self.tableData.count > section) {
        
        NSMutableArray *group = self.tableData[section];
        
        return group.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
            // 广告横幅
        case YHSTopicGroupTableSectionAD: {
            YHSTopicGroupADTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_AD];
            if (!cell) {
                cell = [[YHSTopicGroupADTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_AD];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 实时热点
        case YHSTopicGroupTableSectionHotTitle: {
            YHSTopicGroupHotTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_HOTTITLE];
            if (!cell) {
                cell = [[YHSTopicGroupHotTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_HOTTITLE];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 话题小组
        case YHSTopicGroupTableSectionGroupTitle: {
            YHSTopicGroupGroupTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_GROUPTITLE];
            if (!cell) {
                cell = [[YHSTopicGroupGroupTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_GROUPTITLE];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 活跃豆亲
        case YHSTopicGroupTableSectionTodayStar: {
            return nil;
        }
        default: {
            return nil;
        }
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
            // 广告横幅
        case YHSTopicGroupTableSectionAD: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_AD cacheByIndexPath:indexPath configuration:^(YHSTopicGroupADTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
            // 实时热点
        case YHSTopicGroupTableSectionHotTitle: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_HOTTITLE cacheByIndexPath:indexPath configuration:^(YHSTopicGroupHotTitleTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
            // 话题小组
        case YHSTopicGroupTableSectionGroupTitle: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_TOPIC_GROUP_GROUPTITLE cacheByIndexPath:indexPath configuration:^(YHSTopicGroupGroupTitleTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
            // 活跃豆亲
        case YHSTopicGroupTableSectionTodayStar: {
            return 0.0;
        }
        default: {
            return 0.0;
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat height = 45.0;
    
    switch (section) {
        case YHSTopicGroupTableSectionAD: {// 广告横幅
            return nil;
        }
        case YHSTopicGroupTableSectionHotTitle: { // 实时热点
            YHSTopicGroupTableSectionHeaderView *sectionHeaderView = [[YHSTopicGroupTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) title:_hotTitle imageIcon:@"ico_auxiliary_hotspot" tableSecion:YHSTopicGroupTableSectionHotTitle];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        case YHSTopicGroupTableSectionGroupTitle: { // 话题小组
            YHSTopicGroupTableSectionHeaderView *sectionHeaderView = [[YHSTopicGroupTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) title:_groupTitle imageIcon:@"ico_auxiliary_topic" tableSecion:YHSTopicGroupTableSectionHotTitle];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        case YHSTopicGroupTableSectionTodayStar: { // 活跃豆亲
            YHSTopicGroupTableSectionHeaderView *sectionHeaderView = [[YHSTopicGroupTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) title:_todayStarTitle imageIcon:@"ico_auxiliary_master" tableSecion:YHSTopicGroupTableSectionHotTitle];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        default: {
            return nil;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    switch (section) {
        case YHSTopicGroupTableSectionAD: { // 广告横幅
            return nil;
        }
        case YHSTopicGroupTableSectionHotTitle: // 实时热点
        case YHSTopicGroupTableSectionGroupTitle: { // 话题小组
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 10)];
            footerView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
            return footerView;
        }
        case YHSTopicGroupTableSectionTodayStar: { // 活跃豆亲
            return nil;
        }
        default: {
            return nil;
        }
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGFloat height = 45.0;
    
    switch (section) {
        case YHSTopicGroupTableSectionAD: { // 广告横幅
            return 0.01f;
        }
        case YHSTopicGroupTableSectionHotTitle: // 实时热点
        case YHSTopicGroupTableSectionGroupTitle: // 话题小组
        case YHSTopicGroupTableSectionTodayStar: { // 活跃豆亲
            return height;
        }
        default: {
            return 0.01f;
        }
    }
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    switch (section) {
        case YHSTopicGroupTableSectionAD: { // 广告横幅
            return 0.01f;
        }
        case YHSTopicGroupTableSectionHotTitle: // 实时热点
        case YHSTopicGroupTableSectionGroupTitle: { // 话题小组
             return 6.0;
        }
        case YHSTopicGroupTableSectionTodayStar: { // 活跃豆亲
            return 0.01f;
        }
        default: {
            return 0.01f;
        }
    }
    
    return 0.01f;
}

#pragma mark - 触发点击表格 Secion 头部事件
- (void)didClickHeaderOfTableSecion:(NSInteger)tableSection
{
    [self alertPromptMessage:@""];
}

#pragma mark - 触发点击广告栏事件
- (void)didClickElementOfCellWithTopicGroupADModel:(YHSTopicGroupADModel *)model
{
    [self alertPromptMessage:@"广告详情"];
}

#pragma mark - 触发点击实时热点事件
- (void)didClickElementOfCellWithTopicGroupHotTitleModel:(YHSTopicGroupHotTitleModel *)model
{
    [self alertPromptMessage:@"实时热点"];
}

#pragma mark - 触发点击话题小组事件
- (void)didClickElementOfCellWithTopicGroupGroupTitleModel:(YHSTopicGroupGroupTitleModel *)model
{
    [self alertPromptMessage:@"话题小组"];
}


@end
