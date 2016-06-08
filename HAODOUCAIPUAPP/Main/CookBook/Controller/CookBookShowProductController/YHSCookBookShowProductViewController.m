//
//  YHSCookBookShowProductViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookShowProductViewController.h"
#import "YHSCookBookShowProductDayTableViewCell.h"
#import "YHSCookBookShowProductCateTableViewCell.h"
#import "YHSCookBookShowProductUserTableViewCell.h"

#import "YHSCookBookShowProductDayModel.h"
#import "YHSCookBookShowProductCateModel.h"
#import "YHSCookBookShowProductUserModel.h"
#import "YHSCookBookShowProductUserModel.h"


@interface YHSCookBookShowProductViewController () <UITableViewDelegate, UITableViewDataSource, YHSCookBookShowProductDayTableViewCellDelegate, YHSCookBookShowProductCateTableViewCellDelegate, YHSCookBookShowProductUserTableViewCellDelegate>

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation YHSCookBookShowProductViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        _offset = 0;
        _limit = 20;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navBarHairlineImageView setHidden:YES];
    
    if (self.tableData.count == 0) {
        [self viewDidLoadWithNetworkingStatus];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navBarHairlineImageView setHidden:NO];
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
        [self.tableView registerClass:[YHSCookBookShowProductDayTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_DAY];
        [self.tableView registerClass:[YHSCookBookShowProductCateTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_CATE];
        [self.tableView registerClass:[YHSCookBookShowProductUserTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_USER];
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
        NSString *url = [YHSCookBookDataUtil getCookBookShowProductRequestURLString];
        NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookShowProductRequestParams];
        
        // 初始化Manager
        AFHTTPSessionManager *manager = [YHSNetworkingManager sharedYHSNetworkingManagerInstance].manager;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 设置请求的数据格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 设置返回的数据格式
        
        // 请求网络数据前，先取消之前的请求，再发网络请求
        [manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
        
        // 请求网络数据
        [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 请求成功，解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSDictionary *data = dict[@"result"];
            NSArray *list = data[@"list"];
            
            // 数据模型转换
            __block NSInteger cateIndex = 1;
            NSMutableArray *models = [NSMutableArray array];
            [list enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *itemType = dict[@"ItemType"];
                if ([@"day" isEqualToString:itemType]) {
                    YHSCookBookShowProductDayModel *model = [YHSCookBookShowProductDayModel mj_objectWithKeyValues:dict];
                    [models addObject:model];
                } else if ([@"cate" isEqualToString:itemType]) {
                    YHSCookBookShowProductCateModel *model = [YHSCookBookShowProductCateModel mj_objectWithKeyValues:dict];
                    model.index = cateIndex ++;
                    [models addObject:model];
                } else if ([@"user" isEqualToString:itemType]) {
                    YHSCookBookShowProductUserModel *model = [YHSCookBookShowProductUserModel mj_objectWithKeyValues:dict];
                    [models addObject:model];
                }

            }];
            
            // 设置数据源
            if (list.count > 0) {
                if (0 == _offset) {
                    weakSelf.tableData = models.mutableCopy; // 刷新数据
                } else {
                    [weakSelf.tableData addObjectsFromArray:models.mutableCopy]; // 加载更多数据
                }
            }
            
            // 请求数据成功
            isSuccess = YES;
            listCount = list.count;
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

#pragma mark - TableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableData.count > 0) {
        return self.tableData.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.tableData[indexPath.row];
    
    if ([model isKindOfClass:[YHSCookBookShowProductDayModel class]]) {
        
        YHSCookBookShowProductDayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_DAY];
        if (!cell) {
            cell = [[YHSCookBookShowProductDayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_DAY];
        }
        cell.delegate = self;
        cell.model = self.tableData[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if ([model isKindOfClass:[YHSCookBookShowProductCateModel class]]) {
        
        YHSCookBookShowProductCateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_CATE];
        if (!cell) {
            cell = [[YHSCookBookShowProductCateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_CATE];
        }
        cell.delegate = self;
        cell.model = self.tableData[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if ([model isKindOfClass:[YHSCookBookShowProductUserModel class]]) {
        
        YHSCookBookShowProductUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_USER];
        if (!cell) {
            cell = [[YHSCookBookShowProductUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_USER];
        }
        cell.delegate = self;
        cell.model = self.tableData[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id model = self.tableData[indexPath.row];
    
    if ([model isKindOfClass:[YHSCookBookShowProductDayModel class]]) {
        
        return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_DAY cacheByIndexPath:indexPath configuration:^(YHSCookBookShowProductDayTableViewCell *cell) {
            // 配置 cell 的数据源，和 "cellForRow" 干的事一致
            cell.model = self.tableData[indexPath.row];
        }];
        
    } else if ([model isKindOfClass:[YHSCookBookShowProductCateModel class]]) {
        
        return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_CATE cacheByIndexPath:indexPath configuration:^(YHSCookBookShowProductCateTableViewCell *cell) {
            // 配置 cell 的数据源，和 "cellForRow" 干的事一致
            cell.model = self.tableData[indexPath.row];
        }];
        
    } else if ([model isKindOfClass:[YHSCookBookShowProductUserModel class]]) {
        
        return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_USER cacheByIndexPath:indexPath configuration:^(YHSCookBookShowProductUserTableViewCell *cell) {
            // 配置 cell 的数据源，和 "cellForRow" 干的事一致
            cell.model = self.tableData[indexPath.row];
        }];
        
    }
    
    return 0.0;

}


#pragma mark - 触发点击Cell事件
- (void)didClickElementOfCellWithCookBookShowProductDayItemModel:(YHSCookBookShowProductDayItemModel *)model
{
    [self alertPromptMessage:@""];
}

- (void)didClickElementOfCellWithCookBookShowProductCateItemModel:(YHSCookBookShowProductCateItemModel *)model
{
    [self alertPromptMessage:@""];
}

- (void)didClickElementOfCellWithCookBookShowProductCateModel:(YHSCookBookShowProductCateModel *)model
{
    [self alertPromptMessage:@""];
}

- (void)didClickElementOfCellWithCookBookShowProductUserItemModel:(YHSCookBookShowProductUserItemModel *)model
{
    [self alertPromptMessage:@""];
}



@end
