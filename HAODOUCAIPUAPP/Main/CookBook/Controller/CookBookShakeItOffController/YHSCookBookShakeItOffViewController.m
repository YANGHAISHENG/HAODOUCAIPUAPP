//
//  YHSCookBookShakeItOffViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookShakeItOffViewController.h"
#import <AudioToolbox/AudioToolbox.h>

#import "YHSCookBookShakeItOffModel.h"
#import "YHSCookBookShakeItOffTableViewCell.h"
#import "YHSCookBookShakeItOffDetailViewController.h"

#import "YHSCookBookShakeItOffDetailDishVideoViewController.h"
#import "YHSCookBookShakeItOffDetailDishPictureViewController.h"


@interface YHSCookBookShakeItOffViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, YHSCookBookShakeItOffTableViewCellDelegate>

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

@end


@implementation YHSCookBookShakeItOffViewController


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
    
    // 配置TableView界面
    [weakSelf createUITable];
    
    // 刷新表格
    [weakSelf.tableView reloadData];
    
    
    // 设置允许摇一摇功能
    {
        // 支持摇动
        [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
        
        // 并让自己成为第一响应者
        [self becomeFirstResponder];
    }


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
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_NAVIGATION_STATUS + HEIGHT_NAVIGATION_BAR, SCREEN_WIDTH, SCREEN_HEIGHT - HEIGHT_NAVIGATION_STATUS - HEIGHT_NAVIGATION_BAR)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:view];
        
        view;
    });
    self.rootContainerView = rootContainerView;
    
    // 创建表格
    {
        // 创建表格
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
        self.tableView.estimatedRowHeight = 180; //预算行高
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
        
        // 必须被注册到 UITableView 中
        [self.tableView registerClass:[YHSCookBookShakeItOffTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SHAKE_IT_OFF];
    }
    
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
        
        // 直接返回
        return;
        
    } else {
        
        // 请求数据
        [self loadDataThen:^(BOOL success, NSUInteger count){

            // 加载成功
            if (success && count) {
                
                // 刷新表格
                [weakSelf.tableView reloadData];
                
                // 增加偏移量
                _offset += _limit;
                YHSLogBlue(@"加载后偏移量 ：%ld", _offset);
            }
            
        } andWritingLoading:YES];
        
    }
    
}

#pragma mark - 请求网络数据
- (void)loadDataThen:(void (^)(BOOL success, NSUInteger count))then andWritingLoading:(BOOL)showWritingLoading {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 手写Loading加载动画
    UIView *loadingContainerView = nil;
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
        NSString *url = [YHSCookBookDataUtil getCookBookShakeItOffRequestURLString];
        NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookShakeItOffRequestParams];
        [params setObject:@(self.limit) forKey:@"limit"];
        [params setObject:@(self.offset) forKey:@"offset"];
        
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
            
            // 分组处理数据
            NSMutableDictionary *sections = [NSMutableDictionary dictionary];
            [list enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                YHSCookBookShakeItOffModel *model = [YHSCookBookShakeItOffModel mj_objectWithKeyValues:dict];
                // 分组数据
                NSMutableArray<YHSCookBookShakeItOffModel *> *cateModelList = sections[model.CateName];
                if (!cateModelList) {
                    cateModelList = [NSMutableArray<YHSCookBookShakeItOffModel *> array];
                }
                // 分组数据列表
                [cateModelList addObject:model];
                // 分组标题
                [sections setValue:cateModelList forKey:model.CateName];
            }];
            
            // 数据模型转换
            NSMutableArray<NSString *> *titles = [NSMutableArray array];
            NSMutableArray<NSMutableArray *> *models = [NSMutableArray array];
            [sections enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSMutableArray<YHSCookBookShakeItOffModel *> *obj, BOOL * _Nonnull stop) {
                [models addObject:obj];
                [titles addObject:key];
            }];

            // 设置数据源
            if (list.count > 0) {
                if (0 == _offset) {
                    weakSelf.tableData = models.mutableCopy; // 刷新数据
                    weakSelf.sectionTitle = titles.mutableCopy;
                } else {
                    [weakSelf.tableData addObjectsFromArray:models.mutableCopy]; // 加载更多数据
                    [weakSelf.sectionTitle addObjectsFromArray:titles.mutableCopy];
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

- (NSMutableArray *)tableData
{
    if (!_tableData) {
        _tableData = [NSMutableArray array];
    }
    return _tableData;
}

- (NSMutableArray *)sectionTitle
{
    if (!_sectionTitle) {
        _sectionTitle = [NSMutableArray array];
    }
    return _sectionTitle;
}


#pragma mark - TableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableData.count > 0 && self.tableData.count > section) {
        
        NSMutableArray *group = self.tableData[section];
        
        return group.count;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHSCookBookShakeItOffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SHAKE_IT_OFF];
    if (!cell) {
        cell = [[YHSCookBookShakeItOffTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SHAKE_IT_OFF];
    }
    cell.delegate = self;
    cell.model = self.tableData[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SHAKE_IT_OFF cacheByIndexPath:indexPath configuration:^(YHSCookBookShakeItOffTableViewCell *cell) {
        // 配置 cell 的数据源，和 "cellForRow" 干的事一致
        cell.model = self.tableData[indexPath.section][indexPath.row];
    }];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat height = 30.0;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    NSString *titleText = self.sectionTitle[section];
    NSDictionary *titleDict = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName:[UIColor blackColor]};
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:titleText attributes:titleDict];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.tableView.frame.size.width, height)];
    [titleLable setText:[NSString stringWithFormat:@"%@", self.sectionTitle[section]]];
    [titleLable setTextColor:[UIColor blackColor]];
    [titleLable setAttributedText:attributedTitle];
    [titleLable setTextAlignment:NSTextAlignmentLeft];
    [titleLable setBackgroundColor:[UIColor whiteColor]];
    [headerView addSubview:titleLable];
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 10.0)];
    [footerView setBackgroundColor:[UIColor whiteColor]];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 25.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10.0;
}

#pragma mark - 触发点击Cell事件
- (void)didClickElementOfCellWithCookBookShakeItOffModel:(YHSCookBookShakeItOffModel *)model
{

    // 菜谱详情界面
    if (model.HasVideo) {
        // 视屏菜谱
        YHSCookBookShakeItOffDetailDishVideoViewController *dishVedioViewController = [YHSCookBookShakeItOffDetailDishVideoViewController new];
        [dishVedioViewController setRid:[NSString stringWithFormat:@"%ld", model.RecipeId]];
        [dishVedioViewController setReturn_request_id:@""];
        [dishVedioViewController setTitle:@" "];
        [self.navigationController pushViewController:dishVedioViewController animated:YES];
    } else {
        // 图片菜谱
        YHSCookBookShakeItOffDetailDishPictureViewController *dishVedioViewController = [YHSCookBookShakeItOffDetailDishPictureViewController new];
        [dishVedioViewController setRid:[NSString stringWithFormat:@"%ld", model.RecipeId]];
        [dishVedioViewController setReturn_request_id:@""];
        [dishVedioViewController setTitle:@" "];
        [self.navigationController pushViewController:dishVedioViewController animated:YES];
    }
    
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    YHSLogLight(@"%s", __FUNCTION__);
    
    NSString *text = @"不知道吃什么 ？";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0],
                                 NSForegroundColorAttributeName:[UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    YHSLogLight(@"%s", __FUNCTION__);
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSString *text = @"摇一摇";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:50.0],
                                 NSForegroundColorAttributeName:[UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"empty_shake_it_off"];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -80.0;
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

//是否允许滚动，默认NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

//图片是否要动画效果，默认NO
- (BOOL) emptyDataSetShouldAllowImageViewAnimate:(UIScrollView *)scrollView {
    return YES;
}


#pragma mark - 摇一摇相关方法

- (BOOL)canBecomeFirstResponder {
    return YES;
}

// 摇一摇开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    YHSLogOrange(@"开始摇动");
    
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    {
        YHSCookBookShakeItOffDetailViewController *detailViewController = [YHSCookBookShakeItOffDetailViewController new];
        [detailViewController setTitle:@"摇一摇"];
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }
    
    return;
}

#pragma mark 摇动取消
- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    YHSLogOrange("摇动取消");
    [self stopAlertSoundWithSoundID:kSystemSoundID_Vibrate];
}

// 摇一摇摇动结束
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (event.subtype == UIEventSubtypeMotionShake) { // 判断是否是摇动结束
        YHSLogOrange(@"摇动结束");
    }
    [self stopAlertSoundWithSoundID:kSystemSoundID_Vibrate];
    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
    
    return;
}

// 振动后回调函数，实现持续振动
void soundCompleteCallback(SystemSoundID sound, void * clientData) {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);  // 震动
}

// 结束持续振动
- (void)stopAlertSoundWithSoundID:(SystemSoundID)sound {
    AudioServicesDisposeSystemSoundID(sound);
    AudioServicesRemoveSystemSoundCompletion(sound);
}


@end



