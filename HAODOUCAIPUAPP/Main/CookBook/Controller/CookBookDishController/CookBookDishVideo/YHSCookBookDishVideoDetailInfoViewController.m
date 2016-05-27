

#import "YHSCookBookDishVideoDetailInfoViewController.h"

#import "YHSCookBookDishModel.h"


@interface YHSCookBookDishVideoDetailInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *tableData;

@end

@implementation YHSCookBookDishVideoDetailInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    
}


#pragma mark - 创建UI界面

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
        //[self.tableView registerClass:[YHSCookBookDishVideoStepTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_DISH_VIDEO_STEP_INFO];

    }
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}





@end
