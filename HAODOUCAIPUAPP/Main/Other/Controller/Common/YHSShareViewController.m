//
//  YHSShareViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/2.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSShareViewController.h"
#import "TBAnimationButton.h"


@implementation YHSShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.cornerRadius =  5.0;
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 收藏区域
    [self collectionArea];
    
    // 关闭
    [self addCrossButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

// 收藏区域
- (void)collectionArea
{
    CGFloat marign = 10.0;
    
    __weak __typeof(&*self)weakSelf = self;
    
    UILabel *titleLabel = [UILabel new];
    [self.view addSubview:titleLabel];
    [titleLabel setText:@"分享："];
    [titleLabel setTextColor:[UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(20);
        make.left.equalTo(weakSelf.view).offset(marign);
        make.right.equalTo(weakSelf.view.mas_right).offset(-marign);
    }];
    
    
    UIView *lineView = [UIView new];
    [self.view addSubview:lineView];
    [lineView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00]];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view).offset(0.0);
        make.right.equalTo(weakSelf.view.mas_right).offset(0.0);
        make.height.equalTo(@(1.5));
    }];
    
    
    UILabel *content = [UILabel new];
    [self.view addSubview:content];
    [content setText:@"提示：功能模块未开发，请使用其它功能！"];
    [content setNumberOfLines:0];
    [content setTextColor:[UIColor blackColor]];
    [content setFont:[UIFont boldSystemFontOfSize:18.0]];
    [content setTextAlignment:NSTextAlignmentCenter];
    
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.left.equalTo(weakSelf.view).offset(marign);
        make.right.equalTo(weakSelf.view.mas_right).offset(-marign);
    }];
    
}

// 关闭
- (void)addCrossButton
{
    CGFloat marign = 10.0;
    __weak __typeof(&*self)weakSelf = self;
    TBAnimationButton *button = [[TBAnimationButton alloc] init];
    [button.layer setMasksToBounds:YES];
    [button setLineColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1.00]];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setCurrentState:TBAnimationButtonStateCross];
    [button addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).offset(marign);
        make.right.equalTo(weakSelf.view).offset(-marign);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    
}

- (void)dismissViewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
