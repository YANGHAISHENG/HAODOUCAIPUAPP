//
//  YHSCookBookDishPictureViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//


#import "YHSCookBookDishPictureViewController.h"
#import "YHSCookBookDishModel.h"
#import "YHSCookBookDishFoodMaterialModel.h"
#import "YHSCookBookDishVideoDetailInfoViewController.h"

#import "YHSCookBookDishDetailTableSectionHeaderFooterView.h"
#import "YHSCookBookDishPictureDetailCoverPhotoTableViewCell.h"
#import "YHSCookBookDishDetailHeadTableViewCell.h"
#import "YHSCookBookDishDetailFoodMaterialTableViewCell.h"
#import "YHSCookBookDishPictureDetailStepTableViewCell.h"
#import "YHSCookBookDishDetailTipsTableViewCell.h"
#import "YHSCookBookDishDetailProductTableViewCell.h"
#import "YHSCookBookDishDetailRelatedTagTableViewCell.h"

#import "YHSCategorySearchResultViewController.h"

@interface YHSCookBookDishPictureViewController () <UITableViewDelegate, UITableViewDataSource, YHSCookBookDishPictureDetailCoverPhotoTableViewCellDelegate, YHSCookBookDishDetailTableSectionHeaderFooterViewDelegate, YHSCookBookDishDetailHeadTableViewCellDelegate, YHSCookBookDishDetailFoodMaterialTableViewCellDelegate, YHSCookBookDishPictureDetailStepTableViewCellDelegate, YHSCookBookDishDetailProductTableViewCellDelegate, YHSCookBookDishDetailRelatedTagTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tableData;

@property (nonatomic, strong) YHSCookBookDishModel *infoModel;

@end

@implementation YHSCookBookDishPictureViewController


// 监听网络变化后执行
- (void)viewDidLoadWithNetworkingStatus
{
    WEAKSELF(weakSelf);
    
    // 请求网络数据（如果没有请求过数据，则进行数据加载）
    [self loadDataThen:^(BOOL success, NSUInteger count){
        
        // 创建界面
        [weakSelf createUITable];
        
        // 加载成功
        if (success && count) {
            
            // 刷新表格
            [weakSelf.tableView reloadData];

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
            make.top.equalTo(weakSelf.mas_topLayoutGuide).with.offset(0.0);
            make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
            make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
            make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
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
        
        // 必须被注册到 UITableView 中
        [self.tableView registerClass:[YHSCookBookDishPictureDetailCoverPhotoTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_COVER_PHOTO];
        [self.tableView registerClass:[YHSCookBookDishDetailHeadTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_HEADER];
        [self.tableView registerClass:[YHSCookBookDishDetailFoodMaterialTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_FOOD_MATERIAL];
        [self.tableView registerClass:[YHSCookBookDishPictureDetailStepTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_STEP];
        [self.tableView registerClass:[YHSCookBookDishDetailTipsTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_TIPS];
        [self.tableView registerClass:[YHSCookBookDishDetailProductTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_PRODUCT];
        [self.tableView registerClass:[YHSCookBookDishDetailRelatedTagTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_RELATED_TAG];
        
    }
    
}


#pragma mark - 请求网络数据
- (void)loadDataThen:(void (^)(BOOL success, NSUInteger count))then andWritingLoading:(BOOL)showWritingLoading {
    
    WEAKSELF(weakSelf);
    
    // 手写Loading加载动画
    UIView *loadingContainerView = nil;
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
        NSString *url = [self getCookBookDishVedioRequestURLString];
        NSMutableDictionary *params = [self getCookBookDishVedioRequestParams];
        
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
            NSDictionary *info = data[@"info"];
            
            // 数据转换
            YHSCookBookDishModel *infoModel = [YHSCookBookDishModel mj_objectWithKeyValues:info];
            weakSelf.infoModel = infoModel;
            
            // 配置数据源
            {
                // 0.头部信息
                [self.tableData addObject:@[infoModel]];
                
                // 1.头部信息
                [self.tableData addObject:@[infoModel]];
                
                // 2.食材信息
                NSMutableArray *foodMaterials = [NSMutableArray array];
                [infoModel.MainStuff enumerateObjectsUsingBlock:^(YHSCookBookDishMainStuffModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    YHSCookBookDishFoodMaterialModel *foodMaterial = [YHSCookBookDishFoodMaterialModel new];
                    foodMaterial.isMainMaterial = YES;
                    foodMaterial.weight = obj.weight;
                    foodMaterial.cateid = obj.cateid;
                    foodMaterial.food_flag = obj.food_flag;
                    foodMaterial.ID = obj.ID;
                    foodMaterial.type = obj.type;
                    foodMaterial.cate = obj.cate;
                    foodMaterial.name = obj.name;
                    [foodMaterials addObject:foodMaterial];
                }];
                [infoModel.OtherStuff enumerateObjectsUsingBlock:^(YHSCookBookDishOtherStuffModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    YHSCookBookDishFoodMaterialModel *foodMaterial = [YHSCookBookDishFoodMaterialModel new];
                    foodMaterial.isMainMaterial = NO;
                    foodMaterial.weight = obj.weight;
                    foodMaterial.cateid = obj.cateid;
                    foodMaterial.food_flag = obj.food_flag;
                    foodMaterial.ID = obj.ID;
                    foodMaterial.type = obj.type;
                    foodMaterial.cate = obj.cate;
                    foodMaterial.name = obj.name;
                    [foodMaterials addObject:foodMaterial];
                }];
                [self.tableData addObject:foodMaterials];
                
                // 4.制作步骤
                NSMutableArray *stepModels = [NSMutableArray array];
                [infoModel.Steps enumerateObjectsUsingBlock:^(YHSCookBookDishStepsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    obj.num = [NSString stringWithFormat:@"%ld", idx+1];
                    [stepModels addObject:obj];
                }];
                [self.tableData addObject:stepModels];
                
                // 4.注意提示
                [self.tableData addObject:@[infoModel.Tips]];
                
                // 5.作品展示
                [self.tableData addObject:@[infoModel]];
                
                // 6.相关标签
                [self.tableData addObject:@[infoModel]];
            }
            
            // 请求数据成功
            isSuccess = YES;
            
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


- (NSString *)getCookBookDishVedioRequestURLString
{
    // 默认主页面内容，子类必须继承
    return [YHSCookBookDataUtil getCookBookDishPictureRequestURLString];
}

- (NSMutableDictionary *)getCookBookDishVedioRequestParams
{
    // 默认主页面内容，子类必须继承
    NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookDishPictureRequestParams];
    [params setObject:self.rid forKey:@"rid"];  // 必须有
    return params;
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
    return self.tableData.count;
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
    switch (indexPath.section) {
            // 头部图片
        case YHSCookBookDishPictureDetailInfoTableSectionCoverPhoto:{
            YHSCookBookDishPictureDetailCoverPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_COVER_PHOTO];
            if (!cell) {
                cell = [[YHSCookBookDishPictureDetailCoverPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_COVER_PHOTO];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 详情头部
        case YHSCookBookDishPictureDetailInfoTableSectionHead:{
            YHSCookBookDishDetailHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_HEADER];
            if (!cell) {
                cell = [[YHSCookBookDishDetailHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_HEADER];
            }
            cell.delegate = self;
            [cell setModel:self.tableData[indexPath.section][indexPath.row] indexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 食材详情
        case YHSCookBookDishPictureDetailInfoTableSectionFoodMaterial:{
            YHSCookBookDishDetailFoodMaterialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_FOOD_MATERIAL];
            if (!cell) {
                cell = [[YHSCookBookDishDetailFoodMaterialTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_FOOD_MATERIAL];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 制作步骤
        case YHSCookBookDishPictureDetailInfoTableSectionStep:{
            YHSCookBookDishPictureDetailStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_STEP];
            if (!cell) {
                cell = [[YHSCookBookDishPictureDetailStepTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_STEP];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 注意提示
        case YHSCookBookDishPictureDetailInfoTableSectionTips:{
            YHSCookBookDishDetailTipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_TIPS];
            if (!cell) {
                cell = [[YHSCookBookDishDetailTipsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_TIPS];
            }
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 作品展示
        case YHSCookBookDishPictureDetailInfoTableSectionPhotoShow:{
            YHSCookBookDishDetailProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_PRODUCT];
            if (!cell) {
                cell = [[YHSCookBookDishDetailProductTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_PRODUCT];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
            // 相关标签
        case YHSCookBookDishPictureDetailInfoTableSectionRelatedTag:{
            YHSCookBookDishDetailRelatedTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_RELATED_TAG];
            if (!cell) {
                cell = [[YHSCookBookDishDetailRelatedTagTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_RELATED_TAG];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        default: {
            return  nil;
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
            // 头部图片
        case YHSCookBookDishPictureDetailInfoTableSectionCoverPhoto:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_COVER_PHOTO cacheByIndexPath:indexPath configuration:^(YHSCookBookDishPictureDetailCoverPhotoTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
            // 详情头部
        case YHSCookBookDishPictureDetailInfoTableSectionHead:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_HEADER cacheByIndexPath:indexPath configuration:^(YHSCookBookDishDetailHeadTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                [cell setModel:self.tableData[indexPath.section][indexPath.row] indexPath:indexPath];
            }];
        }
            // 食材详情
        case YHSCookBookDishPictureDetailInfoTableSectionFoodMaterial:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_FOOD_MATERIAL cacheByIndexPath:indexPath configuration:^(YHSCookBookDishDetailFoodMaterialTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
            // 制作步骤
        case YHSCookBookDishPictureDetailInfoTableSectionStep:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_STEP cacheByIndexPath:indexPath configuration:^(YHSCookBookDishPictureDetailStepTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
            // 注意提示
        case YHSCookBookDishPictureDetailInfoTableSectionTips:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_TIPS cacheByIndexPath:indexPath configuration:^(YHSCookBookDishDetailTipsTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
            // 作品展示
        case YHSCookBookDishPictureDetailInfoTableSectionPhotoShow:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_PRODUCT cacheByIndexPath:indexPath configuration:^(YHSCookBookDishDetailProductTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
            // 相关标签
        case YHSCookBookDishPictureDetailInfoTableSectionRelatedTag:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_RELATED_TAG cacheByIndexPath:indexPath configuration:^(YHSCookBookDishDetailRelatedTagTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        default: {
            return  0.0;
        }
    }
    return 0.0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGFloat height = 40.0;
    UIFont *font = [UIFont boldSystemFontOfSize:20.0];
    UIColor *color = [UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00];
    
    switch (section) {
            // 头部图片
        case YHSCookBookDishPictureDetailInfoTableSectionCoverPhoto:{
            return nil;
        }
            // 详情头部
        case YHSCookBookDishPictureDetailInfoTableSectionHead:{
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1.0)];
            return header;
        }
            // 食材详情
        case YHSCookBookDishPictureDetailInfoTableSectionFoodMaterial:{
            YHSCookBookDishDetailTableSectionHeaderFooterView *sectionHeaderView = [[YHSCookBookDishDetailTableSectionHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) content:@"食材" color:color font:font tableSecion:YHSCookBookDishPictureDetailInfoTableSectionFoodMaterial tagHeight:height];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
            // 制作步骤
        case YHSCookBookDishPictureDetailInfoTableSectionStep:{
            YHSCookBookDishDetailTableSectionHeaderFooterView *sectionHeaderView = [[YHSCookBookDishDetailTableSectionHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) content:@"步骤" color:color font:font tableSecion:YHSCookBookDishPictureDetailInfoTableSectionFoodMaterial tagHeight:height];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
            // 注意提示
        case YHSCookBookDishPictureDetailInfoTableSectionTips: {
            YHSCookBookDishDetailTableSectionHeaderFooterView *sectionHeaderView = [[YHSCookBookDishDetailTableSectionHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) content:@"小贴士" color:color font:font tableSecion:YHSCookBookDishVideoDetailInfoTableSectionTips tagHeight:height];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
            // 作品展示
        case YHSCookBookDishPictureDetailInfoTableSectionPhotoShow:{
            YHSCookBookDishDetailTableSectionHeaderFooterView *sectionHeaderView = [[YHSCookBookDishDetailTableSectionHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) content:@"作品展示" color:color font:font tableSecion:YHSCookBookDishVideoDetailInfoTableSectionPhotoShow tagHeight:height];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
            // 相关标签
        case YHSCookBookDishPictureDetailInfoTableSectionRelatedTag:{
            YHSCookBookDishDetailTableSectionHeaderFooterView *sectionHeaderView = [[YHSCookBookDishDetailTableSectionHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) content:@"相关标签" color:color font:font tableSecion:YHSCookBookDishVideoDetailInfoTableSectionRelatedTag tagHeight:height];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        default: {
            return nil;
        }
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    switch (section) {
            // 头部图片
        case YHSCookBookDishPictureDetailInfoTableSectionCoverPhoto:{
            return nil;
        }
            // 详情头部
        case YHSCookBookDishPictureDetailInfoTableSectionHead:{
            return nil;
        }
            // 食材详情
        case YHSCookBookDishPictureDetailInfoTableSectionFoodMaterial:{
            YHSCookBookDishDetailTableSectionHeaderFooterView *sectionHeaderView = [[YHSCookBookDishDetailTableSectionHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 40.0) content:[NSString stringWithFormat:@"制作日间：%@", self.infoModel.CookTime] color:[UIColor blackColor] font:[UIFont systemFontOfSize:16.0] tableSecion:-1 tagHeight:40.0];
            return sectionHeaderView;
        }
            // 制作步骤
        case YHSCookBookDishPictureDetailInfoTableSectionStep:{
            return nil;
        }
            // 注意提示
        case YHSCookBookDishPictureDetailInfoTableSectionTips: {
            return nil;
        }
            // 作品展示
        case YHSCookBookDishPictureDetailInfoTableSectionPhotoShow:{
            return nil;
        }
            // 相关标签
        case YHSCookBookDishPictureDetailInfoTableSectionRelatedTag:{
            return nil;
        }
        default: {
            return nil;
        }
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    CGFloat height = 40.0;
    
    switch (section) {
            // 头部图片
        case YHSCookBookDishPictureDetailInfoTableSectionCoverPhoto:{
            return 0.0;
        }
            // 详情头部
        case YHSCookBookDishPictureDetailInfoTableSectionHead:{
            return 1.0;
        }
        case YHSCookBookDishPictureDetailInfoTableSectionFoodMaterial: // 食材详情
        case YHSCookBookDishPictureDetailInfoTableSectionStep: // 制作步骤
        case YHSCookBookDishPictureDetailInfoTableSectionTips: // 注意提示
        case YHSCookBookDishPictureDetailInfoTableSectionPhotoShow: { // 作品展示
            return height;
        }
            // 相关标签
        case YHSCookBookDishPictureDetailInfoTableSectionRelatedTag:{
            return height;
        }
        default: {
            return 0.0;
        }
    }
    
    return 0.0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    CGFloat height = 40.0;
    
    switch (section) {
            // 头部图片
        case YHSCookBookDishPictureDetailInfoTableSectionCoverPhoto:{
            return 0.0;
        }
            // 详情头部
        case YHSCookBookDishPictureDetailInfoTableSectionHead: {
            return 0.0;
        }
        case YHSCookBookDishPictureDetailInfoTableSectionFoodMaterial: { // 食材详情
            return height;
        }
        case YHSCookBookDishPictureDetailInfoTableSectionStep: // 制作步骤
        case YHSCookBookDishPictureDetailInfoTableSectionTips: // 注意提示
        case YHSCookBookDishPictureDetailInfoTableSectionPhotoShow: // 作品展示
        case YHSCookBookDishPictureDetailInfoTableSectionRelatedTag:{ // 相关标签
            return 0.0;
        }
        default: {
            return 0.0;
        }
    }
    
    return 0.0;
}


#pragma mark - UITableView 处理 section 的不悬浮，禁止section停留的方法，主要是这段代码

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}


#pragma mark - 触发点击食材采购清单事件

- (void)didClickTableSectionHeader:(NSInteger )tabSection
{
    [self alertPromptMessage:@"采购清单"];
}

#pragma mark - 触发点击详情头部事件
// 点击用户信息
- (void)didClickElementOfCellWithCookBookDishModel:(YHSCookBookDishModel *)model
{
    [self alertPromptMessage:@"用户详情页面"];
}

// 点击关注按钮
- (void)pressRelationImageViewArea:(YHSCookBookDishModel *)model
{
    [self alertPromptMessage:@"关注"];
}

// 点击显示菜谱介绍文字
- (void)didFoodIntroLabelWithCookBookDishModel:(YHSCookBookDishModel *)model expandedAllWithIndexPath:(NSIndexPath *)indexPath
{
    YHSCookBookDishModel *dishModel = self.tableData[indexPath.section][indexPath.row];
    dishModel.isExpandedAllIntro = !dishModel.isExpandedAllIntro; // 切换展开还是收回
    
    // 先重新计算高度，然后reload，不是原来的cell实例
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - 触发点击食材详情事件
- (void)didClickElementOfCellWithCookBookDishDetailFoodMaterialModel:(YHSCookBookDishFoodMaterialModel *)model
{
    [self alertPromptMessage:@"食材详情页面"];
}


#pragma mark - 触发点击作品展示事件
- (void)didClickElementOfCellWithDishDetailProductModel:(YHSCookBookDishProductModel *)model
{
    [self alertPromptMessage:@"作品详情页面"];
}

- (void)didClickElementOfCellWithAllProductModel:(YHSCookBookDishModel *)model
{
    [self alertPromptMessage:@"查看全部作品"];
}

- (void)didClickElementOfCellWithDishDetailTagsModel:(YHSCookBookDishTagsModel *)model
{
    
    YHSCategorySearchResultViewController *searchResultController = [YHSCategorySearchResultViewController new];
    [searchResultController setTagId:[NSString stringWithFormat:@"%ld", model.Id]];
    [searchResultController setTagName:model.Name];
    [searchResultController setTitle:model.Name];
    [searchResultController setScene:@"t1"];
    [searchResultController setUuid:@"72b9cf70da593de0478cbb90f6025bf7"];
    [self.navigationController pushViewController:searchResultController animated:YES];
    
}


#pragma mark - 提示信息
- (void)alertPromptMessage:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@功能模块正在开发中，请使用其它功能！", message] preferredStyle:UIAlertControllerStyleAlert];
    
    // 取消
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancleAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}









@end
