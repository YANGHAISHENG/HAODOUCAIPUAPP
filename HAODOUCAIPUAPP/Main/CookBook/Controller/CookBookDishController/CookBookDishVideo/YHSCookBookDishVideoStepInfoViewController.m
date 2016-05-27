

#import "YHSCookBookDishVideoStepInfoViewController.h"
#import "YHSCookBookDishModel.h"

#import "YHSCookBookDishVideoStepTableViewCell.h"
#import "YHSCookBookVideoModel.h"


@interface YHSCookBookDishVideoStepInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger currentSelectedRowIndex; // 当前自动跳转到的行下标

@end


@implementation YHSCookBookDishVideoStepInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    WEAKSELF(weakSelf);
    
    // 请求网络数据
    [self loadDataThen:^(BOOL success, NSUInteger count) {
        
        // 配置TableView界面
        [weakSelf createMainUI];
        
        // 设置视屏地址（步骤表格可以已经存在，但用户没有点击播放按钮，视屏显示控件可能为空）
        if (self.videoZFPlayerView) {
            self.videoZFPlayerView.videoURL = [NSURL URLWithString:self.videoStepModel.Url];
        }

    } andWritingLoading:YES];
    
}

#pragma mark - 创建UI界面

// 创建主界面区域
- (void)createMainUI
{
    // 数据模型，自定义加上步骤序号
    [self.videoStepModel.Steps enumerateObjectsUsingBlock:^(YHSCookBookVideoStepModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.num = [NSString stringWithFormat:@"%ld", 1+idx];
        obj.selected = NO;
    }];
    
    // 创建步骤表格
    [self createUITable];
}

// 创建步骤表格
- (void)createUITable
{
    // 表格已经存在或无数据源则无需创建，直接返回
    if (self.tableView) {
        return;
    }
    
    WEAKSELF(weakSelf);
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    // 创建表格
    {
        // 创建表格
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = YES;
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 添加约束
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view.mas_top).with.offset(0.0);
            make.left.equalTo(weakSelf.view.mas_left).with.offset(0);
            make.bottom.equalTo(weakSelf.view.mas_bottom).with.offset(0);
            make.right.equalTo(weakSelf.view.mas_right).with.offset(0);
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
        [self.tableView registerClass:[YHSCookBookDishVideoStepTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_DISH_VIDEO_STEP_INFO];
        
        // 默认选中行
        self.currentSelectedRowIndex = -1;
    }
    
}


#pragma mark - 请求网络数据
- (void)loadDataThen:(void (^)(BOOL success, NSUInteger count))then andWritingLoading:(BOOL)showWritingLoading {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 在默认优先级的 Global Dispatch Queue 中执行块(Block)，并行处理
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 请求数据是否成功
        __block BOOL isSuccess = NO;
        __block NSUInteger listCount = 0; // 请求到的数据数量
        
        // 请求地址与参数
        NSString *url = [YHSCookBookDataUtil getCookBookDishVideoMP4RequestURLString];
        NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookDishVideoMP4RequestParams];
        [params setObject:[NSString stringWithFormat:@"%ld", _infoModel.RecipeId] forKey:@"rid"];
        
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
            
            // 数据转换
            YHSCookBookVideoModel *videoStepModel = [YHSCookBookVideoModel mj_objectWithKeyValues:data];
            weakSelf.videoStepModel = videoStepModel;
            
            // 请求数据成功
            isSuccess = YES;
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 刷新界面
                !then ?: then(isSuccess, listCount);
                
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            YHSLogRed(@"请求数据异常：%@", error);
            
            // 请求数据失败
            isSuccess = NO;
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 刷新界面
                !then ?: then(isSuccess, listCount);
                
            });
            
        }];
        
    }); // dispatch_async
    
}


#pragma mark - TableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoStepModel.Steps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHSCookBookDishVideoStepTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_DISH_VIDEO_STEP_INFO];
    if (!cell) {
        cell = [[YHSCookBookDishVideoStepTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_DISH_VIDEO_STEP_INFO];
    }
    cell.model = self.videoStepModel.Steps[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selected = YES;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_DISH_VIDEO_STEP_INFO cacheByIndexPath:indexPath configuration:^(YHSCookBookDishVideoStepTableViewCell *cell) {
        // 配置 cell 的数据源，和 "cellForRow" 干的事一致
        cell.model = self.videoStepModel.Steps[indexPath.row];
    }];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 记录当前选中的行下标
    self.currentSelectedRowIndex = indexPath.row;
    
    // 1.首先全部不选中，处理自动跳转过程中又手动点击情况
    {
       [self reloadUnSelectTableView];
    }

    // 2.处理选中的行
    {
        // 数据模型
        self.videoStepModel.Steps[indexPath.row].selected = YES;
        
        // 改变Cell背影色
        YHSCookBookDishVideoStepTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell didSelectPublicContainerView:YES];
        
        // 如果视屏播放控件存在，则跳转到指定XX秒
        if (_videoZFPlayerView) {
            NSInteger seekTime = self.videoStepModel.Steps[indexPath.row].Point/1000.0;
            [_videoZFPlayerView seekToTime:seekTime completionHandler:nil];
            [_videoZFPlayerView setHasRepeatBtn:NO];
        } else {
            // 如果视屏播放控件不存在，则创建后跳转到指定XX秒
            if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithDishVideofModel:)]) {
                [self.delegate didClickElementOfCellWithDishVideofModel:self.videoStepModel.Steps[indexPath.row]];
            }
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 更新数据模型
    self.videoStepModel.Steps[indexPath.row].selected = NO;
    
    // 改变Cell背影色
    YHSCookBookDishVideoStepTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell didSelectPublicContainerView:NO];

}


# pragma mark - ZFPlayerViewDelegate

/**
 * 重播按钮
 */
- (void)repeatPlayAction
{
    [self reloadUnSelectTableView];
}

/** 监听播放进度
 * value 进度条的值
 * currMin 当前播放时间：分
 * currSec 当前播放时间：秒
 * durMin 总的播放时间：分
 * durSec 总的播放时间：秒
 **/
- (void)videoSliderValueChange:(float)value currMin:(NSInteger)currMin currSec:(NSInteger)currSec durMin:(NSInteger)durMin durSec:(NSInteger)durSec
{
    NSInteger selectIndex = [self findIndexPathRowBySliderValue:currMin*60+currSec];
    
    // 按播放进度选中表格行，并改变背景色
    if (-1 < selectIndex && selectIndex != self.currentSelectedRowIndex) {
        
        // 记录当前选中的行下标
        self.currentSelectedRowIndex = selectIndex;
        
        // 设置所有的行为未选中状态（用户可能会点击表格行，这里无法确定是那一行，所以全部设置为未选中状态，并刷新表格）
        [self reloadUnSelectTableView];
        
        // 选中的行
        {
            // 数据模型
            self.videoStepModel.Steps[selectIndex].selected = YES;
            
            // 改变Cell背影色
            NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:selectIndex inSection:0];
            YHSCookBookDishVideoStepTableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectIndexPath];
            [cell didSelectPublicContainerView:YES];
            
            // 自动滚动到某行
            [self.tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            
        }

    }
    
}

#pragma mark - Private function

// 根据当前毫秒数据确定步骤下标
- (NSInteger)findIndexPathRowBySliderValue:(NSInteger)currSec
{
    NSInteger currIndex = 0;
    
    for (NSInteger index = self.videoStepModel.Steps.count-1; index >= 0; -- index) {
        if (currSec > self.videoStepModel.Steps[index].Point/1000) {
            currIndex = index;
            break;
        }
    }
    
    return currIndex;
}

// 表格不选中状态，刷新
- (void)reloadUnSelectTableView
{
    [self.videoStepModel.Steps enumerateObjectsUsingBlock:^(YHSCookBookVideoStepModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = NO;
    }];
    [self.tableView reloadData];
}


@end
