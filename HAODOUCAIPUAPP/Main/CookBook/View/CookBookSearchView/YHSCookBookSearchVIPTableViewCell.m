//
//  YHSCookBookSearchVIPTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookSearchVIPTableViewCell.h"
#import "YHSCookBookSearchVIPModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_SEARCH_VIP = @"YHSCookBookSearchVIPTableViewCellID";

@interface YHSCookBookSearchVIPTableViewCell ()

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 图片
 */
@property (nonnull, nonatomic, strong) UIImageView *avatarImageView;

/**
 * 标题
 */
@property (nonnull, nonatomic, strong) UILabel *userNameLabel;

/**
 * 关注
 */
@property (nonnull, nonatomic, strong) UIImageView *relationImageView;

/**
 * 分割线
 */
@property (nonnull, nonatomic, strong) UIView *separatorLineView;

@end


@implementation YHSCookBookSearchVIPTableViewCell

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
    
    
    // 图片
    self.avatarImageView = [UIImageView new];
    [self.avatarImageView.layer setMasksToBounds:YES];
    [self.avatarImageView setUserInteractionEnabled:YES];
    [self.publicContainerView addSubview:self.avatarImageView];
    
    // 标题
    self.userNameLabel = [UILabel new];
    [self.userNameLabel setUserInteractionEnabled:YES];
    [self.userNameLabel setTextColor:[UIColor blackColor]];
    [self.userNameLabel setFont:[UIFont systemFontOfSize:18]];
    [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.userNameLabel];
    
    // 关注
    {
        self.relationImageView = [UIImageView new];
        [self.relationImageView.layer setMasksToBounds:YES];
        [self.relationImageView setUserInteractionEnabled:YES];
        [self.publicContainerView addSubview:self.relationImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressRelationArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.relationImageView addGestureRecognizer:tapGesture];
    }

    
    // 分割线
    self.separatorLineView =[[UIView alloc] init];
    [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    [self.rootContainerView addSubview:self.separatorLineView];
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10.0;
    CGFloat avatorSize = 60.0;
    CGFloat relationWidth = 50.0;
    CGFloat relationHeight = 22.0;
    
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
    
    // 图片
    [self.avatarImageView.layer setCornerRadius:avatorSize/2.0];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(margin);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
        make.width.equalTo(@(avatorSize));
        make.height.equalTo(@(avatorSize));
    }];
    
    // 标题
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.avatarImageView.mas_top);
        make.left.equalTo(weakSelf.avatarImageView.mas_right).offset(margin);
        make.bottom.equalTo(weakSelf.avatarImageView.mas_bottom);
    }];
    
    // 关注
    [self.relationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.avatarImageView.mas_centerY);
        make.left.equalTo(weakSelf.userNameLabel.mas_right).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-1.5*margin);
        make.size.mas_equalTo(CGSizeMake(relationWidth, relationHeight));
    }];
    
    // 分割线
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.avatarImageView.mas_bottom).offset(margin);
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
- (void)setModel:(YHSCookBookSearchVIPModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 图片
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.Avatar] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 标题
    [_userNameLabel setText:_model.UserName];
    
    // 关注
    if (0 == model.Relation) {
        [_relationImageView setImage:[UIImage imageNamed:@"myhome_follow_normal"]];
    } else {
        [_relationImageView setImage:[UIImage imageNamed:@"myhome_followed_normal"]];
    }
    
}

#pragma mark - 触发操作事件

- (void)pressPublicContainerArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookSearchVIPModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookSearchVIPModel:self.model];
    }
    
}

- (void)pressRelationArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookSearchVIPRelationModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookSearchVIPRelationModel:self.model];
    }
 
}




@end
