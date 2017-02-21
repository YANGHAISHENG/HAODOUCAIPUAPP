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

// 标题
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *title;

// 图标
@property (nonatomic, copy) NSString *iconImageName;
@property (nonatomic, strong) UIImageView *iconImageView;

// 分割线
@property (nonatomic, strong) UIImageView *leftSeparatorLineImageView;
@property (nonatomic, strong) UIImageView *rightSeparatorLineImageView;

// 详情
@property (nonatomic, assign) BOOL isShowMoreBtn;
@property (nonatomic, strong) UIImageView *moreImageView;
@property (nonatomic, strong) UIView *moreContainerView;

// 高度
@property (nonatomic, assign) CGFloat headerViewHeight;

// 第N个Section
@property (nonatomic, assign) NSInteger tableSection;


@end


@implementation YHSTopicGroupTableSectionHeaderView



- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title iconImageName:(NSString *)iconImageName headerViewHeight:(CGFloat)headerViewHeight showMoreButton:(BOOL)isShowMoreButton tableSecion:(NSInteger)tableSection
{
    self = [super initWithFrame:frame];
    if (self) {
        _title = title;
        _iconImageName = iconImageName;
        _isShowMoreBtn = isShowMoreButton;
        _tableSection = tableSection;
        _headerViewHeight = headerViewHeight;
        [self createView];
        [self setViewAtuoLayout];
    }
    return self;
}

- (void)createView {
    
    // 根容器
    self.rootContainerView = [[UIView alloc] init];
    [self.rootContainerView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.rootContainerView];
    
    // 标题
    self.titleLabel = [[UILabel alloc] init];
    NSString *titleText = _title;
    NSDictionary *titleDict = @{NSFontAttributeName:[UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor blackColor]};
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:titleText attributes:titleDict];
    self.titleLabel.attributedText = attributedTitle;
    self.titleLabel.userInteractionEnabled = YES;
    [self.rootContainerView addSubview:self.titleLabel];
    
    // 图标
    self.iconImageView = [[UIImageView alloc] init];
    [self.iconImageView setImage:[UIImage imageNamed:_iconImageName]];
    [self.rootContainerView addSubview:self.iconImageView];
    
    // 左分割线
    self.leftSeparatorLineImageView = [[UIImageView alloc] init];
    [self.leftSeparatorLineImageView setImage:[UIImage imageNamed:@"icon_tab_section_left"]];
    [self.rootContainerView addSubview:self.leftSeparatorLineImageView];
    
    // 右分割线
    self.rightSeparatorLineImageView = [[UIImageView alloc] init];
    [self.rightSeparatorLineImageView setImage:[UIImage imageNamed:@"icon_tab_section_right"]];
    [self.rootContainerView addSubview:self.rightSeparatorLineImageView];
    
    // 更多
    {
        self.moreContainerView = [[UIView alloc] init];
        [self.moreContainerView setClipsToBounds:YES];
        [self.rootContainerView addSubview:self.self.moreContainerView];
        
        self.moreImageView = [[UIImageView alloc] init];
        [self.moreImageView setImage:[UIImage imageNamed:@"icon_show_more"]];
        [self.moreImageView setUserInteractionEnabled:YES];
        [self.moreContainerView addSubview:self.moreImageView];
        
        // 添加点击事件
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressHeaderAction:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [self.moreContainerView addGestureRecognizer:tapGesture];
    }
    
}

- (void)setViewAtuoLayout {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 间距
    CGFloat margin = 10.0f;
    CGFloat iconSizeWidth = 20.0f; // 图标宽度
    CGFloat iconSizeHeight = 18.0f; // 图标高度
    CGFloat accessorySize = 13.0f; // 更多按钮
    CGFloat accessoryTitleWidth = 30.0f;
    CGFloat separatorLineWidth = 60.0f;
    CGFloat separatorLineHeight = 20.0f;
    
    // 根容器组件
    [self.rootContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    // 标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX).offset((iconSizeWidth+margin/2.0)/2.0);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    // 图标
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.titleLabel.mas_left).with.offset(-margin/2.0);
        make.width.equalTo(@(iconSizeWidth));
        make.height.equalTo(@(iconSizeHeight));
    }];
    
    // 左分割线
    [self.leftSeparatorLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.iconImageView.mas_left).with.offset(-margin/3.0);
        make.width.equalTo(@(separatorLineWidth));
        make.height.equalTo(@(separatorLineHeight));
    }];
    
    // 右分割线
    [self.rightSeparatorLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.titleLabel.mas_right).with.offset(margin/3.0);
        make.width.equalTo(@(separatorLineWidth));
        make.height.equalTo(@(separatorLineHeight));
    }];
    
    // 更多
    {
        // 容器
        [self.moreContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_top).with.offset(0.0);
            make.right.equalTo(weakSelf.mas_right).with.offset(-margin);
            make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0.0);
            if (_isShowMoreBtn) {
                make.width.equalTo(@(accessorySize+accessoryTitleWidth));
            } else {
                make.width.equalTo(@(0.0));
            }
            
        }];
        
        // 图标-CGSize(19,19)
        [self.moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.moreContainerView.mas_centerY);
            make.right.equalTo(weakSelf.moreContainerView.mas_right).with.offset(0.0);
            make.width.equalTo(@(accessorySize));
            make.height.equalTo(@(accessorySize));
        }];
        
        // 标题
        UILabel *moreLabel = [[UILabel alloc] init];
        NSDictionary *titleDict = @{ NSFontAttributeName:[UIFont systemFontOfSize:13.0f], NSForegroundColorAttributeName:[UIColor colorWithRed:0.61 green:0.61 blue:0.61 alpha:1.00]};
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:@"更多" attributes:titleDict];
        moreLabel.attributedText = attributedTitle;
        moreLabel.userInteractionEnabled = YES;
        [self.moreContainerView addSubview:moreLabel];
        [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.moreImageView.mas_left).with.offset(-margin/4.0);
            make.centerY.equalTo(weakSelf.moreContainerView.mas_centerY);
        }];
    }
    
}


#pragma mark - 触发操作事件
- (void)pressHeaderAction:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickHeaderOfTableSecion:)]) {
        [self.delegate didClickHeaderOfTableSecion:self.tableSection];
    }
    
}

@end
