//
//  YHSTopicGroupTableSectionHeaderView.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSTopicGroupTableSectionHeaderView.h"
#import "YHSBasicViewController.h"

@interface YHSTopicGroupTableSectionHeaderView ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 图标
@property (nonatomic, strong) NSString *imageIconName;
@property (nonatomic, strong) UIImageView *imageIconView;

// 标题
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *title;

// 详情
@property (nonatomic, strong) UIImageView *allImageView;

// 第N个Section
@property (nonatomic, assign) NSInteger tableSection;


@end


@implementation YHSTopicGroupTableSectionHeaderView


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageIcon:(NSString *)imageIconName tableSecion:(NSInteger)tableSection
{
    self = [super init];
    if (self) {
        _title = title;
        _imageIconName = imageIconName;
        _tableSection = tableSection;
        [self createUI];
        [self setViewAtuoLayout];
    }
    return self;
}

- (void)createUI {
    
    // 根容器组件
    self.rootContainerView = [[UIView alloc] init];
    [self.rootContainerView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.rootContainerView];
    
    // 图标
    self.imageIconView = [[UIImageView alloc] init];
    [self.imageIconView setImage:[UIImage imageNamed:_imageIconName]];
    [self.rootContainerView addSubview:self.imageIconView];
    
    // 标题
    self.titleLabel = [[UILabel alloc] init];
    NSString *titleText = _title;
    NSDictionary *titleDict = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16], NSForegroundColorAttributeName:[UIColor blackColor]};
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:titleText attributes:titleDict];
    self.titleLabel.attributedText = attributedTitle;
    self.titleLabel.userInteractionEnabled = YES;
    self.titleLabel.backgroundColor = [UIColor whiteColor];
    [self.rootContainerView addSubview:self.titleLabel];
    
    // 全部
    self.allImageView = [[UIImageView alloc] init];
    [self.allImageView setImage:[UIImage imageNamed:@"ico_auxiliary_more"]];
    [self.rootContainerView addSubview:self.allImageView];
    
    // 添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressHeaderAction:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGesture];
}

- (void)setViewAtuoLayout {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 间距
    CGFloat margin = 10.0;
    CGFloat iconSize = 20.0;
    CGFloat accessorySize = 19.0;
    CGFloat headerHight = 45.0;
    
    // 根容器组件
    [self.rootContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    // 图标
    [self.imageIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset((headerHight-iconSize)/2.0);
        make.left.equalTo(weakSelf.mas_top).with.offset(margin);
        make.width.equalTo(@(iconSize));
        make.height.equalTo(@(iconSize));
    }];
    
    // 标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(margin);
        make.left.equalTo(weakSelf.imageIconView.mas_right).with.offset(margin/2.0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(-margin);
        make.right.equalTo(weakSelf.allImageView.mas_left).with.offset(-margin);
    }];
    
    // 按钮-CGSize(19,19)
    [self.allImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset((headerHight-accessorySize)/2.0);
        make.left.equalTo(weakSelf.mas_right).with.offset(-margin-accessorySize);
        make.width.equalTo(@(accessorySize));
        make.height.equalTo(@(accessorySize));
    }];
    
}

#pragma mark - 触发操作事件
- (void)pressHeaderAction:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickHeaderOfTableSecion:)]) {
        [self.delegate didClickHeaderOfTableSecion:self.tableSection];
    }
    
}

@end
