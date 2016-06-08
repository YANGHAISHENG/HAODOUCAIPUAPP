//
//  YHSCookBookMainViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookMainViewController.h"
#import "YHSCookBookTableSectionHeaderView.h"

#import "YHSCookBookBannerModel.h"
#import "YHSCookBookToolsModel.h"
#import "YHSCookBookHotsAlbumModel.h"
#import "YHSCookBookYourLoveModel.h"
#import "YHSCookBookRecommedModel.h"
#import "YHSCookBookGoodsModel.h"
#import "YHSCookBookQualityReadModel.h"
#import "YHSCookBookHotsActivityModel.h"
#import "YHSCookBookHaoDouVIPModel.h"
#import "YHSCookBookPublishModel.h"

#import "YHSCookBookBannerTableViewCell.h"
#import "YHSCookBookToolsTableViewCell.h"
#import "YHSCookBookHotsAlbumTableViewCell.h"
#import "YHSCookBookYourLoveTableViewCell.h"
#import "YHSCookBookRecommedTableViewCell.h"
#import "YHSCookBookGoodsTableViewCell.h"
#import "YHSCookBookQualityReadTableViewCell.h"
#import "YHSCookBookHotsActivityTableViewCell.h"
#import "YHSCookBookHaoDouVIPTableViewCell.h"
#import "YHSCookBookPublishTableViewCell.h"

#import "YHSCategoryViewController.h"
#import "YHSCategorySearchResultViewController.h"
#import "YHSCookBookSearchViewController.h"
#import "YHSCookBookBannnerDetailCollectViewController.h"
#import "YHSCookBookHotsAlbumMoreViewController.h"
#import "YHSCookBookHotsAlbumMainDetailViewController.h"
#import "YHSCookBookYourLoveMoreViewController.h"
#import "YHSCookBookShakeItOffViewController.h"
#import "YHSCookBookBannnerDetailRecipeDishVideoViewController.h"
#import "YHSCookBookBannnerDetailRecipeDishPictureViewController.h"

#import "YHSCookBookShowProductViewController.h"
#import "YHSCookBookShowVideoViewController.h"
#import "YHSCookBookKitchenViewController.h"


@interface YHSCookBookMainViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, YHSCookBookTableSectionHeaderViewDelegate, YHSCookBookBannerTableViewCellDelegate, YHSCookBookToolsTableViewCellDelegate, YHSCookBookHotsAlbumTableViewCellDelegate, YHSCookBookYourLoveTableViewCellDelegate, YHSCookBookRecommedTableViewCellDelegate, YHSCookBookGoodsTableViewCellDelegate, YHSCookBookQualityReadTableViewCellDelegate, YHSCookBookHotsActivityTableViewCellDelegate, YHSCookBookHaoDouVIPTableViewCellDelegate, YHSCookBookPublishTableViewCellDelegate>

// 导航栏区域
@property (nonatomic, strong) UIView *navHiddenView; // 自定义导航条中透明层
@property (nonatomic, strong) UIView *searchAreaView; // 导航条搜索按钮区域
@property (nonatomic, strong) UIImageView *searchIconImageView; // 导航条搜索图标
@property (nonatomic, strong) UILabel *searchTitleLable; // 导航条搜索标题
@property (nonatomic, strong) UIImageView *categoryAreaView; // 导航条分类按钮区域

// 主页表格内容
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *tableData; // 数据源
@property (nonatomic, strong) NSMutableArray<YHSCookBookToolsModel *> *toolsModels; // 工具栏数据
@property (nonatomic, strong) NSMutableArray<YHSCookBookBannerModel *> *bannerModels; // 广告栏数据
@property (nonatomic, strong) YHSCookBookHotsAlbumModel *hotsAlbumModel; // 热门专辑
@property (nonatomic, strong) YHSCookBookYourLoveModel *yourLoveModel; // 猜你喜欢
@property (nonatomic, strong) YHSCookBookRecommedModel *recommedModel; // 热门推荐
@property (nonatomic, strong) YHSCookBookGoodsModel *goodsModel; // 到家商品
@property (nonatomic, strong) YHSCookBookQualityReadModel *readModel; // 精品阅读
@property (nonatomic, strong) YHSCookBookHotsActivityModel *activityModel; // 热门活动
@property (nonatomic, strong) YHSCookBookHaoDouVIPModel *vipModel; // 好豆达人
@property (nonatomic, strong) YHSCookBookPublishModel *publishModel; // 分享美食

// 记录TableView ScrollView 的偏移量
@property (nonatomic, assign) CGFloat table_scroll_view_offsetY;

@end


@implementation YHSCookBookMainViewController


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
        
        [self loadDataThen:^(BOOL success){
            
            // 配置UI界面
            [weakSelf createUITable];
            
            // 刷新表格
            [weakSelf.tableView reloadData];
            
            // 显示导航区域
            if (success) {
                [self setNavigationBarAreaByOffsetY:0.0]; // 显示透明导航栏
            } else {
                [self setNavigationBarAreaByOffsetY:SCROLL_BANNER_HEIGHT]; // 显示不透明导航栏
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


// 监听网络变化后执行
- (void)doWithNetworkReachabilityStatus:(YHSNetworkReachabilityStatus)networkReachabilityStatus
{
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 判断当前网络状态
    switch (networkReachabilityStatus) {
        case YHSNetworkReachabilityStatusUnknown:
        case YHSNetworkReachabilityStatusNotReachable: {
            
            // 根据网络状态进行加载处理
            [self viewDidLoadWithNoNetworkingStatus];
            
            // 无网络状态提示信息
            if (!self.currentNetworkReachabilityStatusLabel) {
                UILabel *currentNetworkReachabilityStatusLabel = ({
                    NSString *title = @"世界上最遥远的距离就是没网。请检查网络设置。";
                    UILabel *label = [[UILabel alloc] init];
                    [self.view addSubview:label];
                    [label setText:title];
                    [label setTextColor:[UIColor whiteColor]];
                    [label setFont:[UIFont boldSystemFontOfSize:LOADING_FONT_SIZE]];
                    [label setTextAlignment:NSTextAlignmentCenter];
                    [label.layer setCornerRadius:0.0];
                    [label.layer setMasksToBounds:YES];
                    [label setBackgroundColor:[UIColor colorWithRed:1.00 green:0.77 blue:0.18 alpha:1.00]];
                    
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(0.0);
                        make.centerX.equalTo(weakSelf.view.mas_centerX).offset(0);
                        make.width.equalTo(weakSelf.view.mas_width);
                        make.height.equalTo(@(LOADING_VIEW_HEIGHT));
                    }];
                    
                    label;
                });
                self.currentNetworkReachabilityStatusLabel = currentNetworkReachabilityStatusLabel;
            }
            
            self.table_scroll_view_offsetY = self.tableView.contentOffset.y; // 保存偏移量
            [self setNavigationBarAreaByOffsetY:SCROLL_BANNER_HEIGHT]; // 显示不透明导航栏

            return;
        }
        case YHSNetworkReachabilityStatusReachableViaWWAN:
        case YHSNetworkReachabilityStatusReachableViaWiFi: {
            
            // 删除网络状态提示信息
            if (self.currentNetworkReachabilityStatusLabel) {
                [self.currentNetworkReachabilityStatusLabel removeFromSuperview];
                self.currentNetworkReachabilityStatusLabel = nil;
            }
            
            // 显示导航栏，并根据table_scroll_view_offsetY设置透明度
            [self setNavigationBarAreaByOffsetY:self.table_scroll_view_offsetY];
            
            // 根据网络状态进行加载处理
            [self viewDidLoadWithNetworkingStatus];

        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 创建界面
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
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 添加约束
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).with.offset(HEIGHT_NAVIGATION_STATUS);
            make.left.equalTo(weakSelf.view).with.offset(0);
            make.bottom.equalTo(weakSelf.mas_bottomLayoutGuide).with.offset(0);
            make.right.equalTo(weakSelf.view).with.offset(0);
        }];
        
        // 自动算高 UITableView+FDTemplateLayoutCell
        self.tableView.estimatedRowHeight = 500; //预算行高
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
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataWithWritingLoading:)];
        
        // 必须被注册到 UITableView 中
        [self.tableView registerClass:[YHSCookBookBannerTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_BANNER];
        [self.tableView registerClass:[YHSCookBookToolsTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_TOOLS];
        [self.tableView registerClass:[YHSCookBookHotsAlbumTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_HOTS_ALBUM];
        [self.tableView registerClass:[YHSCookBookYourLoveTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_YOUR_LOVE];
        [self.tableView registerClass:[YHSCookBookRecommedTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_RECOMMED];
        [self.tableView registerClass:[YHSCookBookGoodsTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_GOODS];
        [self.tableView registerClass:[YHSCookBookQualityReadTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_QUALITY_READ];
        [self.tableView registerClass:[YHSCookBookHotsActivityTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_HOTS_ACTIVITY];
        [self.tableView registerClass:[YHSCookBookHaoDouVIPTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_HAODOU_VIP];
        [self.tableView registerClass:[YHSCookBookPublishTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_PUBLISH];

    }

}


#pragma mark - 请求网络数据
- (void)loadDataWithWritingLoading:(BOOL)showWritingLoading
{
    WEAKSELF(weakSelf);
    
    // 验证网络状态，无网则直接返回
    if ([YHSNetworkingManager sharedYHSNetworkingManagerInstance].networkReachabilityStatus == YHSNetworkReachabilityStatusUnknown
        || [YHSNetworkingManager sharedYHSNetworkingManagerInstance].networkReachabilityStatus == YHSNetworkReachabilityStatusNotReachable) {
        
        // 上拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
        
        // 显示不透明导航栏
        [self setNavigationBarAreaByOffsetY:SCROLL_BANNER_HEIGHT];
        
        // 直接返回
        return;
        
    } else {
        
        // 请求数据
        [self loadDataThen:^(BOOL success){
            
            // 上拉刷新控件，结束刷新状态
            [weakSelf.tableView.mj_header endRefreshing];
            
            // 显示导航区域
            [self setNavigationBarAreaByOffsetY:0.0];
            
            // 加载成功
            if (success) {
                
                // 刷新表格
                [weakSelf.tableView reloadData];
                
            }
            
        } andWritingLoading:NO];
        
    }
  
}

- (void)loadDataThen:(void (^)(BOOL success))then andWritingLoading:(BOOL)showWritingLoading {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 手写Loading加载动画
    __block UIView *loadingContainerView = nil;
    __block YHSHandWritingLoadingView *writingLoadingVeiw = nil;
    if (showWritingLoading) {
        // 显示导航区域
        [self setNavigationBarAreaByOffsetY:SCROLL_BANNER_HEIGHT];
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
        
        // 请求地址与参数
        NSString *url = [YHSCookBookDataUtil getCookBookMainRequestURLString];
        NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookMainRequestParams];
        
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
            
            // 0.广告横幅
            {
                NSMutableArray<YHSCookBookBannerModel *> *bannerModelArray = [NSMutableArray array];
                [data[@"recipe"][@"list"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                    YHSCookBookBannerModel *model = [YHSCookBookBannerModel mj_objectWithKeyValues:dict];
                    
                    /*
                     {
                     "Title": "活动",
                     "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463741843.jpg",
                     "Url": "haodourecipe:\/\/haodou.com\/openurlid\/?id=590044"
                     }, {
                     "Title": "成都美食大盘点",
                     "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463739108.jpg",
                     "Url": "haodourecipe:\/\/haodou.com\/collect\/info\/?id=9571757"
                     }, {
                     "Title": "活动",
                     "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463877710.jpg",
                     "Url": "haodourecipe:\/\/haodou.com\/opentopic\/?url=http%3A%2F%2Fm.haodou.com%2Ftopic-458446.html&id=458446"
                     }, {
                     "Title": "超赞的下饭菜",
                     "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463738785.jpg",
                     "Url": "haodourecipe:\/\/haodou.com\/collect\/info\/?id=12599959"
                     }, {
                     "Title": "我们“蕉”往吧",
                     "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463743624.jpg",
                     "Url": "haodourecipe:\/\/haodou.com\/collect\/info\/?id=12600047"
                     }, {
                     "Title": "鱼香肉丝",
                     "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463743688.jpg",
                     "Url": "haodourecipe:\/\/haodou.com\/recipe\/info\/?id=1071703&video=0"
                     }, {
                     "Title": "红薯干果粥",
                     "Img": "http:\/\/img1.hoto.cn\/haodou\/recipe_mobile_ad\/2016\/05\/1463568626.jpg",
                     "Url": "haodourecipe:\/\/haodou.com\/recipe\/info\/?id=1070878&video=0"
                     }
                     */
                    
                    // 过滤数据（现阶段只有collect、recipe可以访问）
                    if ([model.Url hasContainString:YHS_BANNER_FILTER_COLLECT] || [model.Url hasContainString:YHS_BANNER_FILTER_RECIPE]) {
                        [bannerModelArray addObject:model];
                    }
                }];
                weakSelf.bannerModels = bannerModelArray.mutableCopy;
            }
            
            // 1.五大工具分类
            {
                NSMutableArray<YHSCookBookToolsModel *> *toolsModelArray = [NSMutableArray array];
                [data[@"tools"][@"list"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                    YHSCookBookToolsModel *model = [YHSCookBookToolsModel mj_objectWithKeyValues:dict];
                    [toolsModelArray addObject:model];
                }];
                weakSelf.toolsModels = toolsModelArray.mutableCopy;
            }
            
            // 2.热门专辑
            {
                YHSCookBookHotsAlbumModel *model = [YHSCookBookHotsAlbumModel mj_objectWithKeyValues:data[@"album"]];
                self.hotsAlbumModel = model;
            }
            
            // 3.猜你喜欢
            {
                YHSCookBookYourLoveModel *model = [YHSCookBookYourLoveModel mj_objectWithKeyValues:data[@"person"]];
                self.yourLoveModel = model;
            }
            
            // 4.热门推荐
            {
                YHSCookBookRecommedModel *model = [YHSCookBookRecommedModel mj_objectWithKeyValues:data[@"recommed"]];
                self.recommedModel = model;
            }
            
            // 5.到家商品
            {
                YHSCookBookGoodsModel *model = [YHSCookBookGoodsModel mj_objectWithKeyValues:data[@"goods"]];
                self.goodsModel = model;
            }
            
            // 6.精品阅读
            {
                YHSCookBookQualityReadModel *model = [YHSCookBookQualityReadModel mj_objectWithKeyValues:data[@"read"]];
                self.readModel = model;
            }
            
            // 7.热门活动
            {
                YHSCookBookHotsActivityModel *model = [YHSCookBookHotsActivityModel mj_objectWithKeyValues:data[@"event"]];
                self.activityModel = model;
            }
            
            // 8.好豆达人
            {
                YHSCookBookHaoDouVIPModel *model = [YHSCookBookHaoDouVIPModel mj_objectWithKeyValues:data[@"vip"]];
                self.vipModel = model;
            }
            
            // 9.分享美食
            {
                YHSCookBookPublishModel *model = [YHSCookBookPublishModel mj_objectWithKeyValues:data[@"publish"]];
                self.publishModel = model;
            }
            
            /////////////////////////////////////////////////////////////////
            // A、请求返回的数据 -> 结束
            /////////////////////////////////////////////////////////////////
            
            
            /////////////////////////////////////////////////////////////////
            // B、配置数据源 DataSource  -> 开始
            /////////////////////////////////////////////////////////////////
            // 0.广告横幅
            [self.tableData addObject:@[self.bannerModels].mutableCopy];
            
            // 1.分类工具
            [self.tableData addObject:@[self.toolsModels].mutableCopy];
            
            // 2.热门专辑
            [self.tableData addObject:@[self.hotsAlbumModel].mutableCopy];
            
            // 3.猜你喜欢
            [self.tableData addObject:@[self.yourLoveModel].mutableCopy];
            
            // 4.热门推荐
            [self.tableData addObject:@[self.recommedModel].mutableCopy];
            
            // 5.到家商品
            [self.tableData addObject:@[self.goodsModel].mutableCopy];
            
            // 6.精品阅读
            [self.tableData addObject:@[self.readModel].mutableCopy];
            
            // 7.热门活动
            [self.tableData addObject:@[self.activityModel].mutableCopy];
            
            // 8.好豆达人
            [self.tableData addObject:@[self.vipModel].mutableCopy];
            
            // 9.分享美食
            [self.tableData addObject:@[self.publishModel].mutableCopy];
            
            /////////////////////////////////////////////////////////////////
            // B、配置数据源 DataSource  -> 结束
            /////////////////////////////////////////////////////////////////
            
            
            // 请求数据成功
            isSuccess = YES;
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 删除手写Loading加载动画
                if (showWritingLoading) {
#ifdef DEBUG
                    sleep(LOADING_SLEEP_TIME); // 测试用延迟看效果
#endif
                    [self setNavigationBarAreaByOffsetY:0.0]; // 显示透明导航栏
                    [writingLoadingVeiw dismiss];
                    [loadingContainerView removeFromSuperview];
                }
                
                // 刷新界面
                !then ?: then(isSuccess);
                
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
                    [self setNavigationBarAreaByOffsetY:0.0]; // 显示透明导航栏
                    [writingLoadingVeiw dismiss];
                    [loadingContainerView removeFromSuperview];
                }
                
                // 刷新界面
                !then ?: then(isSuccess);
                
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
    
    WEAKSELF(weakSelf);
    
    // 自定义导航栏
    if (self.navigationController.navigationBar) {
        // 1.自定义导航条
        {
            self.navBarCustomView = [[YHSNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
            // 方法一
            [self.navigationItem setTitleView:self.navBarCustomView];
            // 方法二
            //[self.navigationController.navigationBar addSubview:self.navBarCustomView];
        }

        
        // 2.导航条中透明层（搜索区域、分类区域的父视图）
        UIView *navHiddenView = ({
            UIView *view = [[UIView alloc] init];
            [view setBackgroundColor:COLOR_NAVIGATION_BAR];
            [view setAlpha:0.0];
            [self.navBarCustomView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(weakSelf.navBarCustomView);
            }];
            
            view;
        });
        self.navHiddenView = navHiddenView;

        
        // 3.导航条搜索按钮区域
        {
            // 3.1搜索区域主容器
            UIView *searchAreaView = ({
                UIView *searchAreaView = [[UIView alloc] initWithFrame:CGRectMake(20, 7, self.navigationController.navigationBar.frame.size.width-90, self.navigationController.navigationBar.frame.size.height-14)];
                [searchAreaView.layer setBorderWidth:1.0f];
                [searchAreaView.layer setCornerRadius:6.0f];
                [searchAreaView.layer setBorderColor:COLOR_NAVIGATION_BAR_SEARCH.CGColor];
                [self.navBarCustomView addSubview:searchAreaView];
                
                // 添加点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressSearchArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1，注意在iOS中很少用双击操作
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [searchAreaView addGestureRecognizer:tapGesture];
                
                searchAreaView;
            });
            self.searchAreaView  = searchAreaView;
            
            // 3.2导航条搜索图标
            UIImageView *searchIconImageView = ({
                UIImageView *searchIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 22, 22)];
                [searchIconImageView setImage:[UIImage imageNamed:@"action_search_white"]];
                [searchAreaView addSubview:searchIconImageView];
                
                searchIconImageView;
            });
            self.searchIconImageView = searchIconImageView;
            
            // 3.3导航条搜索标题
            UILabel *searchTitleLable = ({
                UILabel *searchTitleLable = [[UILabel alloc] init];
                [searchTitleLable setText:@"搜索菜谱、专辑、豆友"];
                [searchTitleLable setTextColor:COLOR_NAVIGATION_BAR_SEARCH_TITLE_WHITE];
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

        
        // 4.导航条分类按钮区域
        UIImageView *categoryAreaView = ({
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-50, 7, 30, 30)];
            [imageView setUserInteractionEnabled:YES];
            [imageView setImage:[UIImage imageNamed:@"bar_category_foreground"]];
            [self.navBarCustomView addSubview:imageView];

            // 添加点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressCategoryArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1，注意在iOS中很少用双击操作
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [imageView addGestureRecognizer:tapGesture];
            
            imageView;
        });
        self.categoryAreaView = categoryAreaView;
        
    }
    
}

// 导航栏的透明度及搜索区域的颜色变化配置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 显示导航区域
    if ([YHSNetworkingManager sharedYHSNetworkingManagerInstance].networkReachabilityStatus == YHSNetworkReachabilityStatusReachableViaWWAN
        || [YHSNetworkingManager sharedYHSNetworkingManagerInstance].networkReachabilityStatus == YHSNetworkReachabilityStatusReachableViaWiFi) {
        
        self.table_scroll_view_offsetY = scrollView.contentOffset.y;
        
        [self setNavigationBarAreaByOffsetY:self.table_scroll_view_offsetY];
    }
    
}

// 根据偏移量设置导航栏的透明度及搜索区域的颜色变化配置
- (void)setNavigationBarAreaByOffsetY:(CGFloat)offsetY
{
    if (offsetY == 0.0) {
        // 导航栏必须显示
        self.navBarCustomView.alpha = 1.0;
        
        // 设置导航条透明层
        self.navHiddenView.alpha = 0.0;
        
        // 设置搜索区域
        [self.searchAreaView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:0.0]];
        [self.searchIconImageView setImage:[UIImage imageNamed:@"action_search_white"]];
        [self.searchTitleLable setTextColor:COLOR_NAVIGATION_BAR_SEARCH_TITLE_WHITE];
        
    } else if (offsetY < 0.0) {
        
        // 逐渐隐藏导航条
        float alpha = (offsetY + HEIGHT_NAVIGATION_BAR) / HEIGHT_NAVIGATION_BAR;
        alpha = alpha < 0.0 ? 0.0 :alpha;
        self.navBarCustomView.alpha = alpha;
        
        // 设置导航条透明层
        self.navHiddenView.alpha = 0.0;
        
        // 设置搜索区域
        [self.searchAreaView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:0.0]];

    } else {

        // 导航栏必须显示
        self.navBarCustomView.alpha = 1.0;
        
        // 设置导航条透明层
        float alpha = offsetY / (SCROLL_BANNER_HEIGHT - HEIGHT_NAVIGATION_BAR - HEIGHT_NAVIGATION_STATUS);
        alpha = alpha > 1.0 ? 1.0 :alpha;
        self.navHiddenView.alpha = alpha;
        
        // 设置搜索区域
        [self.searchAreaView setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:alpha]];
        if (alpha > 0.5) {
            [self.searchIconImageView setImage:[UIImage imageNamed:@"action_search_gray"]];
            [self.searchTitleLable setTextColor:COLOR_NAVIGATION_BAR_SEARCH_TITLE_GRAY];
        } else {
            [self.searchIconImageView setImage:[UIImage imageNamed:@"action_search_white"]];
            [self.searchTitleLable setTextColor:COLOR_NAVIGATION_BAR_SEARCH_TITLE_WHITE];
        }

    }
    
}

#pragma mark - 触发搜索按钮事件
- (void)pressSearchArea:(UITapGestureRecognizer *)gesture
{
    YHSCookBookSearchViewController *searchViewController = [YHSCookBookSearchViewController new];
    [self.navigationController pushViewController:searchViewController animated:YES];
}


#pragma mark - 触发分类按钮事件
- (void)pressCategoryArea:(UITapGestureRecognizer *)gesture
{
    YHSLogLight(@"%s", __FUNCTION__);
    
    YHSCategoryViewController *viewController = [YHSCategoryViewController new];
    [viewController setTitle:@"分类"];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - 触发点击表格 Secion 头部事件
- (void)didClickHeaderOfTableSecion:(NSInteger)tableSection
{
    switch (tableSection) {
        case YHSCookBookTableSectionBanner:
        case YHSCookBookTableSectionTools: { // 分类工具
            
            return ;
        }
        case YHSCookBookTableSectionHotsAlbum: { // 热门专辑
            YHSCookBookHotsAlbumMoreViewController *hotsAlbumViewController = [YHSCookBookHotsAlbumMoreViewController new];
            [hotsAlbumViewController setTitle:@"专辑"];
            [self.navigationController pushViewController:hotsAlbumViewController animated:YES];
            
            return ;
        }
        case YHSCookBookTableSectionYourLove: { // 猜你喜欢
            NSString *type = @"猜你喜欢";
            YHSCookBookYourLoveMoreViewController *loveViewController = [YHSCookBookYourLoveMoreViewController new];
            [loveViewController setType:type];
            [loveViewController setTitle:type];
            [self.navigationController pushViewController:loveViewController animated:YES];
            
            return ;
        }
        case YHSCookBookTableSectionRecommed: // 热门推荐
        case YHSCookBookTableSectionGoods: { // 到家商品
            
            return ;
        }
        case YHSCookBookTableSectionQualityRead: { // 精品阅读

            [self alertPromptMessage:@"精品阅读"];
            
            return ;
        }
        case YHSCookBookTableSectionHotsActivity: { // 热门活动

            [self alertPromptMessage:@"热门活动"];
            
            return ;
        }
        case YHSCookBookTableSectionHaoDouVIP: { // 好豆达人

            [self alertPromptMessage:@"好豆达人"];
            
            return ;
        }
        case YHSCookBookTableSectionPublish: { // 分享美食
            
            return ;
        }
    }
    
}

#pragma mark - 触发点击广告栏事件
- (void)didClickElementOfCellWithBannerModel:(YHSCookBookBannerModel *)model
{
    if ([model.Url hasContainString:YHS_BANNER_FILTER_COLLECT])
    {
        
        NSRange range = [model.Url rangeOfString:@"?id=" options:NSBackwardsSearch];
        NSString *aid = [model.Url substringFromIndex:range.location+range.length];
        
        YHSCookBookBannnerDetailCollectViewController *bannerDetailCollectController = [YHSCookBookBannnerDetailCollectViewController new];
        [bannerDetailCollectController setAppqs:model.Url];
        [bannerDetailCollectController setAid:aid];
        [bannerDetailCollectController setTitle:@" "];
        [self.navigationController pushViewController:bannerDetailCollectController animated:YES];
        
    } else {
        
        NSRange range = [model.Url rangeOfString:@"?id=" options:NSBackwardsSearch];
        NSString *aid_video = [model.Url substringFromIndex:range.location+range.length];
        NSArray<NSString *> *aidVideoArray = [aid_video componentsSeparatedByString:@"&"];
        if (aidVideoArray.count < 2) {
            return;
        }
        
        // 菜谱详情界面
        if ([@"1" isEqualToString:aidVideoArray[1]]) {
            // 视屏菜谱
            YHSCookBookBannnerDetailRecipeDishVideoViewController *dishVideoViewController = [YHSCookBookBannnerDetailRecipeDishVideoViewController new];
            [dishVideoViewController setRid:aidVideoArray[0]];
            [dishVideoViewController setAppqs:model.Url];
            [dishVideoViewController setTitle:@" "];
            [self.navigationController pushViewController:dishVideoViewController animated:YES];
        } else {
            // 图片菜谱
            YHSCookBookBannnerDetailRecipeDishPictureViewController *dishVedioViewController = [YHSCookBookBannnerDetailRecipeDishPictureViewController new];
            [dishVedioViewController setRid:aidVideoArray[0]];
            [dishVedioViewController setAppqs:model.Url];
            [dishVedioViewController setTitle:@" "];
            [self.navigationController pushViewController:dishVedioViewController animated:YES];
        }
    }

}



#pragma mark - 触发点击分类事件
- (void)didClickElementOfCellWithToolModel:(YHSCookBookToolsModel *)model
{
    if ([model.Title isEqual:@"美食汇"]) {

        // 跳转到家页面
        [self.tabBarController setSelectedIndex:1];
        
    } else if ([model.Title isEqual:@"晒作品"]) {
        
        YHSCookBookShowProductViewController *viewController = [YHSCookBookShowProductViewController new];
        [viewController setTitle:@"晒作品"];
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if ([model.Title isEqual:@"视频"]) {
        
        YHSCookBookShowVideoViewController *viewController = [YHSCookBookShowVideoViewController new];
        [viewController setTitle:@"视频"];
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if ([model.Title isEqual:@"厨房宝典"]) {
        
        YHSCookBookKitchenViewController *viewController = [YHSCookBookKitchenViewController new];
        [viewController setTitle:@"厨房宝典"];
        [self.navigationController pushViewController:viewController animated:YES];
        
    } else if ([model.Title isEqual:@"摇一摇"]) {
        
        YHSCookBookShakeItOffViewController *shakeItOffController = [YHSCookBookShakeItOffViewController new];
        [shakeItOffController setTitle:@"摇一摇"];
        [self.navigationController pushViewController:shakeItOffController animated:YES];
        
    } else {
        // 提示信息
        [self alertPromptMessage:@"分类标签"];
    }
    
}

#pragma mark - 触发点击热门专辑事件
- (void)didClickElementOfCellWithHotsAlbumModel:(YHSCookBookToolsModel *)model
{
    NSRange range = [model.Url rangeOfString:@"?id=" options:NSBackwardsSearch];
    NSString *aid = [model.Url substringFromIndex:range.location+range.length];
    
    YHSCookBookHotsAlbumMainDetailViewController *hotsAlbumDetailController = [YHSCookBookHotsAlbumMainDetailViewController new];
    [hotsAlbumDetailController setAppqs:model.Url];
    [hotsAlbumDetailController setAid:aid];
    [hotsAlbumDetailController setTitle:@" "];
    [self.navigationController pushViewController:hotsAlbumDetailController animated:YES];
}

#pragma mark - 触发点击猜你喜欢事件
- (void)didClickElementOfCellWithYourLoveModel:(YHSCookBookYourLoveElemModel *)model
{
    YHSCategorySearchResultViewController *searchResultController = [YHSCategorySearchResultViewController new];
    [searchResultController setTagId:[NSString stringWithFormat:@"%ld", model.CateId]];
    [searchResultController setTagName:model.CateName];
    [searchResultController setTitle:model.CateName];
    [self.navigationController pushViewController:searchResultController animated:YES];
}

#pragma mark - 触发点击热门推荐事件-热门菜谱/营养健康
- (void)didClickElementOfCellWithRecommedElemModel:(YHSCookBookRecommedElemModel *)model
{
    // 提示信息
    [self alertPromptMessage:@"热门菜谱/营养健康"];
}

#pragma mark - 触发点击热门推荐事件-广告
- (void)didClickElementOfCellWithRecommedADModel:(YHSCookBookRecommedADModel *)model
{
    // 提示信息
    [self alertPromptMessage:@"热门推广"];
}

#pragma mark - 触发点击到家商品事件
- (void)didClickElementOfCellWithGoodsElemModel:(YHSCookBookGoodsElemModel *)model
{
    // 提示信息
    [self alertPromptMessage:@"到家商品"];
}

#pragma mark - 触发点击精品阅读事件
- (void)didClickElementOfCellWithQualityReadModel:(YHSCookBookQualityReadElemModel *)model
{
    // 提示信息
    [self alertPromptMessage:@"精品阅"];
}

#pragma mark - 触发点击热门活动读事件
- (void)didClickElementOfCellWithHotsActivityModel:(YHSCookBookHotsActivityElemModel *)model
{
    // 提示信息
    [self alertPromptMessage:@"热门活动"];
}

#pragma mark - 触发点击海豆达人事件
- (void)didClickElementOfCellWithHaoDouVIPModel:(YHSCookBookHaoDouVIPElemModel *)model
{
    // 提示信息
    [self alertPromptMessage:@"海豆达人"];
}

#pragma mark - 触发点击分享美食事件
- (void)didClickElementOfCellWithPublishModel:(YHSCookBookPublishModel *)model
{
    // 提示信息
    [self alertPromptMessage:@"分享美食"];
}


#pragma mark - 提示信息
- (void)alertPromptMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"[%@]功能模块正在开发中，请使用其它功能！", message] preferredStyle:UIAlertControllerStyleAlert];
    
    // 取消
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alertController addAction:cancleAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
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
        case YHSCookBookTableSectionBanner: {
            YHSCookBookBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_BANNER];
            if (!cell) {
                cell = [[YHSCookBookBannerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_BANNER];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 分类工具
        case YHSCookBookTableSectionTools: {
            YHSCookBookToolsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_TOOLS];
            if (!cell) {
                cell = [[YHSCookBookToolsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_TOOLS];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 热门专辑
        case YHSCookBookTableSectionHotsAlbum: {
            YHSCookBookHotsAlbumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_HOTS_ALBUM];
            if (!cell) {
                cell = [[YHSCookBookHotsAlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_HOTS_ALBUM];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 猜你喜欢
        case YHSCookBookTableSectionYourLove: {
            YHSCookBookYourLoveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_YOUR_LOVE];
            if (!cell) {
                cell = [[YHSCookBookYourLoveTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_YOUR_LOVE];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 热门推荐
        case YHSCookBookTableSectionRecommed: {
            YHSCookBookRecommedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_RECOMMED];
            if (!cell) {
                cell = [[YHSCookBookRecommedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_RECOMMED];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 到家商品
        case YHSCookBookTableSectionGoods: {
            YHSCookBookGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_GOODS];
            if (!cell) {
                cell = [[YHSCookBookGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_GOODS];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 精品阅读
        case YHSCookBookTableSectionQualityRead: {
            YHSCookBookQualityReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_QUALITY_READ];
            if (!cell) {
                cell = [[YHSCookBookQualityReadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_QUALITY_READ];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 热门活动
        case YHSCookBookTableSectionHotsActivity: {
            YHSCookBookHotsActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_HOTS_ACTIVITY];
            if (!cell) {
                cell = [[YHSCookBookHotsActivityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_HOTS_ACTIVITY];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 好豆达人
        case YHSCookBookTableSectionHaoDouVIP: {
            YHSCookBookHaoDouVIPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_HAODOU_VIP];
            if (!cell) {
                cell = [[YHSCookBookHaoDouVIPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_HAODOU_VIP];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 分享美食
        case YHSCookBookTableSectionPublish: {
            YHSCookBookPublishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_PUBLISH];
            if (!cell) {
                cell = [[YHSCookBookPublishTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_PUBLISH];
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
        case YHSCookBookTableSectionBanner: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_BANNER cacheByIndexPath:indexPath configuration:^(YHSCookBookBannerTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 分类工具
        case YHSCookBookTableSectionTools: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_TOOLS cacheByIndexPath:indexPath configuration:^(YHSCookBookToolsTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 热门专辑
        case YHSCookBookTableSectionHotsAlbum: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_HOTS_ALBUM cacheByIndexPath:indexPath configuration:^(YHSCookBookHotsAlbumTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 猜你喜欢
        case YHSCookBookTableSectionYourLove: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_YOUR_LOVE cacheByIndexPath:indexPath configuration:^(YHSCookBookYourLoveTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 热门推荐
        case YHSCookBookTableSectionRecommed: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_RECOMMED cacheByIndexPath:indexPath configuration:^(YHSCookBookRecommedTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 到家商品
        case YHSCookBookTableSectionGoods: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_GOODS cacheByIndexPath:indexPath configuration:^(YHSCookBookGoodsTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 精品阅读
        case YHSCookBookTableSectionQualityRead: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_QUALITY_READ cacheByIndexPath:indexPath configuration:^(YHSCookBookQualityReadTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 热门活动
        case YHSCookBookTableSectionHotsActivity: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_HOTS_ACTIVITY cacheByIndexPath:indexPath configuration:^(YHSCookBookHotsActivityTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 好豆达人
        case YHSCookBookTableSectionHaoDouVIP: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_HAODOU_VIP cacheByIndexPath:indexPath configuration:^(YHSCookBookHaoDouVIPTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 分享美食
        case YHSCookBookTableSectionPublish: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_PUBLISH cacheByIndexPath:indexPath configuration:^(YHSCookBookPublishTableViewCell *cell) {
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
    
    // 是否有数据
    if (!self.tableData || self.tableData.count == 0) {
        return nil;
    }
    
    switch (section) {
        // 广告横幅
        case YHSCookBookTableSectionBanner:{
            return nil;
        }
        // 分类工具
        case YHSCookBookTableSectionTools:{
            return nil;
        }
        // 热门专辑
        case YHSCookBookTableSectionHotsAlbum: {
            YHSCookBookHotsAlbumModel *model = self.tableData[section][0];
            YHSCookBookTableSectionHeaderView *sectionHeaderView = [[YHSCookBookTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) title:@"热门专辑" imageIcon:model.icon tableSecion:YHSCookBookTableSectionHotsAlbum];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        // 猜你喜欢
        case YHSCookBookTableSectionYourLove: {
            YHSCookBookYourLoveModel *model = self.tableData[section][0];
            YHSCookBookTableSectionHeaderView *sectionHeaderView = [[YHSCookBookTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) title:@"猜你喜欢" imageIcon:model.icon tableSecion:YHSCookBookTableSectionYourLove];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        // 热门推荐
        case YHSCookBookTableSectionRecommed: {
            
            return nil;
        }
        // 到家商品
        case YHSCookBookTableSectionGoods: {
            
            return nil;
        }
        // 精品阅读
        case YHSCookBookTableSectionQualityRead: {
            YHSCookBookQualityReadModel *model = self.tableData[section][0];
            YHSCookBookTableSectionHeaderView *sectionHeaderView = [[YHSCookBookTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) title:@"精品阅读" imageIcon:model.icon tableSecion:YHSCookBookTableSectionQualityRead];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        // 热门活动
        case YHSCookBookTableSectionHotsActivity: {
            YHSCookBookHotsActivityModel *model = self.tableData[section][0];
            YHSCookBookTableSectionHeaderView *sectionHeaderView = [[YHSCookBookTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) title:@"热门活动" imageIcon:model.icon tableSecion:YHSCookBookTableSectionHotsActivity];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        // 好豆达人
        case YHSCookBookTableSectionHaoDouVIP: {
            YHSCookBookHaoDouVIPModel *model = self.tableData[section][0];
            YHSCookBookTableSectionHeaderView *sectionHeaderView = [[YHSCookBookTableSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) title:@"好豆达人" imageIcon:model.icon tableSecion:YHSCookBookTableSectionHaoDouVIP];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        // 分享美食
        case YHSCookBookTableSectionPublish: {
            
            return nil;
        }
        default: {
            return nil;
        }
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    switch (section) {
        case YHSCookBookTableSectionBanner:{ // 广告横幅
            return nil;
        }
        case YHSCookBookTableSectionTools: // 分类工具
        case YHSCookBookTableSectionHotsAlbum: // 热门专辑
        case YHSCookBookTableSectionYourLove: // 猜你喜欢
        case YHSCookBookTableSectionRecommed: // 热门推荐
        case YHSCookBookTableSectionGoods: // 到家商品
        case YHSCookBookTableSectionQualityRead: // 精品阅读
        case YHSCookBookTableSectionHotsActivity: { // 热门活动
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 10)];
            footerView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
            return footerView;
        }
        case YHSCookBookTableSectionHaoDouVIP: // 好豆达人
        case YHSCookBookTableSectionPublish: { // 分享美食
            return nil;
        }
        default: {
            return nil;
        }
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    // 是否有数据
    if (!self.tableData || self.tableData.count == 0) {
        return 0.0;
    }
    
    CGFloat height = 45.0;
    
    switch (section) {
        case YHSCookBookTableSectionBanner:{ // 广告横幅
            return 0.0;
        }
        case YHSCookBookTableSectionTools: { // 分类工具
            return 0.0;
        }
        case YHSCookBookTableSectionHotsAlbum: // 热门专辑
        case YHSCookBookTableSectionYourLove: { // 猜你喜欢
            return height;
        }
        case YHSCookBookTableSectionRecommed: // 热门推荐
        case YHSCookBookTableSectionGoods: { // 到家商品
            return 0.0;
        }
        case YHSCookBookTableSectionQualityRead: // 精品阅读
        case YHSCookBookTableSectionHotsActivity: // 热门活动
        case YHSCookBookTableSectionHaoDouVIP: { // 好豆达人
            return height;
        }
        case YHSCookBookTableSectionPublish: { // 分享美食
            return 0.0;
        }
        default: {
            return 0.0;
        }
    }
    
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    // 是否有数据
    if (!self.tableData || self.tableData.count == 0) {
        return 0.0;
    }
    
    switch (section) {
        case YHSCookBookTableSectionBanner:{ // 广告横幅
            return 0.0;
        }
        case YHSCookBookTableSectionTools: // 分类工具
        case YHSCookBookTableSectionHotsAlbum: // 热门专辑
        case YHSCookBookTableSectionYourLove: // 猜你喜欢
        case YHSCookBookTableSectionRecommed: // 热门推荐
        case YHSCookBookTableSectionGoods: // 到家商品
        case YHSCookBookTableSectionQualityRead: // 精品阅读
        case YHSCookBookTableSectionHotsActivity: { // 热门活动
            return 6.0;
        }
        case YHSCookBookTableSectionHaoDouVIP: {// 好豆达人
            return 0.0;
        }
        case YHSCookBookTableSectionPublish: { // 分享美食
            return 6.0;
        }
        default: {
            return 0.0;
        }
    }
    
    return 0.0;
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    YHSLogLight(@"%s", __FUNCTION__);
    
    NSString *text = @"网络连接异常";

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex:@"555555"]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    YHSLogLight(@"%s", __FUNCTION__);
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSString *text = @"请检查网络设置";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:11.75],
                                 NSForegroundColorAttributeName: [UIColor colorFromHex:@"555555"],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_networking_placeholder"];
}


- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    YHSLogLight(@"%s", __FUNCTION__);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}


- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}




#pragma mark - DZNEmptyDataSetDelegate Methods

//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

//是否允许点击，默认YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

//图片是否要动画效果，默认NO
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    return YES;
}

//空白页点击事件
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    
}

//空白页按钮点击事件
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    
}



@end







