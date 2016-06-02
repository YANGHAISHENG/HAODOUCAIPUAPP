//
//  YHSCookBookShowVideoViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookShowVideoViewController.h"
#import "YHSCookBookShowVideoModel.h"
#import "YHSCookBookShowVideoCollectionViewCell.h"
#import "YHSCookBookShowVideoCollectionViewLayout.h"
#import "YHSCategorySearchDishVideoViewController.h"


@interface YHSCookBookShowVideoViewController () <UICollectionViewDataSource, UICollectionViewDelegate, YHSCookBookShowVideoCollectionViewCellDelegate>

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 表格
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionData;
@property (nonatomic, strong) NSMutableArray *cateListData;

@end

@implementation YHSCookBookShowVideoViewController

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
            [self.collectionView.mj_footer setHidden:YES];;
        }
        
        // 加载成功
        if (success && count) {
            
            // 刷新表格
            [weakSelf.collectionView reloadData];
            
            // 增加偏移量
            _offset += _limit;
            YHSLogBlue(@"加载后偏移量 ：%ld", _offset);
        }
        
    } andWritingLoading:(self.collectionData.count == 0 ? YES : NO)];
    
}


#pragma mark - 创建界面
- (void)createUITable
{
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    // 表格已经存在或无数据源则无需创建，直接返回
    if (self.collectionView) {
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
    
    // 创建瀑布流
    {
        // 创建瀑布流
        YHSCookBookShowVideoCollectionViewLayout *flowLayout = [[YHSCookBookShowVideoCollectionViewLayout alloc] init];
        flowLayout.margin = 5;
        flowLayout.columnCount = 2;
        flowLayout.cellMinHeight = 80;
        flowLayout.cellMaxHeight = 250;
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        // 创建集合视图
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.rootContainerView addSubview:self.collectionView];
        
        // 添加约束
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.rootContainerView.mas_top).with.offset(0.0);
            make.left.equalTo(weakSelf.rootContainerView.mas_left).with.offset(0);
            make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).with.offset(0);
            make.right.equalTo(weakSelf.rootContainerView.mas_right).with.offset(0);
        }];
        
        // 下拉刷新
        self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        
        // 上拉加载
        MJRefreshAutoNormalFooter *autoNormalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [autoNormalFooter setTitle:YHSRefreshAutoFooterIdleText forState:MJRefreshStateIdle];
        [autoNormalFooter setTitle:YHSRefreshAutoFooterRefreshingText forState:MJRefreshStateRefreshing];
        [autoNormalFooter setTitle:YHSRefreshAutoFooterNoMoreDataText forState:MJRefreshStateNoMoreData];
        [autoNormalFooter.stateLabel setFont:[UIFont boldSystemFontOfSize:YHSRefreshAutoFooterFontSize]];
        [autoNormalFooter.stateLabel setTextColor:YHSRefreshAutoFooterTextColor];
        [self.collectionView setMj_footer:autoNormalFooter];
        
        // 注册cell（必须要有）
        [self.collectionView registerClass:[YHSCookBookShowVideoCollectionViewCell class] forCellWithReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_VIDEO_COLLECTION];
        
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
        [self.collectionView.mj_header endRefreshing];
        
        // 上拉刷新控件，结束刷新状态
        [self.collectionView.mj_footer endRefreshing];
        
        // 直接返回
        return;
        
    } else {
        
        // 请求数据
        [self loadDataThen:^(BOOL success, NSUInteger count){
            
            if (count < _limit) {
                
                // 下拉刷新控件，没有更多数据
                [weakSelf.collectionView.mj_header endRefreshing];
                
                // 上拉刷新控件，没有更多数据
                [weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];
                
            } else {
                
                // 下拉刷新控件，结束刷新状态
                [weakSelf.collectionView.mj_header endRefreshing];
                
                // 上拉刷新控件，结束刷新状态
                [self.collectionView.mj_footer endRefreshing];
                
            }
            
            // 加载成功
            if (success && count) {
                
                // 刷新表格
                [weakSelf.collectionView reloadData];
                
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
        loadingContainerView = [[YHSHandWritingLoadingView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
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
        NSString *url = [YHSCookBookDataUtil getCookBookShowVideoRequestURLString];
        NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookShowVideoRequestParams];
        [params setObject:@(self.limit) forKey:@"limit"];
        
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
            NSArray *list = data[@"list"];
            
            // 数据模型转换
            NSMutableArray *models = [NSMutableArray array];
            [list enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                YHSCookBookShowVideoModel *model = [YHSCookBookShowVideoModel mj_objectWithKeyValues:dict];
                [models addObject:model];
            }];
            
            // 设置数据源
            if (list.count > 0) {
                if (0 == _offset) {
                    weakSelf.collectionData = models.mutableCopy; // 刷新数据
                } else {
                    [weakSelf.collectionData addObjectsFromArray:models.mutableCopy]; // 加载更多数据
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


#pragma mark - UICollection View DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YHSCookBookShowVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SHOW_VIDEO_COLLECTION forIndexPath:indexPath];
    
    cell.delegate = self;
    
    cell.model = self.collectionData[indexPath.row];
    
    return cell;
}


#pragma mark - 触发点击Cell事件
- (void)didClickElementOfCellWithCookBookShowVideoModel:(YHSCookBookShowVideoModel *)model
{
    // 视屏菜谱
    YHSCategorySearchDishVideoViewController *dishVideoViewController = [YHSCategorySearchDishVideoViewController new];
    [dishVideoViewController setRid:model.VideoId];
    [dishVideoViewController setReturn_request_id:@"f7a76b77c2050361636afbdef807ec66"];
    [dishVideoViewController setTitle:model.Title];
    [self.navigationController pushViewController:dishVideoViewController animated:YES];
    
}



@end
