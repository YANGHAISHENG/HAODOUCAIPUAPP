//
//  YHSBackHomeMainViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSAllButton.h"
#import "YHSPopMenu.h"
#import "YHSButtonWithIcon.h"

#import "YHSBackHomeMainViewController.h"
#import "YHSCookBookSearchViewController.h"
#import "YHSBackHomeCateModel.h"
#import "YHSBackHomeTableSectionHeaderView.h"
#import "YHSBackHomeADTableViewCell.h"
#import "YHSBackHomeADModel.h"
#import "YHSBackHomeFoodieFavoriteGoodsTableViewCell.h"
#import "YHSBackHomeFoodieFavoriteGoodsModel.h"
#import "YHSBackHomeGoodTableViewCell.h"
#import "YHSBackHomeGoodsModel.h"


@interface YHSBackHomeMainViewController () <UITableViewDelegate, UITableViewDataSource, YHSBackHomeTableSectionHeaderViewDelegate, YHSBackHomeADTableViewCellDelegate, YHSBackHomeFoodieFavoriteGoodsTableViewCellDelegate, YHSBackHomeGoodTableViewCellDelegate>

@property (nonatomic, strong) UIView *searchAreaView; // 导航条搜索按钮区域
@property (nonatomic, strong) UIImageView *searchIconImageView; // 导航条搜索图标
@property (nonatomic, strong) UILabel *searchTitleLable; // 导航条搜索标题

// 头部分类
@property (nonatomic, strong) NSMutableArray<YHSBackHomeCateModel *> *cateListData; // 分类标签
@property (nonatomic, strong) UIView *cateAreaContainer; // 分类标签区域

// 购物按钮
@property (nonatomic, strong) YHSButtonWithIcon *button_shopping;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *tableData; // 数据源
@property (nonatomic, strong) NSMutableArray<YHSBackHomeADModel *> *adModels; // 广告栏
@property (nonatomic, strong) NSMutableArray<YHSBackHomeFoodieFavoriteGoodsModel *> *favoriteGoodModels; // 吃货最爱
@property (nonatomic, strong) NSMutableArray<YHSBackHomeGoodsModel *> *goodModels; // 逛逛商品

@end

@implementation YHSBackHomeMainViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _offset = 0;
        _limit = 20;
        _RecommendType = 0;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navBarHairlineImageView setHidden:YES];
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
    if (!self.tableData || self.tableData.count == 0) {
        
        [self loadDataThen:^(BOOL success, NSUInteger count){
            
            // 创建标签头部
            [weakSelf createUICate];
            
            // 配置UI界面
            [weakSelf createUITable];
            
            // 购物按钮
            [weakSelf createUIBuyButton];
            
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
    
}



// 监听网络变化后执行
- (void)viewDidLoadWithNoNetworkingStatus
{
    // 配置UI界面
    [self createUITable];
    
    // 刷新表格
    [self.tableView reloadData];
}

#pragma mark - 创建界面

- (void)createUICate
{
    WEAKSELF(weakSelf);
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    CGFloat margin = 10.0;
    CGFloat cateItemHeight = 32.0;
    
    UIScrollView *cateAreaContainer = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.bounces = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:scrollView];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).with.offset(0);
            make.left.equalTo(weakSelf.view).with.offset(0);
            make.right.equalTo(weakSelf.view).with.offset(0);
            make.height.equalTo(@(cateItemHeight));
        }];
        scrollView;
    });
    self.cateAreaContainer = cateAreaContainer;
    
    UIView *container = ({
        UIView *container = [[UIView alloc] init];
        [container setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00]];
        [cateAreaContainer addSubview:container];
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cateAreaContainer);
            make.height.equalTo(cateAreaContainer);
        }];
        container;
    });
    
    UIView *lastView = nil;
    
    for (int i = 0; i < self.cateListData.count; i ++) {
        
        NSString *cateName = self.cateListData[i].CateName;
        
        UIView *subView = ({
            UIView *view = [[UIView alloc] init];
            [view setTag:i+1000];
            [container addSubview:view];

            // 标签标题宽度
            CGFloat cateItemWidth = 10.0;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0]};
            CGSize size = [cateName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              attributes:attributes
                                                 context:nil].size;
            cateItemWidth += size.width;
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(container).offset(0.0);
                make.bottom.equalTo(container).offset(0.0);
                make.width.equalTo(@(cateItemWidth));
                
                if (lastView) {
                    make.left.equalTo(lastView.mas_right).offset(2*margin);
                } else {
                    make.left.equalTo(container.mas_left).offset(margin);
                }
            }];
            
            // 点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressCateItemArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [view addGestureRecognizer:tapGesture];
            
            view;
        });
        
        lastView = subView;
        
        
        // 标题
        UILabel *cateNameLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [label setText:cateName];
            [label setFont:[UIFont systemFontOfSize:14.0]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [label setUserInteractionEnabled:YES];
            [label setTextColor:[UIColor blackColor]];
            [subView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(subView.mas_top).offset(0.0);
                make.left.equalTo(subView.mas_left).offset(0.0);
                make.right.equalTo(subView.mas_right).offset(-margin);
                make.bottom.equalTo(subView.mas_bottom).offset(0.0);
            }];
            
            label;
        });
        
        // 图标
        {
            UIImageView *iconImage = [UIImageView new];
            [iconImage setImage:[UIImage imageNamed:@"ico_group_arrow_right"]];
            [subView addSubview:iconImage];
            
            [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(subView.mas_centerY).offset(0.0);
                make.left.equalTo(cateNameLabel.mas_right).offset(margin/4.0);
                make.right.equalTo(subView.mas_right).offset(-margin/4.0);
                make.height.equalTo(@(margin));
            }];
        }
        
    }
    
    if (lastView) {
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lastView.mas_right).offset(margin);
        }];
    }


}


- (void)createUITable
{
    // 表格已经存在则无需创建，直接返回
    if (self.tableView) {
        return;
    }
    
    WEAKSELF(weakSelf);
    
    // 创建表格
    {
        // 创建表格
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = YES;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 添加约束
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.cateAreaContainer.mas_bottom).with.offset(0.0);
            make.left.equalTo(weakSelf.view).with.offset(0);
            make.bottom.equalTo(weakSelf.mas_bottomLayoutGuide).with.offset(0);
            make.right.equalTo(weakSelf.view).with.offset(0);
        }];
        
        // 自动算高 UITableView+FDTemplateLayoutCell
        self.tableView.estimatedRowHeight = 300; //预算行高
        self.tableView.fd_debugLogEnabled = YES; //开启log打印高度
        
        // 空白数据背景
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
        
        // 设置表格背景
        UIView *backView = [[UIView alloc] init];
        [backView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
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
        [self.tableView registerClass:[YHSBackHomeADTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_BACKHOME_AD];
        [self.tableView registerClass:[YHSBackHomeFoodieFavoriteGoodsTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_BACKHOME_FOODIEFAVORITE_GOODS];
        [self.tableView registerClass:[YHSBackHomeGoodTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_BACKHOME_GOODS];
    }
    
}

- (void)createUIBuyButton
{
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10.0;
    CGFloat shoppingSize = 40.0;
    
    self.button_shopping = [[YHSButtonWithIcon alloc] initWithFrame:CGRectMake(0, 0, shoppingSize, shoppingSize) haveLabel:YES];
    [self.button_shopping setIconLabelText:@"1"]; //icon label text
    [self.button_shopping setBaseImage:@"icon_shoping_car" highlightImage:@"icon_shoping_car"];
    [self.button_shopping setDownLabelColor:[UIColor whiteColor] highlightColor:[UIColor whiteColor]];//set label color
    [self.button_shopping setIconLabelColor:[UIColor whiteColor] highlightColor:[UIColor whiteColor]];//set icon label color
    [self.button_shopping addTarget:self action:@selector(pressShoppingButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button_shopping];
    
    [self.button_shopping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_bottomLayoutGuide).offset(-margin-shoppingSize);
        make.left.equalTo(weakSelf.view.mas_left).offset(1.5*margin);
        make.size.mas_equalTo(CGSizeMake(shoppingSize, shoppingSize));
    }];
    
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


- (void)loadDataThen:(void (^)(BOOL success, NSUInteger count))then andWritingLoading:(BOOL)showWritingLoading {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 手写Loading加载动画
    __block UIView *loadingContainerView = nil;
    __block YHSHandWritingLoadingView *writingLoadingVeiw = nil;
    if (showWritingLoading) {
        // 加载动画根容器
        loadingContainerView = [[YHSHandWritingLoadingView alloc] initWithFrame:CGRectMake(0, HEIGHT_NAVIGATION_STATUS, self.view.frame.size.width, self.view.frame.size.height-HEIGHT_NAVIGATION_STATUS-49)];
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
        NSString *url = [YHSBackHomeDataUtil getBackHomeMainRequestURLString];
        NSMutableDictionary *params = [YHSBackHomeDataUtil getBackHomeMainRequestParams];
        [params setObject:[NSString stringWithFormat:@"%ld", self.limit] forKey:@"limit"];
        [params setObject:[NSString stringWithFormat:@"%ld", self.offset] forKey:@"offset"];
        [params setObject:[NSString stringWithFormat:@"%ld", self.RecommendType] forKey:@"RecommendType"];
        
        // 初始化Manager
        AFHTTPSessionManager *manager = [YHSNetworkingManager sharedYHSNetworkingManagerInstance].manager;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 设置请求的数据格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 设置返回的数据格式
        
        // 请求网络数据前，先取消之前的请求，再发网络请求
        [manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
        
        // 请求网络数据
        [manager POST:url parameters:params constructingBodyWithBlock:^(id  _Nonnull formData) {
            // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            // 这里可以获取到目前的数据请求的进度
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 请求成功，解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSDictionary *data = dict[@"result"];
            
            
            /////////////////////////////////////////////////////////////////
            // A、请求返回的数据 -> 开始
            /////////////////////////////////////////////////////////////////
            
            // 0.头部分类标签
            {
                NSMutableArray<YHSBackHomeCateModel *> *cateModelArray = [NSMutableArray array];
                [data[@"CateList"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                    YHSBackHomeCateModel *model = [YHSBackHomeCateModel mj_objectWithKeyValues:dict];
                    [cateModelArray addObject:model];
                }];
                if (!weakSelf.cateListData) {
                    weakSelf.cateListData = cateModelArray.mutableCopy;
                }
            }
            
            // Table-0.广告栏数据
            {
                NSMutableArray<YHSBackHomeADModel *> *adModelArray = [NSMutableArray array];
                [data[@"ad"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                    YHSBackHomeADModel *model = [YHSBackHomeADModel mj_objectWithKeyValues:dict];
                    [adModelArray addObject:model];
                }];
                if (!weakSelf.adModels) {
                    weakSelf.adModels = adModelArray.mutableCopy;
                }
            }
            
            // Table-1.吃货最爱
            {
                NSMutableArray<YHSBackHomeFoodieFavoriteGoodsModel *> *favoriteGoodModelArray = [NSMutableArray array];
                [data[@"FoodieFavoriteGoods"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                    YHSBackHomeFoodieFavoriteGoodsModel *model = [YHSBackHomeFoodieFavoriteGoodsModel mj_objectWithKeyValues:dict];
                    [favoriteGoodModelArray addObject:model];
                }];
                if (!weakSelf.favoriteGoodModels) {
                    weakSelf.favoriteGoodModels = favoriteGoodModelArray.mutableCopy;
                }
            }
            
            // Table-2.逛逛商品
            {
                NSMutableArray<YHSBackHomeGoodsModel *> *goodModelArray = [NSMutableArray array];
                [data[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                    YHSBackHomeGoodsModel *model = [YHSBackHomeGoodsModel mj_objectWithKeyValues:dict];
                    [goodModelArray addObject:model];
                }];
                
                if (0 == _offset) {
                    weakSelf.goodModels = goodModelArray.mutableCopy;
                } else {
                    [weakSelf.goodModels addObjectsFromArray:goodModelArray.mutableCopy];
                }
            }
            
            
            /////////////////////////////////////////////////////////////////
            // A、请求返回的数据 -> 结束
            /////////////////////////////////////////////////////////////////
            
            
            /////////////////////////////////////////////////////////////////
            // B、配置数据源 DataSource  -> 开始
            /////////////////////////////////////////////////////////////////
            if (0 == _offset) {
                weakSelf.tableData = [NSMutableArray array];
                // Table-0.广告栏
                [weakSelf.tableData addObject:@[weakSelf.adModels].mutableCopy];
                
                // Table-1.吃货最爱
                [weakSelf.tableData addObject:@[weakSelf.favoriteGoodModels].mutableCopy];
                
                // Table-2.逛逛商品
                [weakSelf.tableData addObject:weakSelf.goodModels.mutableCopy];
            } else {
                // Table-0.广告栏
                [weakSelf.tableData replaceObjectAtIndex:0 withObject:@[weakSelf.adModels].mutableCopy];
                
                // Table-1.吃货最爱
                [weakSelf.tableData replaceObjectAtIndex:1 withObject:@[weakSelf.favoriteGoodModels].mutableCopy];
                
                // Table-2.逛逛商品
                [weakSelf.tableData replaceObjectAtIndex:2 withObject:weakSelf.goodModels.mutableCopy];
            }
            
            YHSLogRed(@"%ld", weakSelf.tableData[0].count);
            YHSLogRed(@"%ld", weakSelf.tableData[1].count);
            YHSLogRed(@"%ld", weakSelf.tableData[2].count);
            
            /////////////////////////////////////////////////////////////////
            // B、配置数据源 DataSource  -> 结束
            /////////////////////////////////////////////////////////////////
            
            
            // 请求数据成功
            isSuccess = YES;
            listCount = weakSelf.goodModels.count;
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


#pragma mark - 自定义配置导航栏
- (void)customNavigationBar
{
    [super customNavigationBar];
    
    // 自定义导航栏
    if (self.navigationController) {
        
        CGFloat margin = 10;

        // 1.自定义导航条
        self.navBarCustomView = [[YHSNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
        [self.navBarCustomView setBackgroundColor:COLOR_NAVIGATION_BAR];
        [self.navigationItem setTitleView:self.navBarCustomView];
        
        // 2.到家
        CGFloat iconWidth = 50.0f;
        CGFloat iconHeight = 22.0f;
        UIImageView *leftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(margin, ((HEIGHT_NAVIGATION_BAR-iconHeight)/2.0), iconWidth, iconHeight)];
        [leftIcon setImage:[UIImage imageNamed:@"logo_daojia"]];
        [leftIcon.layer setMasksToBounds:YES];
        [self.navBarCustomView addSubview:leftIcon];

        // 3.定位
        CGFloat locationWidth = 35.0;
        UILabel *loactionNavItem = ({
            UILabel *label = [[UILabel alloc] init];
            [label setText:@"[武汉]"];
            [label setFont:[UIFont systemFontOfSize:12.0]];
            [label setTextColor:COLOR_NAVIGATION_BAR_TITLE_LIGHTGRAY];
            [label setUserInteractionEnabled:YES];
            [self.navBarCustomView addSubview:label];
            
            // 添加点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviLocationBarButtonItemClicked:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1，注意在iOS中很少用双击操作
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [label addGestureRecognizer:tapGesture];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(leftIcon.mas_right).offset(margin/2.0);
                make.bottom.equalTo(leftIcon.mas_bottom).offset(0.0);
                make.size.mas_equalTo(CGSizeMake(locationWidth, 15));
            }];
            
            label;
        });
        self.loactionNavItem  = loactionNavItem;
        
        // 3.全部
        CGFloat allWidth = 50.0; // 最大值为44
        CGFloat allHeight = 25.0;
        UIButton *allItem = ({
            YHSAllButton *button = [[YHSAllButton alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-margin/2.0-allWidth, ((HEIGHT_NAVIGATION_BAR-allHeight)/2.0), allWidth, allHeight)];
            [button.layer setMasksToBounds:YES];
            [button setAdjustsImageWhenHighlighted:NO];
            [button setTitle:@"全部" forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0]];
            [button setTitleColor:COLOR_NAVIGATION_BAR_TITLE_YELLOW forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"btn_weaken_arrowdown_orange"] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(naviAllBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.navBarCustomView addSubview:button];
            
            button;
        });
        self.allItem  = allItem;
        
        // 4.导航条搜索按钮区域
        {
            // 4.1搜索区域主容器
            UIView *searchAreaView = ({
               UIView *searchAreaView = [[UIView alloc] initWithFrame:CGRectMake(2*margin+iconWidth+locationWidth, 7, self.navigationController.navigationBar.frame.size.width-iconWidth-locationWidth-allWidth-3.5*margin, self.navigationController.navigationBar.frame.size.height-14)];
                [searchAreaView.layer setBorderWidth:1.0f];
                [searchAreaView.layer setCornerRadius:6.0f];
                [searchAreaView.layer setBorderColor:COLOR_NAVIGATION_BAR_SEARCH.CGColor];
                [searchAreaView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]];
                [self.navBarCustomView addSubview:searchAreaView];
                
                // 添加点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressSearchArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1，注意在iOS中很少用双击操作
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [searchAreaView addGestureRecognizer:tapGesture];
                
                searchAreaView;
            });
            self.searchAreaView  = searchAreaView;
            
            // 4.2导航条搜索图标
            UIImageView *searchIconImageView = ({
                UIImageView *searchIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 22, 22)];
                [searchIconImageView setImage:[UIImage imageNamed:@"action_search_gray"]];
                [searchAreaView addSubview:searchIconImageView];
                
                searchIconImageView;
            });
            self.searchIconImageView = searchIconImageView;
            
            // 4.3导航条搜索标题
            UILabel *searchTitleLable = ({
                UILabel *searchTitleLable = [[UILabel alloc] init];
                [searchTitleLable setText:@"搜索商品"];
                [searchTitleLable setTextColor:COLOR_NAVIGATION_BAR_SEARCH_TITLE_GRAY];
                [searchTitleLable setFont:[UIFont boldSystemFontOfSize:13.0]];
                [searchAreaView addSubview:searchTitleLable];
                
                [searchTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(searchAreaView.mas_top).offset(5);
                    make.left.equalTo(searchIconImageView.mas_right).offset(5);
                    make.right.equalTo(searchAreaView.mas_right).offset(-5);
                    make.height.equalTo(@22);
                }];
                
                searchTitleLable;
            });
            self.searchTitleLable = searchTitleLable;
        }

        
        
    }
    
}

#pragma mark - 触发导航栏按钮事件

// 触发全部按钮事件
- (void)naviLocationBarButtonItemClicked:(UITapGestureRecognizer *)gesture
{
    [self alertPromptMessage:@""];
}

// 触发搜索按钮事件
- (void)pressSearchArea:(UITapGestureRecognizer *)gesture
{
    YHSCookBookSearchViewController *searchViewController = [YHSCookBookSearchViewController new];
    [self.navigationController pushViewController:searchViewController animated:YES];
}

// 触发全部按钮事件
- (void)naviAllBarButtonItemClicked:(UIButton *)button
{
    [button setImage:[UIImage imageNamed:@"btn_weaken_arrowup_orange"] forState:UIControlStateNormal];
    
    NSArray<NSString *> *itemTiltes = @[@"全部", @"附近", @"全国"];
    [YHSPopMenu popFromView:self.allItem rect:CGRectMake(0, 0, 50, 40*itemTiltes.count) itemTitles:itemTiltes selectedIndex:_RecommendType dismiss:^(NSInteger selected) {
        
        _RecommendType = selected;
        
        [button setTitle:itemTiltes[selected] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_weaken_arrowdown_orange"] forState:UIControlStateNormal];
        
        // 根据结果刷新数据
        {
            // 每次刷新时重置
            _offset = 0;
            
            // 加载更多数据
            [self loadMoreData];
            
            // 滚动到某行显示
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
            if (0 == _RecommendType) {
                indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            }
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    }];

}

// 点击分类按钮事件
- (void)pressCateItemArea:(UITapGestureRecognizer *)gesture
{
    
    UIView *view = (UIView *)[gesture view];
    NSInteger index = view.tag-1000;
    
    YHSLogBrown(@"%@ %@", self.cateListData[index].CateName, self.cateListData[index].CateId);
    
    [self alertPromptMessage:@"分类详情"];
    
}

#pragma mark - 触发购物按钮事件

- (void)pressShoppingButton:(YHSButtonWithIcon *)button
{
    [self alertPromptMessage:@"购物车"];
}


#pragma mark - 触发点击广告栏事件
- (void)didClickElementOfCellWithBackHomeADModel:(YHSBackHomeADModel *)model
{    
    // 提示信息
    [self alertPromptMessage:@"广告详情"];
}

#pragma mark - 触发点击表格 Secion 头部事件
- (void)didClickHeaderOfTableSecion:(NSInteger)tableSection
{
    [self alertPromptMessage:@""];
}

#pragma mark - 触发点击吃货最爱事件
- (void)didClickElementOfCellWithBackHomeFoodieFavoriteGoodsModels:(YHSBackHomeFoodieFavoriteGoodsModel *)model
{
    YHSLogRed(@"%@ %@", model.Title, model.Price);
    
    // 提示信息
    [self alertPromptMessage:@"吃货最爱"];
}

#pragma mark - 触发点击逛逛商品
// 用户详情
- (void)didClickElementOfCellWithUserDetailInfoAction:(YHSBackHomeGoodsModel *)model
{
    [self alertPromptMessage:@"用户详情"];
}

// 商品详情
- (void)didClickElementOfCellWithGoodDetailInfoInfoAction:(YHSBackHomeGoodsModel *)model
{
    [self alertPromptMessage:@"商品详情"];
}

// 立即购买
- (void)didClickElementOfCellWithBuyAction:(YHSBackHomeGoodsModel *)model{
    [self alertPromptMessage:@"立即购买"];
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
        case YHSBackHomeTableSectionAD: {
            YHSBackHomeADTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_BACKHOME_AD];
            if (!cell) {
                cell = [[YHSBackHomeADTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_BACKHOME_AD];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 吃货最爱
        case YHSBackHomeTableSectionFoodieFavoriteGoods: {
            YHSBackHomeFoodieFavoriteGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_BACKHOME_FOODIEFAVORITE_GOODS];
            if (!cell) {
                cell = [[YHSBackHomeFoodieFavoriteGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_BACKHOME_FOODIEFAVORITE_GOODS];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 逛逛商品
        case YHSBackHomeTableSectionGoodList: {
            YHSBackHomeGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_BACKHOME_GOODS];
            if (!cell) {
                cell = [[YHSBackHomeGoodTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_BACKHOME_GOODS];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        default: {
            return nil;
        }
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
            // 广告横幅
        case YHSBackHomeTableSectionAD: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_BACKHOME_AD cacheByIndexPath:indexPath configuration:^(YHSBackHomeADTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
            // 吃货最爱
        case YHSBackHomeTableSectionFoodieFavoriteGoods: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_BACKHOME_FOODIEFAVORITE_GOODS cacheByIndexPath:indexPath configuration:^(YHSBackHomeFoodieFavoriteGoodsTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
            // 逛逛商品
        case YHSBackHomeTableSectionGoodList: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_BACKHOME_GOODS cacheByIndexPath:indexPath configuration:^(YHSBackHomeGoodTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        default: {
            return 0.0;
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat height = 45.0;
    
    switch (section) {
        case YHSBackHomeTableSectionAD: {// 广告横幅
            return nil;
        }
        case YHSBackHomeTableSectionFoodieFavoriteGoods: { // 吃货最爱
            YHSBackHomeTableSectionHeaderView *sectionHeaderView = [[YHSBackHomeTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) title:@"吃货最爱" imageIcon:@"ico_favorite_version" tableSecion:YHSBackHomeTableSectionFoodieFavoriteGoods];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        case YHSBackHomeTableSectionGoodList: { // 逛逛商品
            YHSBackHomeTableSectionHeaderView *sectionHeaderView = [[YHSBackHomeTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) title:@"逛逛" imageIcon:@"ico_mybrowse" tableSecion:YHSBackHomeTableSectionFoodieFavoriteGoods];
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
        case YHSBackHomeTableSectionAD: { // 广告横幅
            return nil;
        }
        case YHSBackHomeTableSectionFoodieFavoriteGoods: { // 吃货最爱
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 10)];
            footerView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
            return footerView;
        }
        case YHSBackHomeTableSectionGoodList: { // 逛逛商品
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
        case YHSBackHomeTableSectionAD: { // 广告横幅
            return 0.01f;
        }
        case YHSBackHomeTableSectionFoodieFavoriteGoods: // 吃货最爱
        case YHSBackHomeTableSectionGoodList: { // 逛逛商品
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
        case YHSBackHomeTableSectionAD: { // 广告横幅
            return 0.01f;
        }
        case YHSBackHomeTableSectionFoodieFavoriteGoods: { // 吃货最爱
            return 6.0f;
        }
        case YHSBackHomeTableSectionGoodList: { // 逛逛商品
            return 0.01f;
        }
        default: {
            return 0.01f;
        }
    }
    
    return 0.01f;
}




@end
