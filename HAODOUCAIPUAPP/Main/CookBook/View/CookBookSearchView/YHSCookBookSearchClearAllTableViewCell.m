//
//  YHSCookBookSearchClearAllTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookSearchClearAllTableViewCell.h"
#import "YHSCookBookSearchModel.h"

NSString * const CELL_IDENTIFIER_COOKBOOK_SEARCH_CLEAR_ALL = @"YHSCookBookSearchClearAllTableViewCellID";


@interface YHSCookBookSearchClearAllTableViewCell ()

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 标题
 */
@property (nonnull, nonatomic, strong) UILabel *titleLabel;

/**
 * 分割线
 */
@property (nonnull, nonatomic, strong) UIView *separatorLineView;


@end


@implementation YHSCookBookSearchClearAllTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
        [self setViewAtuoLayout];
    }
    return self;
}

#pragma make 创建子控件
- (void) createView {
    
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    // 根容器组件
    self.rootContainerView = [[UIView alloc] init];
    [self.contentView addSubview:self.rootContainerView];
    
    // 公共容器组件
    {
        self.publicContainerView =[[UIView alloc] init];
        [self.publicContainerView.layer setMasksToBounds:YES];
        [self.rootContainerView addSubview:self.publicContainerView];
        
        // 点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressPublicContainerArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.publicContainerView addGestureRecognizer:tapGesture];
    }
    
    // 标题
    self.titleLabel = [UILabel new];
    [self.titleLabel setUserInteractionEnabled:YES];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.titleLabel];
    
    // 分割线
    self.separatorLineView =[[UIView alloc] init];
    [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    [self.rootContainerView addSubview:self.separatorLineView];
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10;
    
    // 根容器组件
    [self.rootContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).with.offset(0);
    }];
    
    // 公共容器组件
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
    }];
    
    // 标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publicContainerView.mas_top);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.height.equalTo(@(50.0));
    }];
    
    // 分割线
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(0.0);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(0.0);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(0.0);
        make.height.equalTo(@(1.0));
    }];
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.separatorLineView.mas_bottom).offset(0.0);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookSearchModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 标题
    [_titleLabel setText:_model.keyword];
    
}

#pragma mark - 触发操作事件

- (void)pressPublicContainerArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookSearchClearAllModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookSearchClearAllModel:self.model];
    }
    
}


@end
