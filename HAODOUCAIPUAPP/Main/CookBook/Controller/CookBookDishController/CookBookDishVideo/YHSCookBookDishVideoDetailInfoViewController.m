

#import "YHSCookBookDishVideoDetailInfoViewController.h"
#import "YHSCookBookDishDetailTableSectionHeaderFooterView.h"
#import "YHSCookBookDishModel.h"
#import "YHSCookBookDishFoodMaterialModel.h"
#import "YHSCookBookDishDetailHeadTableViewCell.h"
#import "YHSCookBookDishDetailFoodMaterialTableViewCell.h"
#import "YHSCookBookDishDetailTipsTableViewCell.h"
#import "YHSCookBookDishDetailProductTableViewCell.h"
#import "YHSCookBookDishDetailRelatedTagTableViewCell.h"

#import "YHSCategorySearchResultViewController.h"


@interface YHSCookBookDishVideoDetailInfoViewController () <UITableViewDelegate, UITableViewDataSource, YHSCookBookDishDetailTableSectionHeaderFooterViewDelegate, YHSCookBookDishDetailHeadTableViewCellDelegate, YHSCookBookDishDetailFoodMaterialTableViewCellDelegate, YHSCookBookDishDetailProductTableViewCellDelegate, YHSCookBookDishDetailRelatedTagTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation YHSCookBookDishVideoDetailInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    WEAKSELF(weakSelf);
    
    // 请求网络数据
    [self loadDataThen:^(BOOL success) {
        
        // 配置TableView界面
        [weakSelf createUITable];

    }];
    
}


#pragma mark - 创建UI界面

// 创建步骤表格
- (void)createUITable
{    
    WEAKSELF(weakSelf);
    
    if (self.tableView) {
        return;
    }
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
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
            make.top.equalTo(weakSelf.view.mas_top).with.offset(0.0);
            make.left.equalTo(weakSelf.view.mas_left).with.offset(0.0);
            make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0.0);
            make.right.equalTo(weakSelf.view.mas_right).with.offset(0.0);
        }];
        
        // 自动算高 UITableView+FDTemplateLayoutCell
        self.tableView.estimatedRowHeight = 180; //预算行高
        self.tableView.fd_debugLogEnabled = YES; //开启log打印高度
        
        // 设置表格背景
        UIView *backView = [[UIView alloc] init];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setBackgroundView:backView];
        
        // 表头表尾
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        
        // 必须被注册到 UITableView 中
        [self.tableView registerClass:[YHSCookBookDishDetailHeadTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_HEADER];
        [self.tableView registerClass:[YHSCookBookDishDetailFoodMaterialTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_FOOD_MATERIAL];
        [self.tableView registerClass:[YHSCookBookDishDetailTipsTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_TIPS];
        [self.tableView registerClass:[YHSCookBookDishDetailProductTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_PRODUCT];
        [self.tableView registerClass:[YHSCookBookDishDetailRelatedTagTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_RELATED_TAG];
    }
    
}

#pragma mark - 请求网络数据
- (void)loadDataThen:(void (^)(BOOL success))then {

    // 1.头部信息
    [self.tableData addObject:@[self.infoModel].mutableCopy];
    
    // 2.食材信息
    NSMutableArray *foodMaterials = [NSMutableArray array];
    [self.infoModel.MainStuff enumerateObjectsUsingBlock:^(YHSCookBookDishMainStuffModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    [self.infoModel.OtherStuff enumerateObjectsUsingBlock:^(YHSCookBookDishOtherStuffModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    
    // 3.注意提示
    [self.tableData addObject:@[self.infoModel.Tips]];
    
    // 4.作品展示
    [self.tableData addObject:@[self.infoModel]];
    
    // 5.相关标签
    [self.tableData addObject:@[self.infoModel]];
    
    // 刷新界面
    !then ?: then(YES);
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
        // 详情头部
        case YHSCookBookDishVideoDetailInfoTableSectionHead:{
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
        case YHSCookBookDishVideoDetailInfoTableSectionFoodMaterial:{
            YHSCookBookDishDetailFoodMaterialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_FOOD_MATERIAL];
            if (!cell) {
                cell = [[YHSCookBookDishDetailFoodMaterialTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_FOOD_MATERIAL];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 注意提示
        case YHSCookBookDishVideoDetailInfoTableSectionTips:{
            YHSCookBookDishDetailTipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_TIPS];
            if (!cell) {
                cell = [[YHSCookBookDishDetailTipsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_TIPS];
            }
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        // 作品展示
        case YHSCookBookDishVideoDetailInfoTableSectionPhotoShow:{
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
        case YHSCookBookDishVideoDetailInfoTableSectionRelatedTag:{
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
        // 详情头部
        case YHSCookBookDishVideoDetailInfoTableSectionHead:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_HEADER cacheByIndexPath:indexPath configuration:^(YHSCookBookDishDetailHeadTableViewCell *cell) {
                [cell setModel:self.tableData[indexPath.section][indexPath.row] indexPath:indexPath];
            }];
        }
        // 食材详情
        case YHSCookBookDishVideoDetailInfoTableSectionFoodMaterial:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_FOOD_MATERIAL cacheByIndexPath:indexPath configuration:^(YHSCookBookDishDetailFoodMaterialTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 注意提示
        case YHSCookBookDishVideoDetailInfoTableSectionTips:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_TIPS cacheByIndexPath:indexPath configuration:^(YHSCookBookDishDetailTipsTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 作品展示
        case YHSCookBookDishVideoDetailInfoTableSectionPhotoShow:{
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_PRODUCT cacheByIndexPath:indexPath configuration:^(YHSCookBookDishDetailProductTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        // 相关标签
        case YHSCookBookDishVideoDetailInfoTableSectionRelatedTag:{
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
        // 详情头部
        case YHSCookBookDishVideoDetailInfoTableSectionHead:{
            return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        }
        // 食材详情
        case YHSCookBookDishVideoDetailInfoTableSectionFoodMaterial:{
            YHSCookBookDishDetailTableSectionHeaderFooterView *sectionHeaderView = [[YHSCookBookDishDetailTableSectionHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) content:@"食材" color:color font:font tableSecion:YHSCookBookDishVideoDetailInfoTableSectionFoodMaterial tagHeight:height];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        // 注意提示
        case YHSCookBookDishVideoDetailInfoTableSectionTips: {
            YHSCookBookDishDetailTableSectionHeaderFooterView *sectionHeaderView = [[YHSCookBookDishDetailTableSectionHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) content:@"小贴士" color:color font:font tableSecion:YHSCookBookDishVideoDetailInfoTableSectionTips tagHeight:height];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        // 作品展示
        case YHSCookBookDishVideoDetailInfoTableSectionPhotoShow:{
            YHSCookBookDishDetailTableSectionHeaderFooterView *sectionHeaderView = [[YHSCookBookDishDetailTableSectionHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) content:@"作品展示" color:color font:font tableSecion:YHSCookBookDishVideoDetailInfoTableSectionPhotoShow tagHeight:height];
            sectionHeaderView.delegate = self;
            return sectionHeaderView;
        }
        // 相关标签
        case YHSCookBookDishVideoDetailInfoTableSectionRelatedTag:{
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
    
    CGFloat height = 40.0;
    UIFont *font = [UIFont systemFontOfSize:16.0];
    UIColor *color = [UIColor blackColor];
    
    switch (section) {
        // 详情头部
        case YHSCookBookDishVideoDetailInfoTableSectionHead:{
            return nil;
        }
        // 食材详情
        case YHSCookBookDishVideoDetailInfoTableSectionFoodMaterial:{
            YHSCookBookDishDetailTableSectionHeaderFooterView *sectionHeaderView = [[YHSCookBookDishDetailTableSectionHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, height) content:[NSString stringWithFormat:@"制作日间：%@", self.infoModel.CookTime] color:color font:font tableSecion:-1 tagHeight:height];
            return sectionHeaderView;
        }
        // 注意提示
        case YHSCookBookDishVideoDetailInfoTableSectionTips: {
            return nil;
        }
        // 作品展示
        case YHSCookBookDishVideoDetailInfoTableSectionPhotoShow:{
            return nil;
        }
        // 相关标签
        case YHSCookBookDishVideoDetailInfoTableSectionRelatedTag:{
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
        // 详情头部
        case YHSCookBookDishVideoDetailInfoTableSectionHead:{
            return 0.0;
        }
        case YHSCookBookDishVideoDetailInfoTableSectionFoodMaterial: // 食材详情
        case YHSCookBookDishVideoDetailInfoTableSectionTips: // 注意提示
        case YHSCookBookDishVideoDetailInfoTableSectionPhotoShow: { // 作品展示
           return height;
        }
        // 相关标签
        case YHSCookBookDishVideoDetailInfoTableSectionRelatedTag:{
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
        // 详情头部
        case YHSCookBookDishVideoDetailInfoTableSectionHead: {
            return 0.0;
        }
        case YHSCookBookDishVideoDetailInfoTableSectionFoodMaterial: { // 食材详情
            return height;
        }
        case YHSCookBookDishVideoDetailInfoTableSectionTips: // 注意提示
        case YHSCookBookDishVideoDetailInfoTableSectionPhotoShow: // 作品展示
        case YHSCookBookDishVideoDetailInfoTableSectionRelatedTag:{ // 相关标签
            return 0.0;
        }
        default: {
            return 0.0;
        }
    }
    
    return 0.0;
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
