//
//  YHSCookBookCommentInfoTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookCommentInfoTableViewCell.h"
#import "YHSCookBookCommentModel.h"

NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_COMMENT = @"YHSCookBookCommentInfoTableViewCellID";


@interface YHSCookBookCommentInfoTableViewCell ()

/**
 * 根容器组件
 */
@property (nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonatomic, strong) UIView *publicContainerView;

/**
 * 头像
 */
@property (nonatomic, strong) UIImageView *avatarImageView;

/**
 * 用户名
 */
@property (nonnull, nonatomic, strong) UILabel *userNameLabel;

/**
 * 回复
 */
@property (nonnull, nonatomic, strong) UILabel *replayCommentLabel;

/**
 * 创建时间
 */
@property (nonatomic, strong) UILabel *createTimeLabel;

/**
 * 评论内容
 */
@property (nonatomic, strong) UILabel *contentLabel;

/**
 * 评论图片
 */
@property (nonatomic, strong) UIImageView *contentImageView;

/**
 * 回复容器组件
 */
@property (nonatomic, strong) UIView *atContainerView;
@property (nonnull, nonatomic, strong)MASConstraint* atContainerViewTopToContentImage;
@property (nonnull, nonatomic, strong)MASConstraint* atContainerViewTopToContentLabel;
@property (nonnull, nonatomic, strong)MASConstraint* atContainerViewBottomToAtContentImage;
@property (nonnull, nonatomic, strong)MASConstraint* atContainerViewBottomToAtContentLabel;

/**
 * 回复用户
 */
@property (nonnull, nonatomic, strong) UILabel *atUserNameLabel;

/**
 * 回复内容
 */
@property (nonatomic, strong) UILabel *atContentLabel;

/**
 * 回复图片
 */
@property (nonatomic, strong) UIImageView *atContentImageView;

/**
 * 分割线
 */
@property (nonnull, nonatomic, strong) UIView *separatorLineView;
@property (nonnull, nonatomic, strong)MASConstraint* separatorLineTopToAtContentView;
@property (nonnull, nonatomic, strong)MASConstraint* separatorLineTopToContentImageLabel;
@property (nonnull, nonatomic, strong)MASConstraint* separatorLineTopToContentLabel;

@end



@implementation YHSCookBookCommentInfoTableViewCell

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
    
    // 头像
    {
        self.avatarImageView = [[UIImageView alloc] init];
        [self.avatarImageView setUserInteractionEnabled:YES];
        [self.avatarImageView.layer setMasksToBounds:YES];
        [self.publicContainerView addSubview:self.avatarImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressReplayCommentViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.publicContainerView addGestureRecognizer:tapGesture];
    }
    
    // 回复
    {
        self.replayCommentLabel = [UILabel new];
        [self.replayCommentLabel setNumberOfLines:1];
        [self.replayCommentLabel setTextColor:[UIColor lightGrayColor]];
        [self.replayCommentLabel setFont:[UIFont systemFontOfSize:14]];
        [self.replayCommentLabel setTextAlignment:NSTextAlignmentLeft];
        [self.replayCommentLabel setUserInteractionEnabled:YES];
        [self.publicContainerView addSubview:self.replayCommentLabel];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressReplayCommentViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.replayCommentLabel addGestureRecognizer:tapGesture];
    }
    
    // 用户名
    self.userNameLabel = [UILabel new];
    [self.userNameLabel setNumberOfLines:1];
    [self.userNameLabel setTextColor:[UIColor blackColor]];
    [self.userNameLabel setFont:[UIFont systemFontOfSize:16]];
    [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.userNameLabel];
    
    // 创建时间
    self.createTimeLabel = [UILabel new];
    [self.createTimeLabel setNumberOfLines:1];
    [self.createTimeLabel setTextColor:[UIColor lightGrayColor]];
    [self.createTimeLabel setFont:[UIFont systemFontOfSize:13]];
    [self.createTimeLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.createTimeLabel];
    
    // 评论内容
    self.contentLabel = [UILabel new];
    [self.contentLabel setNumberOfLines:0];
    [self.contentLabel setTextColor:[UIColor blackColor]];
    [self.contentLabel setFont:[UIFont systemFontOfSize:16]];
    [self.contentLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.contentLabel];
    
    // 评论图片
    self.contentImageView = [[UIImageView alloc] init];
    [self.contentImageView.layer setMasksToBounds:YES];
    [self.contentImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.publicContainerView addSubview:self.contentImageView];
    
    // 回复容器
    self.atContainerView =[[UIView alloc] init];
    [self.atContainerView.layer setMasksToBounds:YES];
    [self.atContainerView.layer setCornerRadius:5.0];
    [self.atContainerView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.94 blue:0.97 alpha:1.00]];
    [self.publicContainerView addSubview:self.atContainerView];
    
    // 回复用户名
    self.atUserNameLabel = [UILabel new];
    [self.atUserNameLabel setNumberOfLines:1];
    [self.atUserNameLabel setTextColor:[UIColor lightGrayColor]];
    [self.atUserNameLabel setFont:[UIFont systemFontOfSize:14]];
    [self.atUserNameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.atContainerView addSubview:self.atUserNameLabel];

    // 回复内容
    self.atContentLabel = [UILabel new];
    [self.atContentLabel setNumberOfLines:0];
    [self.atContentLabel setTextColor:[UIColor lightGrayColor]];
    [self.atContentLabel setFont:[UIFont systemFontOfSize:14]];
    [self.atContentLabel setTextAlignment:NSTextAlignmentLeft];
    [self.atContainerView addSubview:self.atContentLabel];
    
    // 回复图片
    self.atContentImageView = [[UIImageView alloc] init];
    [self.atContentImageView.layer setMasksToBounds:YES];
    [self.atContentImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.atContainerView addSubview:self.atContentImageView];
    
    // 分割线
    self.separatorLineView =[[UIView alloc] init];
    [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    [self.publicContainerView addSubview:self.separatorLineView];
    
}


#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    CGFloat margin  =10.0;
    
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
    
    
    {
        // 头像
        CGFloat avatarSize = 40.0;
        [self.avatarImageView.layer setCornerRadius:avatarSize/2.0];
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(margin));
            make.left.equalTo(@(margin));
            make.size.mas_equalTo(CGSizeMake(avatarSize, avatarSize));
        }];
        
        // 回复
        [self.replayCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.userNameLabel.mas_centerY);
            make.left.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin-30.0);
            make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        }];
        
        // 用户名
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.avatarImageView.mas_top);
            make.left.equalTo(weakSelf.avatarImageView.mas_right).offset(margin);
            make.right.equalTo(weakSelf.replayCommentLabel.mas_left).offset(-margin);
            make.height.equalTo(weakSelf.avatarImageView.mas_height).multipliedBy(1.0/2.0);
        }];
        
        // 创建时间
        [self.createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.userNameLabel.mas_bottom);
            make.left.equalTo(weakSelf.avatarImageView.mas_right).offset(margin);
            make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
            make.bottom.equalTo(weakSelf.avatarImageView.mas_bottom);
        }];
        
        // 评论内容
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.createTimeLabel.mas_bottom).offset(margin);
            make.left.equalTo(weakSelf.avatarImageView.mas_right).offset(margin);
            make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        }];
        
        // 评论图片
        [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLabel.mas_bottom).offset(margin);
            make.left.equalTo(weakSelf.avatarImageView.mas_right).offset(margin);
            make.width.equalTo(weakSelf.publicContainerView.mas_width).multipliedBy(1.0/2.0);
            make.height.lessThanOrEqualTo(@(100));
        }];
        
    }

    {
        // 回复容器
        [self.atContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.avatarImageView.mas_right).offset(margin);
            make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);

            // 位置判断约束 因为不能同时存在 所以需要设置优先级
            self.atContainerViewTopToContentImage = make.top.equalTo(self.contentImageView.mas_bottom).offset(margin).priorityHigh();
            self.atContainerViewTopToContentLabel = make.top.equalTo(self.contentLabel.mas_bottom).offset(margin).priorityLow();
            [self.atContainerViewTopToContentImage deactivate];
            [self.atContainerViewTopToContentLabel deactivate];
        }];
        
        
        // 回复用户名
        [self.atUserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.atContainerView.mas_top).offset(margin);
            make.left.equalTo(weakSelf.atContainerView.mas_left).offset(margin);
            make.right.equalTo(weakSelf.atContainerView.mas_right).offset(-margin);
        }];

        // 回复评论内容
        [self.atContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.atUserNameLabel.mas_bottom).offset(margin/2.0);
            make.left.equalTo(weakSelf.atContainerView.mas_left).offset(margin);
            make.right.equalTo(weakSelf.atContainerView.mas_right).offset(-margin);
        }];
        
        // 回复图片
        [self.atContentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.atContentLabel.mas_bottom).offset(margin/2.0);
            make.left.equalTo(weakSelf.atContainerView.mas_left).offset(margin);
            make.size.mas_equalTo(CGSizeMake(120, 80));
        }];
        
        // 回复容器
        [self.atContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            // 位置判断约束 因为不能同时存在 所以需要设置优先级
            self.atContainerViewBottomToAtContentImage = make.bottom.equalTo(self.atContentImageView.mas_bottom).offset(margin).priorityHigh();
            self.atContainerViewBottomToAtContentLabel = make.bottom.equalTo(self.atContentLabel.mas_bottom).offset(margin).priorityLow();
            [self.atContainerViewBottomToAtContentImage deactivate];
            [self.atContainerViewBottomToAtContentLabel deactivate];
            
        }];
    }
    
    {
        // 分割线
        [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(0.0);
            make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(0.0);
            make.height.equalTo(@(1.0));
            
            // 位置判断约束 因为不能同时存在 所以需要设置优先级
            self.separatorLineTopToAtContentView = make.top.equalTo(self.atContainerView.mas_bottom).offset(margin).priorityHigh();
            self.separatorLineTopToContentImageLabel = make.top.equalTo(self.contentImageView.mas_bottom).offset(margin).priorityMedium();
            self.separatorLineTopToContentLabel = make.top.equalTo(self.contentLabel.mas_bottom).offset(margin).priorityLow();
            [self.separatorLineTopToAtContentView deactivate];
            [self.separatorLineTopToContentImageLabel deactivate];
            [self.separatorLineTopToContentLabel deactivate];
        }];
        
        // 约束的完整性
        [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.separatorLineView.mas_bottom).offset(0.0);
        }];
    }

}


/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookCommentModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 图片
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.Avatar] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 回复
    [self.replayCommentLabel setText:@"回复"];
    
    // 用户名
    [self.userNameLabel setText:_model.UserName];
    
    // 创建时间
    [self.createTimeLabel setText:_model.CreateTime];
    
    // 评论内容
    [self.contentLabel setText:_model.Content];
    
    // 评论图片
    if (_model.ImageUrl.length <= 0) {
        [self.contentImageView setImage:nil];
    } else {
        [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:_model.ImageUrl] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    }
    
    // 回复内容
    [self.atContentLabel setText:_model.AtContent];
    
    // 回复评论图片
    if (_model.AtImageUrl.length <= 0) {
        [self.atContentImageView setImage:nil];
    } else {
        [self.atContentImageView sd_setImageWithURL:[NSURL URLWithString:_model.AtImageUrl] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    }

    // 分割线
    if (_model.AtContent.length <= 0) {
        [self.separatorLineTopToAtContentView deactivate];
        
        if (_model.ImageUrl.length <= 0) {
            [self.separatorLineTopToContentLabel activate];
            [self.separatorLineTopToContentImageLabel deactivate];
        } else {
            [self.separatorLineTopToContentLabel deactivate];
            [self.separatorLineTopToContentImageLabel activate];
        }
        
        // 隐藏回复容器
        [self.atContainerView setHidden:YES];
        
        // 回复用户名
        [self.atUserNameLabel setText:_model.AtUserName];
    } else {
        [self.separatorLineTopToAtContentView activate];
        [self.separatorLineTopToContentLabel deactivate];
        [self.separatorLineTopToContentImageLabel deactivate];

        if (_model.ImageUrl.length <= 0) {
            [self.atContainerViewTopToContentLabel activate];
            [self.atContainerViewTopToContentImage deactivate];
        } else {
            [self.atContainerViewTopToContentLabel deactivate];
            [self.atContainerViewTopToContentImage activate];
        }

        if (_model.AtImageUrl.length <= 0) {
            [self.atContainerViewBottomToAtContentLabel activate];
            [self.atContainerViewBottomToAtContentImage deactivate];
        } else {
            [self.atContainerViewBottomToAtContentLabel deactivate];
            [self.atContainerViewBottomToAtContentImage activate];
        }
        
        // 显示回复容器
        [self.atContainerView setHidden:NO];
        
        // 回复用户名
        [self.atUserNameLabel setText:[NSString stringWithFormat:@"回复:%@", _model.AtUserName]];
        
    }
    
    
}

#pragma mark - 触发操作事件

- (void)pressReplayCommentViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCommentModel:)]) {
        [self.delegate didClickElementOfCellWithCommentModel:self.model];
    }
    
}



@end
