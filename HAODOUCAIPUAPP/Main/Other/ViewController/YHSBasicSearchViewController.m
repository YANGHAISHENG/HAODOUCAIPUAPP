//
//  YHSBasicSearchViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "TBAnimationButton.h"

#import "YHSBasicSearchViewController.h"

#import "YHSCookBookSearchModel.h"
#import "YHSCookBookSearchTableViewCell.h"
#import "YHSCookBookSearchClearAllTableViewCell.h"
#import "YHSCookBookSearchDetailViewController.h"
#import "YHSCookBookSearchVIPViewController.h"

@interface YHSBasicSearchViewController () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate, YHSCookBookSearchTableViewCellDelegate, YHSCookBookSearchClearAllTableViewCellDelegate>

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;


/**
 * 搜索结果
 */
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<YHSCookBookSearchModel *> *> *tableData; // 搜索结果
@property (nonatomic, strong) NSMutableArray<YHSCookBookSearchModel *> *clearAllModels;
@property (nonatomic, strong) NSMutableArray<YHSCookBookSearchModel *> *historyModels;
@property (nonatomic, strong) NSMutableArray<YHSCookBookSearchModel *> *searchFriendModels;

/**
 * 搜索历史记录
 */
@property (nonatomic, assign) NSUInteger offset;
@property (nonatomic, assign) NSUInteger limit;

@end


@implementation YHSBasicSearchViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        _offset = 0;
        _limit = 100;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navBarHairlineImageView setHidden:NO];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 搜索框设置第一响应者
    [self.searchTextField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 搜索框注销第一响应者
    [self.searchTextField resignFirstResponder];
}

#pragma make 监听网络变化后执行
- (void)viewDidLoadWithNetworkingStatus
{
    [self loadNewHistoryDataThenUpdateUI];
}

#pragma mark - 重新加载所数据并更新UI
- (void)loadNewHistoryDataThenUpdateUI
{
    WEAKSELF(weakSelf);
    
    // 先删除所有元素
    [self.tableData removeAllObjects];
    
    // 请求本地历史记录
    [self loadDataOfHistoryThen:^(BOOL success, NSUInteger count){
        
        // 配置界面
        [weakSelf createUI];
        
        // 刷新表格
        [weakSelf.tableView reloadData];
        
    }];
}


#pragma make 创建子控件
- (void) createUI {
    
    // 表格已经存在或无数据源则无需创建，直接返回
    if (self.tableView) {
        return;
    }
    
    WEAKSELF(weakSelf);
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
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
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, HEIGHT_NAVIGATION_STATUS + HEIGHT_NAVIGATION_BAR, SCREEN_WIDTH, SCREEN_HEIGHT - HEIGHT_NAVIGATION_STATUS - HEIGHT_NAVIGATION_BAR) style:UITableViewStylePlain];
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
        self.tableView.estimatedRowHeight = 50; //预算行高
        self.tableView.fd_debugLogEnabled = NO; //开启log打印高度
        
        // 设置表格背景
        UIView *backView = [[UIView alloc] init];
        [backView setBackgroundColor:[UIColor whiteColor]];
        [self.tableView setBackgroundView:backView];
        
        // 表头表尾
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        
        // 必须被注册到 UITableView 中
        [self.tableView registerClass:[YHSCookBookSearchTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH];
        [self.tableView registerClass:[YHSCookBookSearchClearAllTableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH_CLEAR_ALL];
    }
    
}

#pragma mark - 请求本地历史记录
- (void)loadDataOfHistoryThen:(void (^)(BOOL success, NSUInteger count))then {
    
    // 查询数据是否成功
    __block BOOL isSuccess = NO;
    __block NSUInteger listCount = 0;
    
    // 数据库查询历史记录操作
    NSMutableArray<YHSCookBookSearchModel *>* searchModels = [YHSCookBookSearchModel searchWithWhere:nil orderBy:@"rowid desc" offset:_offset count:_limit];
    
    // 第一次请求，或下拉刷新数据
    if (0 == _offset) {
        
        // 1.清空历史记录
        if (searchModels.count > 0) {
            YHSCookBookSearchModel *clearAll = [YHSCookBookSearchModel new];
            [clearAll setKeyword:@"清空历史记录"];
            [clearAll setModelType:YHSCookBookTableSectionClearAll];
            self.clearAllModels = @[clearAll].mutableCopy;
        } else {
            self.clearAllModels = @[].mutableCopy;
        }
        
        // 2.历史记录
        self.historyModels = searchModels.mutableCopy;
        
        // 3.搜索逗友
        self.searchFriendModels = @[].mutableCopy;
        
        // 设置数据源
        [self.tableData addObject:self.clearAllModels];
        [self.tableData addObject:self.historyModels];
        [self.tableData addObject:self.searchFriendModels];
        
    } else {
        
        // 历史记录
        [self.historyModels addObjectsFromArray:searchModels];
        
        // 设置数据源
        [self.tableData replaceObjectAtIndex:1 withObject:self.historyModels];
    }
    
    // 请求数据成功
    isSuccess = YES;
    listCount = searchModels.count;
    
    // 在 Main Dispatch Queue 中执行块(Block)，串行处理
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // 刷新界面
        !then ?: then(isSuccess, listCount);
        
    });
    
}


#pragma mark - 请求网络数据
- (void)loadDataThen:(void (^)(BOOL success, NSUInteger count))then withKeyWord:(NSString *)keyword {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 在默认优先级的 Global Dispatch Queue 中执行块(Block)，并行处理
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 请求数据是否成功
        __block BOOL isSuccess = NO;
        __block NSUInteger listCount = 0; // 请求到的数据数量
        
        // 请求地址与参数
        NSString *url = [YHSCookBookDataUtil getSearchByKeyRequestURLString];
        NSMutableDictionary *params = [YHSCookBookDataUtil getSearchByKeyRequestParams];
        [params setObject:keyword forKey:@"keyword"];
        
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
            NSArray<NSString *> *list = data[@"list"];
            
            // 1.清除历史记录
            weakSelf.clearAllModels = @[].mutableCopy;
            
            // 2.历史记录
            weakSelf.historyModels = @[].mutableCopy;
            NSMutableArray<YHSCookBookSearchModel *> *searchModels = [NSMutableArray array];
            [list enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                YHSCookBookSearchModel *model = [YHSCookBookSearchModel mj_objectWithKeyValues:@{@"keyword":obj}];
                [searchModels addObject:model];
            }];
            weakSelf.historyModels = searchModels;
            
            // 3.搜索逗友
            YHSCookBookSearchModel *searchFriends = [YHSCookBookSearchModel new];
            [searchFriends setKeyword:[NSString stringWithFormat:@"搜索”%@“相关菜友", keyword]];
            [searchFriends setModelType:YHSCookBookTableSectionSearchFriends];
            weakSelf.searchFriendModels = @[searchFriends].mutableCopy;
            
            // 设置数据源
            [weakSelf.tableData replaceObjectAtIndex:0 withObject:weakSelf.clearAllModels];
            [weakSelf.tableData replaceObjectAtIndex:1 withObject:weakSelf.historyModels];
            [weakSelf.tableData replaceObjectAtIndex:2 withObject:weakSelf.searchFriendModels];
            
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
    
    // 显示搜索输入框导航栏
    [self customNavigationSearchBar];
}

- (void)customNavigationTitleBar
{
    // 自定义导航栏
    if (self.navigationController.navigationBar) {
        
        CGFloat margin = 10;
        CGFloat navBarHeight = 44.0;
        CGFloat backItemSize = 36.0; // 最大值为44
        CGFloat searchItemSize = 20.0; // 最大值为44
        CGFloat searchTextHeight = 30; // 输入文本框高度
        
        for (UIView *view in self.navBarCustomView.subviews) {
            [view removeFromSuperview];
        }
        
        // 1.自定义导航条
        {
            self.navBarCustomView = [[YHSNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
            [self.navigationItem setTitleView:self.navBarCustomView];
        }
        
        // 2.导航条返回选项
        UIButton *backNavBtn = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(margin, ((navBarHeight-backItemSize)/2.0), backItemSize, backItemSize)];
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:backItemSize/2.0];
            [button setAdjustsImageWhenHighlighted:NO];
            UIImage *image = [[[UIImage imageNamed:@"btn_header_back_sec"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] transformtoSize:CGSizeMake(backItemSize, backItemSize)];
            [button setImage:image forState:UIControlStateNormal];
            [button setImage:image forState:UIControlStateSelected];
            [button addTarget:self action:@selector(naviBackBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.navBarCustomView addSubview:button];
            
            button;
        });
        self.backNavBtn  = backNavBtn;
        
        // 3.导航条搜索按钮区域
        {
            // 3.1搜索区域主容器
            UIView *searchAreaView = ({
                UIView *searchAreaView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(backNavBtn.frame), 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
                [searchAreaView.layer setBorderColor:COLOR_NAVIGATION_BAR_SEARCH.CGColor];
                [self.navBarCustomView addSubview:searchAreaView];
                
                searchAreaView;
            });
            self.searchAreaView  = searchAreaView;
            
            // 3.3.导航条搜索按钮
            UIImageView *searchIconImage = ({
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-CGRectGetMaxX(backNavBtn.frame)-margin-searchItemSize-margin/2.0, ((navBarHeight-searchItemSize)/2.0), searchItemSize, searchItemSize)];
                [imageView setUserInteractionEnabled:YES];
                [imageView setImage:[UIImage imageNamed:@"search_suggest"]];
                [self.searchAreaView addSubview:imageView];
                
                // 添加点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviSearchBarFindItemClicked:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1，注意在iOS中很少用双击操作
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [imageView addGestureRecognizer:tapGesture];
                
                imageView;
            });
            self.searchIconImage = searchIconImage;
            
            // 3.2导航条搜索标题
            {
                UILabel *searchTitle = [[UILabel alloc] init];
                [searchTitle setText:@"搜索"];
                [searchTitle setTextColor:COLOR_NAVIGATION_BAR_TITLE];
                [searchTitle setUserInteractionEnabled:YES];
                [searchTitle setFont:[UIFont boldSystemFontOfSize:FONT_SIZE_NAVIGATION]];
                [searchTitle setTextAlignment:NSTextAlignmentLeft];
                [searchAreaView addSubview:searchTitle];
                
                // 添加点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviSearchBarFindItemClicked:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1，注意在iOS中很少用双击操作
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [searchTitle addGestureRecognizer:tapGesture];
                
                [searchTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(searchAreaView.mas_top).offset(((navBarHeight-searchTextHeight)/2.0));
                    make.left.equalTo(searchAreaView.mas_left).offset(0.0);
                    make.right.equalTo(searchIconImage.mas_left).offset(-margin);
                    make.height.equalTo(@(searchTextHeight));
                }];
            }
            
        }
    }
    
}

- (void)customNavigationSearchBar
{
    // 自定义导航栏
    if (self.navigationController.navigationBar) {
        
        CGFloat margin = 10;
        CGFloat navBarHeight = 44.0;
        CGFloat backItemSize = 36.0; // 最大值为44
        CGFloat searchItemSize = 20.0; // 最大值为44
        CGFloat searchTextHeight = 30; // 输入文本框高度
        
        for (UIView *view in self.navBarCustomView.subviews) {
            [view removeFromSuperview];
        }
        
        // 1.自定义导航条
        {
            self.navBarCustomView = [[YHSNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
            [self.navigationItem setTitleView:self.navBarCustomView];
        }
        
        // 2.导航条返回选项
        UIButton *backNavBtn = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(margin, ((navBarHeight-backItemSize)/2.0), backItemSize, backItemSize)];
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:backItemSize/2.0];
            [button setAdjustsImageWhenHighlighted:NO];
            UIImage *image = [[[UIImage imageNamed:@"btn_header_back_sec"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] transformtoSize:CGSizeMake(backItemSize, backItemSize)];
            [button setImage:image forState:UIControlStateNormal];
            [button setImage:image forState:UIControlStateSelected];
            [button addTarget:self action:@selector(naviBackBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.navBarCustomView addSubview:button];
            
            button;
        });
        self.backNavBtn  = backNavBtn;
        
        // 3.导航条搜索按钮区域
        {
            // 3.1搜索区域主容器
            UIView *searchAreaView = ({
                UIView *searchAreaView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(backNavBtn.frame), 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
                [searchAreaView.layer setBorderColor:COLOR_NAVIGATION_BAR_SEARCH.CGColor];
                [self.navBarCustomView addSubview:searchAreaView];
                
                searchAreaView;
            });
            self.searchAreaView  = searchAreaView;
            
            // 3.3.导航条搜索按钮
            CGFloat temp = 3;
            TBAnimationButton *searchCrossButton = ({
                TBAnimationButton *button = [[TBAnimationButton alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-CGRectGetMaxX(backNavBtn.frame)-margin-searchItemSize, ((navBarHeight-searchItemSize+temp)/2.0), searchItemSize-temp, searchItemSize-temp)];
                [button setCurrentState:TBAnimationButtonStateCross];
                [button setLineColor:[UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1.00]];
                [button.layer setMasksToBounds:YES];
                [button addTarget:self action:@selector(naviSearchBarCrossItemClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.searchAreaView addSubview:button];
                
                button;
            });
            self.searchCrossButton = searchCrossButton;
            
            // 3.2导航条搜索标题
            UITextField *searchTextField = ({
                UITextField *textField = [[UITextField alloc] init];
                [searchAreaView addSubview:textField];
                [textField setAttributedPlaceholder:[[NSAttributedString alloc]initWithString:@"   搜索菜谱、专辑、豆友" attributes:@{NSForegroundColorAttributeName:COLOR_NAVIGATION_BAR_SEARCH_TITLE_GRAY}]];
                [textField setTextColor:COLOR_NAVIGATION_BAR_SEARCH_TITLE_GRAY];
                [textField setFont:[UIFont boldSystemFontOfSize:13.0]];
                [textField.layer setBorderWidth:1.0];
                [textField.layer setBorderColor:COLOR_NAVIGATION_BAR_SEARCH.CGColor];
                [textField.layer setCornerRadius:6.0];
                [textField.layer setMasksToBounds:YES];
                [textField setKeyboardType:UIKeyboardTypeDefault]; // 设置键盘样式
                [textField setReturnKeyType:UIReturnKeySearch]; // 设置return键的样式
                [textField becomeFirstResponder]; // 搜索框设置第一响应者
                [textField setDelegate:self];
                
                [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(searchAreaView.mas_top).offset(((navBarHeight-searchTextHeight)/2.0));
                    make.left.equalTo(searchAreaView.mas_left).offset(0.0);
                    make.right.equalTo(searchCrossButton.mas_left).offset(-margin);
                    make.height.equalTo(@(searchTextHeight));
                }];
                
                textField;
            });
            self.searchTextField = searchTextField;
        }
        
    }
    
}


#pragma mark - 触发搜索按钮事件

- (void)naviSearchBarCrossItemClicked:(TBAnimationButton *)button
{
    // 如果搜索框有内容，则删除
    if (self.searchTextField) {
        NSString *text =  self.searchTextField.text;
        if (text.length > 0) {
            [self.searchTextField setText:@""];
            [self.searchTextField becomeFirstResponder]; //
            [self loadNewHistoryDataThenUpdateUI]; // 重新加载刷新历史记录
            return;
        }
    }
    
    // 隐藏删除搜索输入框，显示搜索标题
    [self customNavigationTitleBar];
}

- (void)naviSearchBarFindItemClicked:(UITapGestureRecognizer *)gesture
{
    [self customNavigationSearchBar];
}

#pragma mark - UITextFieldDelegate

// 输入字符时调用的方法
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // string 就是此时输入的那个字符
    // textField 就是此时正在输入的那个输入框
    // 返回YES就是可以改变输入框的值，NO相反
    
    WEAKSELF(weakSelf);
    
    // 搜索关键字，得到输入框的内容
    NSString * searchString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (searchString.length == 0) {
        [self loadNewHistoryDataThenUpdateUI]; // 重新加载刷新历史记录
        return YES;
    }
    
    // 根据搜索关键字，请求网络数据
    [self loadDataThen:^(BOOL success, NSUInteger count) {
        
        // 加载成功
        if (success && count) {
            
            // 刷新表格
            [weakSelf.tableView reloadData];
            
        }
        
    } withKeyWord:searchString];
    
    return YES;
    
}


// 点击return键触发的函数
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    YHSLogLight(@"%s", __FUNCTION__);
    
    // 搜索关键字，得到输入框的内容
    NSString *searchString = textField.text;
    if (searchString.length == 0) {
        return NO;
    }
    
    //根据关键字显示详情页面
    [self didSearchWithKeyWord:searchString];
    
    return YES;
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
        case YHSCookBookTableSectionClearAll: {
            YHSCookBookSearchClearAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH_CLEAR_ALL];
            if (!cell) {
                cell = [[YHSCookBookSearchClearAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH_CLEAR_ALL];
            }
            cell.delegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case YHSCookBookTableSectionHistoryElem: {
            YHSCookBookSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH];
            if (!cell) {
                cell = [[YHSCookBookSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH];
            }
            cell.searchDelegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // MGSwipeTableCell
            cell.delegate = self;
            cell.allowsMultipleSwipe = NO;
            
            return cell;
        }
        case YHSCookBookTableSectionSearchFriends: {
            YHSCookBookSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH];
            if (!cell) {
                cell = [[YHSCookBookSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH];
            }
            cell.searchDelegate = self;
            cell.model = self.tableData[indexPath.section][indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            // MGSwipeTableCell
            cell.delegate = self;
            cell.allowsMultipleSwipe = NO;
            
            return cell;
        }
        default:{
            return nil;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case YHSCookBookTableSectionClearAll: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH_CLEAR_ALL cacheByIndexPath:indexPath configuration:^(YHSCookBookSearchClearAllTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        case YHSCookBookTableSectionHistoryElem: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH cacheByIndexPath:indexPath configuration:^(YHSCookBookSearchTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        case YHSCookBookTableSectionSearchFriends: {
            return [self.tableView fd_heightForCellWithIdentifier:CELL_IDENTIFIER_COOKBOOK_SEARCH cacheByIndexPath:indexPath configuration:^(YHSCookBookSearchTableViewCell *cell) {
                // 配置 cell 的数据源，和 "cellForRow" 干的事一致
                cell.model = self.tableData[indexPath.section][indexPath.row];
            }];
        }
        default:{
            return 0.0;
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    // 是否有数据
    if (!self.tableData || self.tableData.count == 0) {
        return nil;
    }
    
    switch (section) {
        case YHSCookBookTableSectionClearAll: {
            return nil;
        }
        case YHSCookBookTableSectionHistoryElem: {
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 10)];
            footerView.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00];
            return footerView;
        }
        case YHSCookBookTableSectionSearchFriends: {
            return nil;
        }
        default:{
            return nil;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    // 是否有数据
    if (!self.tableData || self.tableData.count == 0) {
        return 0.0;
    }
    
    switch (section) {
        case YHSCookBookTableSectionClearAll:{
            return 0.0;
        }
        case YHSCookBookTableSectionHistoryElem:{
            if (self.tableData.count >=3 && self.tableData[2].count>0) {
                return 10.0;
            }
            return 0.0;
        }
        case YHSCookBookTableSectionSearchFriends: {
            return 0.0;
        }
        default: {
            return 0.0;
        }
    }
    
    return 0.0;
}

#pragma mark - MGSwipeTableCellDelegate

// 设置TableCell按钮
- (NSArray*) swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings
{
    // 保证只有历史记录才显示菜单项，否则直接返回nil
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
    YHSCookBookSearchModel *model = self.tableData[indexPath.section][indexPath.row];
    if (YHSCookBookTableSectionHistoryElem != model.modelType) {
        return nil;
    }
    
    // MGSwipeTransitionBorder, MGSwipeTransitionStatic, MGSwipeTransitionClipCenter, MGSwipeTransitionDrag, MGSwipeTransition3D
    swipeSettings.transition = MGSwipeTransition3D;
    if (direction == MGSwipeDirectionRightToLeft) {
        expansionSettings.buttonIndex = 0;
        expansionSettings.fillOnTrigger = YES;
        return [self createRightButtons];
    }

    return nil;
}

// TableCell 按钮点击事件
- (BOOL)swipeTableCell:(MGSwipeTableCell*)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion
{
    YHSLogLight(@"Delegate: button tapped, %@ position, index %d, from Expansion: %@", direction == MGSwipeDirectionLeftToRight ? @"left" : @"right", (int)index, fromExpansion ? @"YES" : @"NO");
    
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
    YHSCookBookSearchModel *model = self.tableData[indexPath.section][indexPath.row];
    
    // 删除历史记录
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        
        BOOL delModel = NO;
        LKDBHelper* globalHelper = [YHSCookBookSearchModel getUsingLKDBHelper];
        
        BOOL ishas = [globalHelper isExistsModel:model];
        if (ishas) {
            BOOL isDelete = [globalHelper deleteToDB:model];;
            if (isDelete) {
                delModel = YES;
            }
        } else {
            delModel = YES;
        }
        
        if (delModel) {
            // 删除数据模型
            [self.tableData[indexPath.section] removeObjectAtIndex:indexPath.row];
    
            // 更新界面
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            return NO; // Don't auto hide to improve delete expansion animation
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"删除历史记录失败！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancleAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            return YES;
        }
    }
    // 搜索关键字
    else if (direction == MGSwipeDirectionRightToLeft && index == 1) {
        
        // 根据关键字进行搜索
        [self didSearchWithKeyWord:model.keyword];

        return YES;
    }
    
    return YES;
}

// 创建TableCell右边按钮
- (NSArray<MGSwipeButton *> *)createRightButtons
{
    NSMutableArray * rightButtons = [NSMutableArray array];
    // Title
    NSArray<NSString*> *titles = @[@"删除", @"搜索"];
    // Color
    NSArray<UIColor *> *colors = @[[UIColor redColor], [UIColor lightGrayColor]];
    // Create
    for (int i = 0; i < colors.count; ++i) {
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:titles[i] backgroundColor:colors[i]];
        [rightButtons addObject:button];
    }
    return rightButtons;
}


#pragma mark - 触发点击Cell事件
- (void)didClickElementOfCellWithCookBookSearchModel:(YHSCookBookSearchModel *)model
{
    // 根据关键字搜索相关豆友
    if (YHSCookBookTableSectionSearchFriends == model.modelType) {
        [self didSearchVIPWithName:model.keyword];
    }
    // 根据关键字显示详情页面
    else {
        [self didSearchWithKeyWord:model.keyword];
    }
    
}

// 清空所有历史记录
- (void)didClickElementOfCellWithCookBookSearchClearAllModel:(YHSCookBookSearchModel *)model
{
    WEAKSELF(weakSelf);
    
    // 删除数据库数据
    LKDBHelper* globalHelper = [YHSCookBookSearchModel getUsingLKDBHelper];
    BOOL isDelete = [globalHelper deleteWithClass:[YHSCookBookSearchModel class] where:nil];;
    if (isDelete) {
        // 删除数据模型
        weakSelf.clearAllModels = @[].mutableCopy;
        weakSelf.historyModels = @[].mutableCopy;
        [weakSelf.tableData[0] removeAllObjects];
        [weakSelf.tableData[1] removeAllObjects];
        
        // 更新界面
        [weakSelf.tableView reloadData];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"删除数据失败！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancleAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

#pragma mark - 根据关键字搜索相关豆友
- (void)didSearchVIPWithName:(NSString *)name
{
    NSString *searchString = self.searchTextField.text;
    
    // 创建模型
    YHSCookBookSearchModel *searchFriends = [YHSCookBookSearchModel new];
    [searchFriends setKeyword:searchString];
    [searchFriends setModelType:YHSCookBookTableSectionHistoryElem]; // 这里设置成变通元素
    
    // 存储历史记录
    [self didCollectHistoryModel:searchFriends];
    
    // 显示详细信息
    YHSCookBookSearchVIPViewController *vipInfoController = [YHSCookBookSearchVIPViewController new];
    [vipInfoController setName:searchString];
    [vipInfoController setTitle:@"搜索豆友"];
    [self.navigationController pushViewController:vipInfoController animated:YES];
}


#pragma mark - 根据关键字显示详情页面
- (void)didSearchWithKeyWord:(NSString *)keyword
{
    // 调用resignFirstResponder方法，收起键盘
    [self.searchTextField resignFirstResponder];
    
    // 收藏历史记录
    YHSCookBookSearchModel *historyModel = [YHSCookBookSearchModel new];
    [historyModel setKeyword:keyword];
    [historyModel setModelType:YHSCookBookTableSectionHistoryElem];
    
    // 存储历史记录
    [self didCollectHistoryModel:historyModel];
    
    // 显示详细信息
    YHSCookBookSearchDetailViewController *searchDetailController = [YHSCookBookSearchDetailViewController new];
    [searchDetailController setKeyWord:keyword];
    [self.navigationController pushViewController:searchDetailController animated:YES];
    
}


// 搜索关键字历史记录
- (void)didCollectHistoryModel:(YHSCookBookSearchModel *)model
{
    LKDBHelper* globalHelper = [YHSCookBookSearchModel getUsingLKDBHelper];
    BOOL ishas = [globalHelper isExistsClass:[YHSCookBookSearchModel class] where:@{@"keyword" : model.keyword}];
    if (!ishas) {
        NSString *message = @"搜索关键字添加成功！";
        BOOL isInsert = [globalHelper insertToDB:model];
        if (!isInsert) {
            message = @"搜索关键字添加失败！";
        }
        YHSLogRed(@"%@", message);
    }
}


@end
