//
//  YHSFriendGroupTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSFriendGroupTableViewCell.h"
#import "YHSFriendGroupModel.h"


NSString * const CELL_IDENTIFIER_FRIEND_GROUP = @"YHSFriendGroupTableViewCellID";

@interface YHSFriendGroupTableViewCell ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 公共容器组件
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

// 上部组件
@property (nonnull, nonatomic, strong) UIView *upContainerView;
@property (nonnull, nonatomic, strong) UIImageView *avatarImageView; // 头像
@property (nonnull, nonatomic, strong) UILabel *userNameLabel; // 用户名称
@property (nonnull, nonatomic, strong) UILabel *introLabel; // 介绍详情
@property (nonnull, nonatomic, strong) UIImageView *relationImageView; // 关注标识
@property (nonnull, nonatomic, strong) UIImageView *vipImageView; // VIP标识

@property (nonnull, nonatomic, strong) UIImageView *genderImageView; // 性别
@property (nonnull, nonatomic, strong) MASConstraint* genderImageViewLeftToVipImageView;
@property (nonnull, nonatomic, strong) MASConstraint* genderImageViewLeftToUserNameLabel;

@property (nonnull, nonatomic, strong) UIView *userFavoriteContainerView; // 爱好标签
@property (nonnull, nonatomic, strong) MASConstraint* userFavoriteContainerTopToIntroLabel;
@property (nonnull, nonatomic, strong) MASConstraint* userFavoriteContainerTopToUserNameLabel;
@property (nonnull, nonatomic, strong) MASConstraint* userFavoriteContainerBottomToLastMarkLabel;
@property (nonnull, nonatomic, strong) MASConstraint* userFavoriteContainerBottomToIntroLabel;

// 分割线
@property (nonnull, nonatomic, strong) UIView *separatorLineView;

@end


@implementation YHSFriendGroupTableViewCell

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
    {
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
        {
            self.relationImageView = [UIImageView new];
            [self.relationImageView.layer setMasksToBounds:YES];
            [self.relationImageView setUserInteractionEnabled:YES];
            [self.upContainerView addSubview:self.relationImageView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressRelationImageViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [self.relationImageView addGestureRecognizer:tapGesture];
        }
        
        // 用户爱好
        self.userFavoriteContainerView =[[UIView alloc] init];
        [self.userFavoriteContainerView.layer setMasksToBounds:YES];
        [self.upContainerView addSubview:self.userFavoriteContainerView];
    }

    

    
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
        
        // 用户爱好
        {
            // 爱好标签主容器
            [self.userFavoriteContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.avatarImageView.mas_right).offset(margin);
                make.right.equalTo(weakSelf.upContainerView.mas_right).offset(-margin);
                
                // 位置判断约束，因为不能同时存在，所以需要设置优先级
                self.userFavoriteContainerTopToIntroLabel = make.top.equalTo(weakSelf.introLabel.mas_bottom).offset(margin/2.0).priorityHigh();
                self.userFavoriteContainerTopToUserNameLabel = make.top.equalTo(weakSelf.userNameLabel.mas_bottom).offset(margin/2.0).priorityLow();
                [self.userFavoriteContainerTopToIntroLabel deactivate];
                [self.userFavoriteContainerTopToUserNameLabel deactivate];
                
                // 底部
                self.userFavoriteContainerBottomToIntroLabel = make.bottom.equalTo(weakSelf.userNameLabel.mas_bottom).offset(0.0).priorityLow();
                [self.userFavoriteContainerBottomToIntroLabel deactivate];
            }];
        }
        
        // 约束完整性
        [self.upContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.userFavoriteContainerView.mas_bottom).offset(0.0);
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
- (void)setModel:(YHSFriendGroupModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    
    // 上部
    {
        // 头像
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.Avatar] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        // 用户名称
        [self.userNameLabel setText:_model.UserName];
        // 介绍详情
        [self.introLabel setText:_model.Intro];
        // 关注
        [self.relationImageView setImage:[UIImage imageNamed:@"myhome_follow_normal"]];
        
        // VIP标识与性别标识
        {
            // VIP标识
            [self.vipImageView setImage:[UIImage imageNamed:@"icon_vip_small"]];
            if (1 == _model.Vip) {
                [self.vipImageView setHidden:NO];
                [self.genderImageViewLeftToVipImageView activate];
                [self.genderImageViewLeftToUserNameLabel deactivate];
            } else {
                [self.vipImageView setHidden:YES];
                [self.genderImageViewLeftToVipImageView deactivate];
                [self.genderImageViewLeftToUserNameLabel activate];
            }
            
            // 性别
            if (0 == _model.Gender) { // 女
                [self.genderImageView setImage:[UIImage imageNamed:@"ico_auxiliary_female"]];
                [self.genderImageView setHidden:NO];
            } else if (1 == _model.Gender) { // 男
                [self.genderImageView setImage:[UIImage imageNamed:@"ico_auxiliary_male"]];
                [self.genderImageView setHidden:NO];
            } else { // 无
                [self.genderImageView setHidden:YES];
            }
            
        }
        
        
        // 标签主容器
        {
            // 是否有介绍信息
            if (_model.Intro.length > 0) {
                [self.userFavoriteContainerTopToIntroLabel activate];
                [self.userFavoriteContainerTopToUserNameLabel deactivate];
            } else {
                [self.userFavoriteContainerTopToIntroLabel deactivate];
                [self.userFavoriteContainerTopToUserNameLabel activate];
            }
            
            // 先删除
            for (UIView *view in self.userFavoriteContainerView.subviews) {
                [view removeFromSuperview];
            }
            
            CGFloat margin = 10.0;
            CGFloat avatarImageSize = 40.0; // 头像大小
            if (self.model.FavoriteList.count > 0) {
                
                WEAKSELF(weakSelf);
                
                __block CGFloat lineMarkWidth = 0.0; // 记录一行标签宽度和
                UILabel *lastTagView = nil;
                for (int index = 0; index < self.model.FavoriteList.count ; index ++) {
                    
                    YHSFriendGroupFavoriteElemModel *favoriteModel = self.model.FavoriteList[index];
                    
                    // 标签背景图片
                    UIImageView *tagImageView = ({
                        UIImageView *imageView = [UIImageView new];
                        [imageView setImage:[UIImage imageNamed:@"bg_tag_recipe.9"]];
                        [self.userFavoriteContainerView addSubview:imageView];
                        
                        imageView;
                    });
                    
                    // 标签文字
                    UILabel *tagMark = ({
                        UILabel *mark = [[UILabel alloc] init];
                        [mark setText:favoriteModel.Name];
                        [mark setUserInteractionEnabled:YES];
                        [mark setTextAlignment:NSTextAlignmentRight];
                        [mark setFont:[UIFont systemFontOfSize:12.0]];
                        [tagImageView addSubview:mark];
                        
                        mark;
                    });
                    
                    
                    // 标签宽度
                    CGFloat markWidth = 18.0;
                    CGFloat markHeight = 20.0;
                    NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]};
                    CGSize size = [favoriteModel.Name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                attributes:attributes
                                                                   context:nil].size;
                    markWidth += size.width;
                    
                    // 计算一行标签宽度和
                    lineMarkWidth += markWidth + margin;
                    
                    // 标签位置
                    [tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.width.equalTo(@(markWidth));
                        make.height.equalTo(@(markHeight));
                        
                        if (lineMarkWidth < self.frame.size.width - avatarImageSize - margin) {
                            
                            if (lastTagView) {
                                make.top.equalTo(lastTagView.mas_top).offset(0.0);
                                make.left.equalTo(lastTagView.mas_right).offset(margin);
                            } else {
                                make.top.equalTo(weakSelf.userFavoriteContainerView.mas_top).offset(0.0);
                                make.left.equalTo(weakSelf.userFavoriteContainerView).offset(0.0);
                            }
                            
                        } else {
                            
                            lineMarkWidth = markWidth + margin; // 重围行标签宽度之和
                            
                            if (lastTagView) {
                                make.top.equalTo(lastTagView.mas_bottom).offset(margin/2.0);
                                make.left.equalTo(weakSelf.userFavoriteContainerView).offset(0.0);
                            } else {
                                make.top.equalTo(weakSelf.userFavoriteContainerView.mas_top).offset(0.0);
                                make.left.equalTo(weakSelf.userFavoriteContainerView).offset(0.0);
                            }
                            
                        }
                        
                    }];
                    
                    [tagMark mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(tagImageView.mas_top).offset(0.0);
                        make.left.equalTo(tagImageView.mas_left).offset(0.0);
                        make.bottom.equalTo(tagImageView.mas_bottom).offset(0.0);
                        make.right.equalTo(tagImageView.mas_right).offset(-margin/2.0);
                    }];
                    
                    // 记录上一个分类标签
                    lastTagView = tagMark;
                }
                
                // 约束的完整性
                [self.userFavoriteContainerBottomToIntroLabel deactivate];
                [self.userFavoriteContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
                    self.userFavoriteContainerBottomToLastMarkLabel = make.bottom.equalTo(lastTagView.mas_bottom).offset(0.0).priorityHigh();
                    [self.userFavoriteContainerBottomToLastMarkLabel deactivate];
                }];
                
            } else {
                [self.userFavoriteContainerBottomToLastMarkLabel deactivate];
                [self.userFavoriteContainerBottomToIntroLabel activate];
            }
            
        } // 标签主容器
        
    } // 上部
        
    
}


#pragma mark - 触发操作事件

- (void)pressUpViewArea:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellUserInfoWithFriendGroupModel:)]) {
        [self.delegate didClickElementOfCellUserInfoWithFriendGroupModel:self.model];
    }
}

- (void)pressRelationImageViewArea:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellRelationWithFriendGroupModel:)]) {
        [self.delegate didClickElementOfCellRelationWithFriendGroupModel:self.model];
    }
}



@end
