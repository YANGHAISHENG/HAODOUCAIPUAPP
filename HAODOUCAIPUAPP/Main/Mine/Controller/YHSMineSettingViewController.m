//
//  YHSMineSettingViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/8/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSMineSettingViewController.h"
#import "YHSDevelopUtil.h"


@interface YHSMineSettingViewController ()

@property (nonatomic, strong) UILabel *cacheLabel;

@end

@implementation YHSMineSettingViewController

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
    
    CGFloat separatorLineHeight = 5.0;
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
    
    // 空白区域
    UIView *spaceAreaView = ({
        UIView *view = [UIView new];
        [publicContainerView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(publicContainerView.mas_top);
            make.left.equalTo(publicContainerView);
            make.right.equalTo(publicContainerView);
            make.height.mas_equalTo(@(0));
        }];
        
        view;
    });
    
    // 清除缓存
    UIView *clearCacheAreaView = [self createClearCacheAreaViewWithTitle:@"清除缓存" height:areaViewHeight parentView:publicContainerView previousView:spaceAreaView separatorLineHeight:separatorLineHeight];
    
    // 约束的完整性
    [publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(clearCacheAreaView.mas_bottom).offset(separatorLineHeight);
    }];
    
}



// 清除缓存
- (UIView *)createClearCacheAreaViewWithTitle:(NSString *)title height:(CGFloat)height parentView:(UIView *)parentView previousView:(UIView *)previousView separatorLineHeight:(CGFloat)separatorLineHeight
{
    CGFloat margin = 10.0;
    
    // 容器
    UIView *container = [[UIView alloc] init];
    [container setBackgroundColor:[UIColor whiteColor]];
    [parentView addSubview:container];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(previousView.mas_bottom).offset(separatorLineHeight);
        make.left.equalTo(parentView);
        make.right.equalTo(parentView);
        make.height.mas_equalTo(@(height));
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(putBufferBtnClicked:)];
    tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
    tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
    [container addGestureRecognizer:tapGesture];
    
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
        make.left.equalTo(container.mas_left).offset(margin);
    }];
    
    // 计算缓存大小
    CGFloat homeCachesSize = [YHSDevelopUtil folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject];
    CGFloat librayCachesSize = [YHSDevelopUtil folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject];
    CGFloat temporaryCachesSize = [YHSDevelopUtil folderSizeAtPath:NSTemporaryDirectory()];
    CGFloat cacheSize = homeCachesSize + librayCachesSize + temporaryCachesSize;
    NSString *message = cacheSize > 1 ? [NSString stringWithFormat:@"%.2fM", cacheSize] : [NSString stringWithFormat:@"%.2fK", cacheSize * 1024.0];
    
    // 详情
    UILabel *detailLabel = [UILabel new];
    [detailLabel setText:message];
    [detailLabel setUserInteractionEnabled:YES];
    [detailLabel setTextColor:[UIColor blackColor]];
    [detailLabel setFont:[UIFont systemFontOfSize:16.0]];
    [detailLabel setTextAlignment:NSTextAlignmentRight];
    [container addSubview:detailLabel];
    self.cacheLabel = detailLabel;
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(container.mas_centerY);
        make.left.equalTo(titleLabel.mas_right).offset(margin);
        make.right.equalTo(container.mas_right).offset(-margin);
    }];
    
    return container;
}


// 点击行视图容器
- (void)putBufferBtnClicked:(UITapGestureRecognizer *)gesture
{
    WEAKSELF(weakSelf);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定清除缓存？" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [YHSDevelopUtil clearCaches:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject];
        [YHSDevelopUtil clearCaches:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject];
        [YHSDevelopUtil clearCaches:NSTemporaryDirectory()];
        
        // 在 Main Dispatch Queue 中执行块(Block)，串行处理
        dispatch_async(dispatch_get_main_queue(), ^{
            // 刷新界面
            [weakSelf.cacheLabel setText:@"0.00K"];
        });

    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alert addAction:action];
    [alert addAction:cancel];
    [self showDetailViewController:alert sender:nil];    
}

@end
