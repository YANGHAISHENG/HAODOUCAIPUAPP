//
//  YHSCookBookDishDetailHeadTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/27.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDishDetailHeadTableViewCell.h"
#import "YHSCookBookDishModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_HEADER = @"YHSCookBookDishDetailHeadTableViewCellID";

@interface YHSCookBookDishDetailHeadTableViewCell ()

/**
 * 根容器组件
 */
@property (nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonatomic, strong) UIView *publicContainerView;

/**
 * 上部标题容器组件
 */
@property (nonatomic, strong) UIView *topContainerView;
@property (nonatomic, strong) UILabel *titleLabel; // 标题
@property (nonatomic, strong) UILabel *createTimeLabel; // 创建日期
@property (nonatomic, strong) UILabel *viewCountLabel; // 浏览
@property (nonatomic, strong) UILabel *commentCoutLabel; // 评论

/**
 * 中部容器组件
 */
@property (nonatomic, strong) UIView *middleContainerView;
@property (nonatomic, strong) UIImageView *userAvatarImageView; // 用户头像
@property (nonatomic, strong) UILabel *userNameLabel; // 用户名
@property (nonatomic, strong) UILabel *userIntroLabel; // 用户介绍
@property (nonatomic, strong) UIImageView *relationImageView; // 关注标识
@property (nonatomic, strong) UIImageView *vipImageView; // VIP标识
@property (nonatomic, strong) UIImageView *auxiliaryImageView; // 性别
@property (nonnull, nonatomic, strong) MASConstraint* auxiliaryImageViewLeftToVipImageView;
@property (nonnull, nonatomic, strong) MASConstraint* auxiliaryImageViewLeftToUserNameLabel;
@property (nonatomic, strong) UIView *userFavoriteContainerView;


/**
 * 底部容器组件
 */
@property (nonatomic, strong) UIView *bottomContainerView;
@property (strong, nonatomic) MASConstraint *bottomContainerBottomToIntrolLabel;
@property (strong, nonatomic) MASConstraint *bottomContainerBottomToIntrolButton;

@property (nonatomic, strong) UILabel *foodIntroLabel; // 菜谱的介绍说明
@property (nonatomic, strong) UIButton *btnExpandAllIntro;

@property (nonatomic, assign) CGFloat foodIntroLabelHeight;
@property (strong, nonatomic) MASConstraint *foodIntroLabelHeightConstraint; // 动态变高
@property (strong, nonatomic) NSIndexPath *indexPath;

@end



@implementation YHSCookBookDishDetailHeadTableViewCell


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
        CGFloat fontSizeTitle = 22.0;
        CGFloat fontSizeTimeViewComment = 12.0;
        
        // 容器
        self.topContainerView =[[UIView alloc] init];
        [self.topContainerView.layer setMasksToBounds:YES];
        [self.publicContainerView addSubview:self.topContainerView];

        // 标题
        self.titleLabel = [UILabel new];
        [self.titleLabel setTextColor:[UIColor blackColor]];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:fontSizeTitle]];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.topContainerView addSubview:self.titleLabel];
        
        // 创建日期
        self.createTimeLabel = [UILabel new];
        [self.createTimeLabel setTextColor:[UIColor lightGrayColor]];
        [self.createTimeLabel setFont:[UIFont systemFontOfSize:fontSizeTimeViewComment]];
        [self.createTimeLabel setTextAlignment:NSTextAlignmentLeft];
        [self.topContainerView addSubview:self.createTimeLabel];
        
        // 浏览
        self.viewCountLabel = [UILabel new];
        [self.viewCountLabel setTextColor:[UIColor lightGrayColor]];
        [self.viewCountLabel setFont:[UIFont systemFontOfSize:fontSizeTimeViewComment]];
        [self.viewCountLabel setTextAlignment:NSTextAlignmentRight];
        [self.topContainerView addSubview:self.viewCountLabel];

        // 评论
        self.commentCoutLabel = [UILabel new];
        [self.commentCoutLabel setTextColor:[UIColor lightGrayColor]];
        [self.commentCoutLabel setFont:[UIFont systemFontOfSize:fontSizeTimeViewComment]];
        [self.commentCoutLabel setTextAlignment:NSTextAlignmentRight];
        [self.topContainerView addSubview:self.commentCoutLabel];

    }
    
    // 中部容器组件
    {
        // 容器
        {
            self.middleContainerView =[[UIView alloc] init];
            [self.middleContainerView.layer setMasksToBounds:YES];
            [self.publicContainerView addSubview:self.middleContainerView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressMiddleViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [self.middleContainerView addGestureRecognizer:tapGesture];
        }

        
        // 用户头像
        self.userAvatarImageView = [UIImageView new];
        [self.userAvatarImageView.layer setMasksToBounds:YES];
        [self.userAvatarImageView setUserInteractionEnabled:YES];
        [self.middleContainerView addSubview:self.userAvatarImageView];
        
        // 用户名
        self.userNameLabel = [UILabel new];
        [self.userNameLabel setTextColor:[UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00]];
        [self.userNameLabel setFont:[UIFont systemFontOfSize:16.0]];
        [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.middleContainerView addSubview:self.userNameLabel];
        
        // 用户介绍
        self.userIntroLabel = [UILabel new];
        [self.userIntroLabel setTextColor:[UIColor lightGrayColor]];
        [self.userIntroLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.userIntroLabel setTextAlignment:NSTextAlignmentLeft];
        [self.middleContainerView addSubview:self.userIntroLabel];
        
        // VIP标识
        {
            self.vipImageView = [UIImageView new];
            [self.vipImageView.layer setMasksToBounds:YES];
            [self.vipImageView setUserInteractionEnabled:YES];
            [self.middleContainerView addSubview:self.vipImageView];
            
            self.auxiliaryImageView = [UIImageView new];
            [self.auxiliaryImageView.layer setMasksToBounds:YES];
            [self.auxiliaryImageView setUserInteractionEnabled:YES];
            [self.middleContainerView addSubview:self.auxiliaryImageView];
        }
        
        // 关注标识
        {
            self.relationImageView = [UIImageView new];
            [self.relationImageView.layer setMasksToBounds:YES];
            [self.relationImageView setUserInteractionEnabled:YES];
            [self.middleContainerView addSubview:self.relationImageView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressRelationImageViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [self.relationImageView addGestureRecognizer:tapGesture];
        }

        
        // 用户爱好
        self.userFavoriteContainerView =[[UIView alloc] init];
        [self.userFavoriteContainerView.layer setMasksToBounds:YES];
        [self.middleContainerView addSubview:self.userFavoriteContainerView];
    }
    
    // 底部容器组件
    {
        // 容器
        self.bottomContainerView =[[UIView alloc] init];
        [self.bottomContainerView.layer setMasksToBounds:YES];
        [self.publicContainerView addSubview:self.bottomContainerView];
        
        // 介绍
        {
            self.foodIntroLabel = [UILabel new];
            [self.foodIntroLabel setNumberOfLines:0];
            [self.foodIntroLabel setTextColor:[UIColor blackColor]];
            [self.foodIntroLabel setFont:[UIFont systemFontOfSize:16.0]];
            [self.foodIntroLabel setTextAlignment:NSTextAlignmentLeft];
            [self.foodIntroLabel setUserInteractionEnabled:YES];
            [self.bottomContainerView addSubview:self.foodIntroLabel];
        }

        // 全文/收起
        self.btnExpandAllIntro = [[UIButton alloc] init];
        [self.btnExpandAllIntro setTitle:@"全文" forState:UIControlStateNormal];
        [self.btnExpandAllIntro setTitleColor:[UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00] forState:UIControlStateNormal];
        [self.btnExpandAllIntro setFont:[UIFont boldSystemFontOfSize:12.0]];
        [self.btnExpandAllIntro addTarget:self action:@selector(pressToShowFoodIntroByButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomContainerView addSubview:self.btnExpandAllIntro];
    }
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10.0;
    
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
        [self.topContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
        }];
        
        // 标题
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.topContainerView.mas_top).offset(margin);
            make.left.equalTo(weakSelf.topContainerView.mas_left).offset(margin);
            make.right.equalTo(weakSelf.topContainerView.mas_right).offset(-margin);
        }];
        
        // 创建日期
        [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(margin);
            make.left.equalTo(weakSelf.topContainerView.mas_left).offset(margin);
            make.width.equalTo(weakSelf.topContainerView.mas_width).multipliedBy(4.0/10.0);
        }];
        
        // 浏览
        [self.viewCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.createTimeLabel.mas_top).offset(0.0);
            make.left.equalTo(weakSelf.createTimeLabel.mas_right).offset(0.0);
            make.width.equalTo(weakSelf.topContainerView.mas_width).multipliedBy(3.0/10.0);
        }];
        
        // 评论
        [self.commentCoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.viewCountLabel.mas_top).offset(0.0);
            make.left.equalTo(weakSelf.viewCountLabel.mas_right).offset(0.0);
            make.right.equalTo(weakSelf.topContainerView.mas_right).offset(-margin);
        }];
        
        // 约束完整性
        [self.topContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.createTimeLabel.mas_bottom).offset(margin);
        }];
    
    }

    
    // 中部容器组件
    {
        // 头像大小
        CGFloat avatarImageSize = 40.0;
        
        // 容器
        [self.middleContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.topContainerView.mas_bottom);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
        }];
        
        // 头像
        [self.userAvatarImageView.layer setCornerRadius:avatarImageSize/2.0];
        [self.userAvatarImageView.layer setMasksToBounds:YES];
        [self.userAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.middleContainerView.mas_top).offset(margin);
            make.left.equalTo(weakSelf.middleContainerView.mas_left).offset(margin);
            make.size.mas_equalTo(CGSizeMake(avatarImageSize, avatarImageSize));
        }];
        
        // 用户名
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.userAvatarImageView.mas_top).offset(0.0);
            make.left.equalTo(weakSelf.userAvatarImageView.mas_right).offset(margin);
            //make.right.equalTo(weakSelf.middleContainerView.mas_right).offset(-margin);
            make.height.equalTo(weakSelf.userAvatarImageView.mas_height).multipliedBy(1.0/2.0);
        }];
        
        // 关注标识
        {
            CGFloat relationWidth = 45.0;
            CGFloat relationHeight = 18.0;
            [self.relationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.userNameLabel.mas_top).offset((avatarImageSize/2.0-relationHeight)/2.0);
                make.left.equalTo(weakSelf.middleContainerView.mas_right).offset(-margin-relationWidth);
                make.right.equalTo(weakSelf.middleContainerView.mas_right).offset(-margin);
                make.width.equalTo(@(relationWidth));
                make.height.equalTo(@(relationHeight));
            }];
        }
        
        // 用户介绍
        [self.userIntroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.userNameLabel.mas_bottom).offset(0.0);
            make.left.equalTo(weakSelf.userAvatarImageView.mas_right).offset(margin);
            make.right.equalTo(weakSelf.relationImageView.mas_left).offset(-margin);
            make.bottom.equalTo(weakSelf.userAvatarImageView.mas_bottom);
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
            
            [self.auxiliaryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.userNameLabel.mas_top).offset((avatarImageSize/2.0-size)/2.0);
                make.left.equalTo(weakSelf.vipImageView.mas_right).offset(margin/4.0);
                make.width.equalTo(@(size));
                make.height.equalTo(@(size));
            }];
        }
        

        // VIP标识
        {
            CGFloat size = 14.0;
            
            [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.userNameLabel.mas_top).offset((avatarImageSize/2.0-size)/2.0);
                make.left.equalTo(weakSelf.userNameLabel.mas_right).offset(margin/2.0);
                make.width.equalTo(@(size));
                make.height.equalTo(@(size));
            }];
            
            [self.auxiliaryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.userNameLabel.mas_top).offset((avatarImageSize/2.0-size)/2.0);
                make.width.equalTo(@(size));
                make.height.equalTo(@(size));
                
                // 位置判断约束，因为不能同时存在，所以需要设置优先级
                self.auxiliaryImageViewLeftToVipImageView = make.left.equalTo(weakSelf.vipImageView.mas_right).offset(margin/4.0).priorityHigh();
                self.auxiliaryImageViewLeftToUserNameLabel = make.left.equalTo(weakSelf.userNameLabel.mas_right).offset(margin/2.0).priorityLow();
                [self.auxiliaryImageViewLeftToVipImageView deactivate];
                [self.auxiliaryImageViewLeftToUserNameLabel deactivate];
            }];
        }

        
        // 用户爱好
        {
            // 爱好标签主容器
            [self.userFavoriteContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.userIntroLabel.mas_bottom).offset(margin/2.0);
                make.left.equalTo(weakSelf.userAvatarImageView.mas_right).offset(margin);
                make.right.equalTo(weakSelf.middleContainerView.mas_right).offset(-margin);
            }];
        }
        
        // 约束完整性
        [self.middleContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.userFavoriteContainerView.mas_bottom).offset(0.0);
        }];
        
    }

    
    // 底部容器组件
    {
        // 容器
        [self.bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.middleContainerView.mas_bottom);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
        }];
        
        // 菜谱介绍
        {
            _foodIntroLabelHeight = 100.0;
            CGFloat preferredMaxWidth = SCREEN_WIDTH-2*margin; // 计算UILabel的preferredMaxLayoutWidth值，多行时必须设置这个值，否则系统无法决定Label的宽度
            [self.foodIntroLabel setPreferredMaxLayoutWidth:preferredMaxWidth];
            [self.foodIntroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.bottomContainerView.mas_top).offset(margin);
                make.left.equalTo(weakSelf.bottomContainerView.mas_left).offset(margin);
                make.right.equalTo(weakSelf.bottomContainerView.mas_right).offset(-margin);
                // 加上高度的限制，优先级只设置成High，比正常的高度约束低一些，防止冲突
                _foodIntroLabelHeightConstraint = make.height.lessThanOrEqualTo(@(_foodIntroLabelHeight)).with.priorityHigh();
            }];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressToShowFoodIntroByLabel:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [self.foodIntroLabel addGestureRecognizer:tapGesture];
            
        }
        
        // 全文/收起
        [self.btnExpandAllIntro mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.foodIntroLabel.mas_bottom).offset(margin/2.0);
            make.left.equalTo(weakSelf.bottomContainerView.mas_left).offset(margin/2.0);
            make.width.equalTo(@(40.0));
            make.height.equalTo(@(15.0));
        }];
        
        // 约束完整性
        [self.bottomContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            self.bottomContainerBottomToIntrolButton = make.bottom.equalTo(weakSelf.btnExpandAllIntro.mas_bottom).offset(0.0).priorityHigh();
            self.bottomContainerBottomToIntrolLabel = make.bottom.equalTo(weakSelf.btnExpandAllIntro.mas_bottom).offset(0.0).priorityLow();
            [self.bottomContainerBottomToIntrolButton deactivate];
            [self.bottomContainerBottomToIntrolLabel deactivate];
        }];
        
    }

    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bottomContainerView.mas_bottom).offset(margin);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookDishModel *)model indexPath:(NSIndexPath *)indexPath
{
    _model = model;
    
    _indexPath = indexPath;
    
    if (!_model) {
        return;
    }
    
    // 上部
    {
        // 标题
        self.titleLabel.text = model.Title;
        // 创建日期
        self.createTimeLabel.text = model.CreateTime;
        // 浏览
        self.viewCountLabel.text = [NSString stringWithFormat:@"浏览:%ld", model.ViewCount];
        // 评论
        self.commentCoutLabel.text = [NSString stringWithFormat:@"评论:%@", model.CommentCount];
    }
    
    // 中部
    {
        // 头部
        [self.userAvatarImageView sd_setImageWithURL:[NSURL URLWithString:model.UserInfo.Avatar] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        // 用户名
        self.userNameLabel.text = model.UserInfo.UserName;
        // 用户介绍
        self.userIntroLabel.text = model.UserInfo.Intro;
        // 关注
        [self.relationImageView setImage:[UIImage imageNamed:@"myhome_follow_normal"]];
        
        {
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
            CGSize size = [model.UserInfo.UserName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                             attributes:attributes
                                                                context:nil].size;
            [self.userNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(size.width));
            }];
        }
        
        // VIP标识与性别标识
        {
            // VIP标识
            [self.vipImageView setImage:[UIImage imageNamed:@"icon_vip_small"]];
            if (1 == _model.UserInfo.Vip) {
                [self.vipImageView setHidden:NO];
                [self.auxiliaryImageViewLeftToVipImageView activate];
                [self.auxiliaryImageViewLeftToUserNameLabel deactivate];
            } else {
                [self.vipImageView setHidden:YES];
                [self.auxiliaryImageViewLeftToVipImageView deactivate];
                [self.auxiliaryImageViewLeftToUserNameLabel activate];
            }
            
            // 性别
            if (0 == _model.UserInfo.Gender) { // 女
                [self.auxiliaryImageView setImage:[UIImage imageNamed:@"ico_auxiliary_female"]];
                [self.auxiliaryImageView setHidden:NO];
            } else if (1 == _model.UserInfo.Gender) { // 男
                [self.auxiliaryImageView setImage:[UIImage imageNamed:@"ico_auxiliary_male"]];
                [self.auxiliaryImageView setHidden:NO];
            } else { // 无
                [self.auxiliaryImageView setHidden:YES];
            }
            
        }
        

        
        // 标签主容器
        CGFloat margin = 10.0;
        CGFloat avatarImageSize = 40.0; // 头像大小
        if (self.model.UserInfo.FavoriteList.count > 0) {
            
            WEAKSELF(weakSelf);
            
            __block CGFloat lineMarkWidth = 0.0; // 记录一行标签宽度和
            UILabel *lastTagView = nil;
            for (int index = 0; index < self.model.UserInfo.FavoriteList.count ; index ++) {
                
                YHSCookBookDishUserInfoFavoritelistModel *favoriteModel = self.model.UserInfo.FavoriteList[index];
                
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
            [self.userFavoriteContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(lastTagView.mas_bottom).offset(0.0);
            }];
        }
        
    }
    
    
    // 底部
    {
        // 菜谱介绍
        self.foodIntroLabel.text = model.Intro;
        
        // 是否显示全文
        if (_model.isExpandedAllIntro) {
            [_foodIntroLabelHeightConstraint uninstall];
        } else {
            [_foodIntroLabelHeightConstraint install];
        }

        // 全文/收起
        {
            CGFloat maxWidth = SCREEN_WIDTH-2*10.0;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0]};
            CGSize size = [model.Intro boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                        attributes:attributes
                                                           context:nil].size;
            if (size.height <= 100) {
                [self.btnExpandAllIntro setHidden:YES];
                [self.bottomContainerBottomToIntrolButton deactivate];
                [self.bottomContainerBottomToIntrolLabel activate];
            } else {
                [self.btnExpandAllIntro setHidden:NO];
                [self.bottomContainerBottomToIntrolButton activate];
                [self.bottomContainerBottomToIntrolLabel deactivate];
            }
            
            if (!self.model.isExpandedAllIntro) {
                [self.btnExpandAllIntro setTitle:@"全文" forState:UIControlStateNormal];
            } else {
                [self.btnExpandAllIntro setTitle:@"收起" forState:UIControlStateNormal];
            }
        }

        
    }
    
    
    
}


#pragma mark - 触发操作事件

// 点击用户信息区域
- (void)pressMiddleViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookDishModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookDishModel:self.model];
    }
    
}

// 点击关注按钮
- (void)pressRelationImageViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pressRelationImageViewArea:)]) {
        [self.delegate pressRelationImageViewArea:self.model];
    }
    
}

// 点击显示菜谱介绍文字
- (void)pressToShowFoodIntroByButton:(UIButton *)button
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(didFoodIntroLabelWithCookBookDishModel:expandedAllWithIndexPath:)]) {
        [self.delegate didFoodIntroLabelWithCookBookDishModel:self.model expandedAllWithIndexPath:self.indexPath];
    }
    
}


// 点击显示菜谱介绍文字
- (void)pressToShowFoodIntroByLabel:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFoodIntroLabelWithCookBookDishModel:expandedAllWithIndexPath:)]) {
        [self.delegate didFoodIntroLabelWithCookBookDishModel:self.model expandedAllWithIndexPath:self.indexPath];
    }
    
}


@end
