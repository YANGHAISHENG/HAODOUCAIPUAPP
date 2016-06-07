//
//  YHSDynamicGroupTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/7.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSDynamicGroupTableViewCell.h"
#import "YHSDynamicGroupModel.h"


NSString * const CELL_IDENTIFIER_DYNAMIC_GROUP = @"YHSDynamicGroupTableViewCellID";

@interface YHSDynamicGroupTableViewCell ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 公共容器组件
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

// 上部组件
@property (nonnull, nonatomic, strong) UIView *upContainerView; // 上部容器组件
@property (nonnull, nonatomic, strong) UIImageView *avatarImageView; // 头像
@property (nonnull, nonatomic, strong) UILabel *userNameLabel; // 用户名称
@property (nonnull, nonatomic, strong) UILabel *introLabel; // 介绍详情
@property (nonnull, nonatomic, strong) UIImageView *relationImageView; // 关注标识
@property (nonnull, nonatomic, strong) UIImageView *vipImageView; // VIP标识
@property (nonnull, nonatomic, strong) UIImageView *genderImageView; // 性别
@property (nonnull, nonatomic, strong) MASConstraint* genderImageViewLeftToVipImageView;
@property (nonnull, nonatomic, strong) MASConstraint* genderImageViewLeftToUserNameLabel;

// 下部组件
@property (nonnull, nonatomic, strong) UIView *downContainerView; // 下部容器组件
@property (nonnull, nonatomic, strong) UILabel *sameFeatureLabel; // 概述按钮
@property (nonnull, nonatomic, strong) UIImageView *commonImageView; // 评论图片
@property (nonnull, nonatomic, strong) UILabel *commonTitleLabel; // 评论标题
@property (nonnull, nonatomic, strong) UILabel *commonDescLabel; // 评论内容

@property (nonnull, nonatomic, strong) UILabel *addressLabel; // 地址
@property (nonnull, nonatomic, strong) MASConstraint* addressTopToCommonInfoView;
@property (nonnull, nonatomic, strong) MASConstraint* addressTopToUserFavoriteContainerView;


// 分割线
@property (nonnull, nonatomic, strong) UIView *separatorLineView;

@end


@implementation YHSDynamicGroupTableViewCell


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
    self.publicContainerView =[[UIView alloc] init];
    [self.publicContainerView.layer setMasksToBounds:YES];
    [self.rootContainerView addSubview:self.publicContainerView];
    
    // 上部容器组件
    // 容器
    {
        self.upContainerView =[[UIView alloc] init];
        [self.upContainerView.layer setMasksToBounds:YES];
        [self.publicContainerView addSubview:self.upContainerView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressUpViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.upContainerView addGestureRecognizer:tapGesture];
    }
    
    // 用户头像
    self.avatarImageView = [UIImageView new];
    [self.avatarImageView.layer setMasksToBounds:YES];
    [self.avatarImageView setUserInteractionEnabled:YES];
    [self.upContainerView addSubview:self.avatarImageView];
    
    // 用户名
    self.userNameLabel = [UILabel new];
    [self.userNameLabel setUserInteractionEnabled:YES];
    [self.userNameLabel setTextColor:COLOR_NAVIGATION_BAR_TITLE_LIGHTGRAY];
    [self.userNameLabel setFont:[UIFont systemFontOfSize:16.0]];
    [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.upContainerView addSubview:self.userNameLabel];
    
    // 介绍详情
    self.introLabel = [UILabel new];
    [self.introLabel setUserInteractionEnabled:YES];
    [self.introLabel setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
    [self.introLabel setFont:[UIFont systemFontOfSize:13.0]];
    [self.introLabel setTextAlignment:NSTextAlignmentLeft];
    [self.upContainerView addSubview:self.introLabel];
    
    // VIP标识
    {
        self.vipImageView = [UIImageView new];
        [self.vipImageView.layer setMasksToBounds:YES];
        [self.vipImageView setUserInteractionEnabled:YES];
        [self.upContainerView addSubview:self.vipImageView];
        
        self.genderImageView = [UIImageView new];
        [self.genderImageView.layer setMasksToBounds:YES];
        [self.genderImageView setUserInteractionEnabled:YES];
        [self.upContainerView addSubview:self.genderImageView];
    }
    
    // 关注标识
    self.relationImageView = [UIImageView new];
    [self.relationImageView.layer setMasksToBounds:YES];
    [self.relationImageView setUserInteractionEnabled:YES];
    [self.upContainerView addSubview:self.relationImageView];
    
    
    // 分割线
    self.separatorLineView =[[UIView alloc] init];
    [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    [self.publicContainerView addSubview:self.separatorLineView];
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout {
    
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
    
    // 上部容器组件
    {
        // 容器
        [self.upContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.publicContainerView.mas_top);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
        }];
        
        // 头像
        CGFloat avatarImageSize = 40.0;
        [self.avatarImageView.layer setCornerRadius:avatarImageSize/2.0];
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.upContainerView.mas_top).offset(margin);
            make.left.equalTo(weakSelf.upContainerView.mas_left).offset(margin);
            make.size.mas_equalTo(CGSizeMake(avatarImageSize, avatarImageSize));
        }];
        
        // 用户名
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.avatarImageView.mas_top).offset(0.0);
            make.left.equalTo(weakSelf.avatarImageView.mas_right).offset(margin);
            make.height.equalTo(weakSelf.avatarImageView.mas_height).multipliedBy(1.0/2.0);
        }];
        
        // 关注标识
        {
            CGFloat relationWidth = 45.0;
            CGFloat relationHeight = 18.0;
            [self.relationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.userNameLabel.mas_top).offset((avatarImageSize/2.0-relationHeight)/2.0);
                make.left.equalTo(weakSelf.upContainerView.mas_right).offset(-margin-relationWidth);
                make.right.equalTo(weakSelf.upContainerView.mas_right).offset(-margin);
                make.width.equalTo(@(relationWidth));
                make.height.equalTo(@(relationHeight));
            }];
        }
        
        // 用户介绍
        [self.introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.userNameLabel.mas_bottom).offset(0.0);
            make.left.equalTo(weakSelf.avatarImageView.mas_right).offset(margin);
            make.right.equalTo(weakSelf.relationImageView.mas_left).offset(-margin);
            make.bottom.equalTo(weakSelf.avatarImageView.mas_bottom);
        }];
        
        // VIP标识
        {
            CGFloat size = 14.0;
            
            [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.userNameLabel.mas_top).offset((avatarImageSize/2.0-size)/2.0);
                make.left.equalTo(weakSelf.userNameLabel.mas_right).offset(margin/2.0);
                make.width.equalTo(@(size));
                make.height.equalTo(@(size));
            }];
            
            [self.genderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.userNameLabel.mas_top).offset((avatarImageSize/2.0-size)/2.0);
                make.width.equalTo(@(size));
                make.height.equalTo(@(size));
                
                // 位置判断约束，因为不能同时存在，所以需要设置优先级
                self.genderImageViewLeftToVipImageView = make.left.equalTo(weakSelf.vipImageView.mas_right).offset(margin/4.0).priorityHigh();
                self.genderImageViewLeftToUserNameLabel = make.left.equalTo(weakSelf.userNameLabel.mas_right).offset(margin/2.0).priorityLow();
                [self.genderImageViewLeftToVipImageView deactivate];
                [self.genderImageViewLeftToUserNameLabel deactivate];
            }];
        }

        
        // 约束完整性
        [self.upContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.avatarImageView.mas_bottom).offset(0.0);
            make.height.greaterThanOrEqualTo(weakSelf.avatarImageView.mas_height).offset(margin);
        }];
        
    }
    
    // 分割线
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.upContainerView.mas_bottom).offset(margin);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(0.0);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(0.0);
        make.height.equalTo(@(TABLE_FOOTER_SEPARATOR_VIEW_HEIGHT));
    }];
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.separatorLineView.mas_bottom).offset(0.0);
    }];
    
}


/**
 *  设置控件属性
 */
- (void)setModel:(YHSDynamicGroupModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    
    // 上部
    {
        // 头像
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.userInfo.Avatar] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        // 用户名称
        [self.userNameLabel setText:_model.userInfo.UserName];
        // 介绍详情
        [self.introLabel setText:_model.userInfo.Intro];
        // 关注
        [self.relationImageView setImage:[UIImage imageNamed:@"myhome_follow_normal"]];
        
        // VIP标识与性别标识
        {
            // VIP标识
            [self.vipImageView setImage:[UIImage imageNamed:@"icon_vip_small"]];
            if (1 == _model.userInfo.Vip) {
                [self.vipImageView setHidden:NO];
                [self.genderImageViewLeftToVipImageView activate];
                [self.genderImageViewLeftToUserNameLabel deactivate];
            } else {
                [self.vipImageView setHidden:YES];
                [self.genderImageViewLeftToVipImageView deactivate];
                [self.genderImageViewLeftToUserNameLabel activate];
            }
            
            // 性别
            if (0 == _model.userInfo.Gender) { // 女
                [self.genderImageView setImage:[UIImage imageNamed:@"ico_auxiliary_female"]];
                [self.genderImageView setHidden:NO];
            } else if (1 == _model.userInfo.Gender) { // 男
                [self.genderImageView setImage:[UIImage imageNamed:@"ico_auxiliary_male"]];
                [self.genderImageView setHidden:NO];
            } else { // 无
                [self.genderImageView setHidden:YES];
            }
            
        }
        
    } // 上部

    
}


#pragma mark - 触发操作事件

// 点击上部用户详情容器
- (void)pressUpViewArea:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithDynamicGroupModel:)]) {
        [self.delegate didClickElementOfCellWithDynamicGroupModel:self.model];
    }
}



@end
