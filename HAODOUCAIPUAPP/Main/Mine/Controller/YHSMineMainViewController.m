//
//  YHSMineMainViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSMineMainViewController.h"

@interface YHSMineMainViewController ()

@end

@implementation YHSMineMainViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 创建主界面
    [self createMainUI];
    
}


- (void)createMainUI
{
    WEAKSELF(weakSelf);
    
    CGFloat separatorLineHeightA = 1.0;
    CGFloat separatorLineHeightB = 3.0;
    CGFloat separatorLineHeightC = 6.0;
    CGFloat areaViewHeight = 45.0;
    
    // 根视图容器
    UIScrollView *rootScrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [scrollView setBounces:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [self.view addSubview:scrollView];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).with.offset(0.0);
            make.left.equalTo(weakSelf.view).with.offset(0.0);
            make.bottom.equalTo(weakSelf.mas_bottomLayoutGuide).with.offset(0.0);
            make.right.equalTo(weakSelf.view).with.offset(0.0);
        }];
        scrollView;
    });
    
    // 公共容器
    UIView *publicContainerView = ({
        UIView *container = [[UIView alloc] init];
        [container setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.00]];
        [rootScrollView addSubview:container];
        
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(rootScrollView);
            make.width.equalTo(rootScrollView);
        }];
        container;
    });
    
    
    // 登录区域
    UIImageView *loginAreaView = ({
        UIImageView *imageView = [UIImageView new];
        [imageView setUserInteractionEnabled:YES];
        [imageView setImage:[UIImage imageNamed:@"mine_header_bg_login.jpg"]];
        [publicContainerView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(publicContainerView.mas_top);
            make.left.equalTo(publicContainerView);
            make.right.equalTo(publicContainerView);
            make.height.mas_equalTo(@(120));
        }];
        
        imageView;
    });
    
    
    // 菜谱-话题-相册-草稿
    UIView *menuTopicPhotoDraftAreaView = ({
        UIView *view = [[UIView alloc] init];
        [publicContainerView addSubview:view];
        
        view.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                          saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                          brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                               alpha:1];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(loginAreaView.mas_bottom);
            make.left.equalTo(publicContainerView);
            make.right.equalTo(publicContainerView);
            make.height.mas_equalTo(@(80));
        }];
        
        view;
    });
    {
        
    }
    
    
    // 发布菜谱
    UIView *publishMenuAreaView = [self createRowAreaViewWithTag:1001 iconName:@"ico_center_camera" title:@"发布菜谱" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:menuTopicPhotoDraftAreaView separatorLineHeight:separatorLineHeightC];
    
    // 我的动态
    UIView *myDynamicAreaView = [self createRowAreaViewWithTag:1002 iconName:@"ico_user_my_dynamic" title:@"我的动态" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:publishMenuAreaView separatorLineHeight:separatorLineHeightC];
    
    // 消息
    UIView *messageAreaView = [self createRowAreaViewWithTag:1003 iconName:@"ico_user_my_message" title:@"消息" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:myDynamicAreaView separatorLineHeight:separatorLineHeightA];
    
    // 做任务赚豆币
    UIView *taskAreaView = [self createRowAreaViewWithTag:1004 iconName:@"ico_user_zrwzdb" title:@"做任务赚豆币" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:messageAreaView separatorLineHeight:separatorLineHeightC];
    
    // 礼品兑换
    UIView *giftExchangeAreaView = [self createRowAreaViewWithTag:1005 iconName:@"ico_user_gift_exchange" title:@"礼品兑换" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:taskAreaView separatorLineHeight:separatorLineHeightA];
    
    // 我的订单
    UIView *myOrderAreaView = [self createRowAreaViewWithTag:1006 iconName:@"ico_user_myorder" title:@"我的订单" detailInfo:@"查看全部订单" height:areaViewHeight parentView:publicContainerView previousView:giftExchangeAreaView separatorLineHeight:separatorLineHeightB];
    
    // 待付款-待发货-待收货-待评价-退款
    UIView *buyProgressAreaView = ({
        UIView *view = [[UIView alloc] init];
        [view setBackgroundColor:[UIColor whiteColor]];
        [publicContainerView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(myOrderAreaView.mas_bottom).offset(separatorLineHeightB);
            make.left.equalTo(publicContainerView);
            make.right.equalTo(publicContainerView);
            make.height.mas_equalTo(@(60));
        }];
        
        view;
    });
    // 收货过程
    [self createBuyProgressUI:buyProgressAreaView];
    
    // 我的优惠劵
    UIView *mycouponsAreaView = [self createRowAreaViewWithTag:1007 iconName:@"ico_user_mycoupons" title:@"我的优惠劵" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:buyProgressAreaView separatorLineHeight:separatorLineHeightA];
    
    // 收货地址
    UIView *deliveryAddressAreaView = [self createRowAreaViewWithTag:1008 iconName:@"ico_delivery_address" title:@"收货地址" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:mycouponsAreaView separatorLineHeight:separatorLineHeightA];
    
    // 我的下载
    UIView *myDownAreaView = [self createRowAreaViewWithTag:1009 iconName:@"ico_user_mydown" title:@"我的下载" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:deliveryAddressAreaView separatorLineHeight:separatorLineHeightC];
    
    // 我的收藏
    UIView *myFavAreaView = [self createRowAreaViewWithTag:1010 iconName:@"ico_user_myfav" title:@"我的收藏" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:myDownAreaView separatorLineHeight:separatorLineHeightA];
    
    // 采购清单
    UIView *purchaseListAreaView = [self createRowAreaViewWithTag:1011 iconName:@"ico_user_purchase_list" title:@"采购清单" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:myFavAreaView separatorLineHeight:separatorLineHeightA];
    
    // 好豆小智
    UIView *haodouxzAreaView = [self createRowAreaViewWithTag:1012 iconName:@"ico_user_haodouxz" title:@"好豆小智" detailInfo:@"" height:areaViewHeight parentView:publicContainerView previousView:purchaseListAreaView separatorLineHeight:separatorLineHeightA];
    
    // 意见反馈
    UILabel *suggestionsLabel = ({
        UILabel *label = [UILabel new];
        [label setText:@"意见反馈"];
        [label setUserInteractionEnabled:YES];
        [label setTextColor:[UIColor blackColor]];
        [label setBackgroundColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:16.0]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [publicContainerView addSubview:label];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressSuggestionsLabel:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [label addGestureRecognizer:tapGesture];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(haodouxzAreaView.mas_bottom).offset(separatorLineHeightC);
            make.left.equalTo(publicContainerView);
            make.right.equalTo(publicContainerView);
            make.height.mas_equalTo(@(areaViewHeight));
        }];
        
        label;
    });
    
    // 约束的完整性
    [publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(suggestionsLabel.mas_bottom).offset(separatorLineHeightC);
    }];
    
}


// 创建UI界面行
- (UIView *)createRowAreaViewWithTag:(NSInteger)tag iconName:(NSString *)iconImageName title:(NSString *)title detailInfo:(NSString *)detailInfo height:(CGFloat)height parentView:(UIView *)parentView previousView:(UIView *)previousView separatorLineHeight:(CGFloat)separatorLineHeight
{
    CGFloat margin = 10.0;
    
    // 容器
    UIView *container = [[UIView alloc] init];
    [container setTag:tag];
    [container setBackgroundColor:[UIColor whiteColor]];
    [parentView addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(previousView.mas_bottom).offset(separatorLineHeight);
        make.left.equalTo(parentView);
        make.right.equalTo(parentView);
        make.height.mas_equalTo(@(height));
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressContainerViewArea:)];
    tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
    tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
    [container addGestureRecognizer:tapGesture];
    
    
    // 左图标
    CGFloat leftImageWidth = 22.0;
    CGFloat leftImageHeight = 22.0;
    UIImageView *leftImageView = [UIImageView new];
    [leftImageView setUserInteractionEnabled:YES];
    [leftImageView setImage:[UIImage imageNamed:iconImageName]];
    [container addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(container.mas_centerY);
        make.left.equalTo(container).offset(margin);
        make.size.mas_equalTo(CGSizeMake(leftImageWidth, leftImageHeight));
    }];
    
    // 标题
    UILabel *titleLabel = [UILabel new];
    [titleLabel setText:title];
    [titleLabel setUserInteractionEnabled:YES];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [container addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(container.mas_centerY);
        make.left.equalTo(leftImageView.mas_right).offset(margin);
        //make.right.equalTo(container.mas_right);
    }];
    
    // 右图标
    CGFloat rightImageWidth = 10.0;
    CGFloat rightImageHeight = 15.0;
    UIImageView *rightImageView = [UIImageView new];
    [rightImageView setUserInteractionEnabled:YES];
    [rightImageView setImage:[UIImage imageNamed:@"arrow_right"]];
    [container addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(container.mas_centerY);
        make.left.equalTo(container.mas_right).offset(-margin-rightImageWidth);
        make.right.equalTo(container.mas_right).offset(-margin);
        make.size.mas_equalTo(CGSizeMake(rightImageWidth, rightImageHeight));
    }];
    
    // 详情
    UILabel *detailLabel = [UILabel new];
    [detailLabel setText:detailInfo];
    [detailLabel setUserInteractionEnabled:YES];
    [detailLabel setTextColor:[UIColor lightGrayColor]];
    [detailLabel setFont:[UIFont systemFontOfSize:14.0]];
    [detailLabel setTextAlignment:NSTextAlignmentRight];
    [container addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(container.mas_centerY);
        make.left.equalTo(titleLabel.mas_right).offset(margin);
        make.right.equalTo(rightImageView.mas_left);
    }];
    
    return container;
}

// 收货过程
- (void)createBuyProgressUI:(UIView *)buyContainerView
{
    CGFloat margin = 10.0;
    CGFloat iconImageWidth = 26.0;
    CGFloat iconImageHeight = 22.0;
    NSArray<NSString *> *titles = @[@"待付款", @"待发货", @"待收货", @"待评价", @"退款"];
    NSArray<NSString *> *imageNames = @[@"icon_not_pay", @"icon_order_undelivery", @"icon_delivery", @"icon_to_review", @"icon_refund_suc"];
    NSMutableArray<UIView *> *containerViews = [NSMutableArray array];
    for (int index = 0; index < imageNames.count; index ++) {
        
        // 容器
        UIView *containerView = ({
            UIView *view = [UIView new];
            [view setTag:(index+2000)];
            [view.layer setMasksToBounds:YES];
            [buyContainerView addSubview:view];
            
            // 点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressBuyProgressViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [view addGestureRecognizer:tapGesture];
            
            view;
        });
        [containerViews addObject:containerView];
        
        // 图标
        UIImageView *imageView = ({
            UIImageView *imageView = [UIImageView new];
            [imageView setImage:[UIImage imageNamed:imageNames[index]]];
            [imageView.layer setMasksToBounds:YES];
            [imageView setUserInteractionEnabled:YES];
            [containerView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(containerView.mas_top).offset(margin);
                make.centerX.equalTo(containerView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(iconImageWidth, iconImageHeight));
            }];
            
            imageView;
        });

        // 标题
        UILabel *titlelabel = [UILabel new];
        [titlelabel setText:titles[index]];
        [titlelabel setUserInteractionEnabled:YES];
        [titlelabel setTextColor:[UIColor blackColor]];
        [titlelabel setFont:[UIFont systemFontOfSize:12]];
        [titlelabel setTextAlignment:NSTextAlignmentCenter];
        [containerView addSubview:titlelabel];
        
        [titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.mas_bottom).offset(margin/2.0);
            make.left.equalTo(containerView.mas_left);
            make.right.equalTo(containerView.mas_right);
        }];
    
    }
    [containerViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0.0 leadSpacing:0.0 tailSpacing:0.0];
    [containerViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buyContainerView.mas_top);
        make.bottom.equalTo(buyContainerView.mas_bottom);
    }];
    
}


#pragma mark - 自定义配置导航栏
- (void)customNavigationBar
{
    [super customNavigationBar];
    
    WEAKSELF(weakSelf);
    
    // 自定义导航栏
    if (self.navigationController) {
        
        CGFloat margin = 10;
        CGFloat width = 26.0; // 最大值为44
        
        // 1.自定义导航条
        self.navBarCustomView = [[YHSNavigationBarTitleView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
        [self.navBarCustomView setBackgroundColor:COLOR_NAVIGATION_BAR];
        [self.navigationItem setTitleView:self.navBarCustomView];
        
        // 2.设置
        UIButton *settingItem = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-margin-width, ((44-width)/2.0), width, width)];
            [button.layer setMasksToBounds:YES];
            [button.layer setCornerRadius:width/2.0];
            [button setAdjustsImageWhenHighlighted:NO];
            UIImage *image = [[[UIImage imageNamed:@"ico_user_operate"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] transformtoSize:CGSizeMake(width, width)];
            [button setImage:image forState:UIControlStateNormal];
            [button setImage:image forState:UIControlStateSelected];
            [button addTarget:self action:@selector(naviSettingBarButtonItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.navBarCustomView addSubview:button];
            
            button;
        });
        self.settingItem  = settingItem;
        
        // 3.标题
        self.title = @"我的";
        UILabel *titleNavItem = ({
            UILabel *label = [[UILabel alloc] init];
            [label setText:self.title];
            [label setTextColor:COLOR_NAVIGATION_BAR_TITLE_YELLOW];
            [label setFont:[UIFont boldSystemFontOfSize:FONT_SIZE_NAVIGATION_20]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [self.navBarCustomView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.navBarCustomView.mas_centerX);
                make.centerY.equalTo(weakSelf.navBarCustomView.mas_centerY);
                make.top.equalTo(weakSelf.navBarCustomView.mas_top).offset(0.0);
                make.bottom.equalTo(weakSelf.navBarCustomView.mas_bottom).offset(0.0);
            }];
            
            label;
        });
        self.titleNavItem  = titleNavItem;
        
    }
    
}


#pragma mark - 触发设置按钮事件
- (void)naviSettingBarButtonItemClicked:(UIButton *)button
{
    [self alertPromptMessage:@""];
}



// 点击行视图容器
- (void)pressContainerViewArea:(UITapGestureRecognizer *)gesture
{
    UIView *view = (UIView *)gesture.view;
    NSInteger index = [view tag] - 1001;
    
    NSArray<NSString *> *titles = @[@"发布菜谱", @"我的动态", @"消息", @"做任务赚豆币", @"礼品兑换", @"我的订单", @"我的优惠劵", @"收货地址", @"我的下载", @"我的收藏", @"采购清单", @"好豆小智"];
    
    [self alertPromptMessage:titles[index]];
    
}

// 意见反馈
- (void)pressSuggestionsLabel:(UITapGestureRecognizer *)gesture
{
    [self alertPromptMessage:@"意见反馈"];
}


// 收货过程
- (void)pressBuyProgressViewArea:(UITapGestureRecognizer *)gesture
{
    UIView *view = (UIView *)gesture.view;
    NSInteger index = [view tag]-2000;
    
    NSArray<NSString *> *titles = @[@"待付款", @"待发货", @"待收货", @"待评价", @"退款"];
    
    [self alertPromptMessage:titles[index]];
}


@end
