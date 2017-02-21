//
//  YHSTopicGroupHotTitleTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSTopicGroupHotTitleTableViewCell.h"
#import "YHSTopicGroupHotTitleModel.h"


NSString * const CELL_IDENTIFIER_TOPIC_GROUP_HOTTITLE = @"YHSTopicGroupHotTitleTableViewCellID";

@interface YHSTopicGroupHotTitleTableViewCell ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 公共容器组件
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

// 图片
@property (nonnull, nonatomic, strong) UIImageView *photoImageView;

// 标题
@property (nonnull, nonatomic, strong) UILabel *titleLabel;

// 头像
@property (nonnull, nonatomic, strong) UIImageView *avatarImageView;

// 用户名
@property (nonnull, nonatomic, strong) UILabel *userNameLabel;

// 内容详情
@property (nonnull, nonatomic, strong) UILabel *previewContentLabel;

// 赞
@property (nonnull, nonatomic, strong) UIImageView *digImageView;
@property (nonnull, nonatomic, strong) UILabel *digCountLabel;

// 评论
@property (nonnull, nonatomic, strong) UIImageView *commentImageView;
@property (nonnull, nonatomic, strong) UILabel *commentCountLabel;

// 分割线
@property (nonnull, nonatomic, strong) UIView *separatorLineView;


@end

@implementation YHSTopicGroupHotTitleTableViewCell

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
    self.photoImageView = [UIImageView new];
    [self.photoImageView.layer setMasksToBounds:YES];
    [self.photoImageView setUserInteractionEnabled:YES];
    [self.publicContainerView addSubview:self.photoImageView];
    
    // 标题
    self.titleLabel = [UILabel new];
    [self.titleLabel setUserInteractionEnabled:YES];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.titleLabel];
    
    // 头像
    self.avatarImageView = [UIImageView new];
    [self.avatarImageView.layer setMasksToBounds:YES];
    [self.avatarImageView setUserInteractionEnabled:YES];
    [self.publicContainerView addSubview:self.avatarImageView];
    
    // 用户名
    self.userNameLabel = [UILabel new];
    [self.userNameLabel setUserInteractionEnabled:YES];
    [self.userNameLabel setTextColor:[UIColor blackColor]];
    [self.userNameLabel setFont:[UIFont systemFontOfSize:10]];
    [self.publicContainerView addSubview:self.userNameLabel];
    
    // 内容详情
    self.previewContentLabel = [UILabel new];
    [self.previewContentLabel setNumberOfLines:0];
    [self.previewContentLabel setUserInteractionEnabled:YES];
    [self.previewContentLabel setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
    [self.previewContentLabel setFont:[UIFont systemFontOfSize:14]];
    [self.publicContainerView addSubview:self.previewContentLabel];
    
    // 赞
    {
        self.digImageView = [UIImageView new];
        [self.digImageView.layer setMasksToBounds:YES];
        [self.digImageView setUserInteractionEnabled:YES];
        [self.publicContainerView addSubview:self.digImageView];
        
        self.digCountLabel = [UILabel new];
        [self.digCountLabel setUserInteractionEnabled:YES];
        [self.digCountLabel setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
        [self.digCountLabel setFont:[UIFont systemFontOfSize:13]];
        [self.publicContainerView addSubview:self.digCountLabel];
    }

    
    // 评论
    {
        self.commentImageView = [UIImageView new];
        [self.commentImageView.layer setMasksToBounds:YES];
        [self.commentImageView setUserInteractionEnabled:YES];
        [self.publicContainerView addSubview:self.commentImageView];
        
        self.commentCountLabel = [UILabel new];
        [self.commentCountLabel setUserInteractionEnabled:YES];
        [self.commentCountLabel setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
        [self.commentCountLabel setFont:[UIFont systemFontOfSize:13]];
        [self.publicContainerView addSubview:self.commentCountLabel];
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
    CGFloat photoImageSize = 100.0;
    CGFloat avatarImageSize = photoImageSize / 5.0;
    CGFloat digCommentImageSize = 16.0;
    
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
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(margin);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
        make.width.equalTo(@(photoImageSize));
        make.height.equalTo(@(photoImageSize));
    }];
    
    // 标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.photoImageView.mas_top);
        make.left.equalTo(weakSelf.photoImageView.mas_right).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.height.equalTo(weakSelf.photoImageView.mas_height).multipliedBy(1.0/5.0);
    }];
    
    // 头像
    CGFloat avatarMargin = 2.0;
    [self.avatarImageView.layer setMasksToBounds:YES];
    [self.avatarImageView.layer setCornerRadius:avatarImageSize/2.0];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(avatarMargin);
        make.left.equalTo(weakSelf.photoImageView.mas_right).offset(margin);
        make.size.mas_equalTo(CGSizeMake(avatarImageSize-avatarMargin, avatarImageSize-avatarMargin));
    }];
    
    // 用户名
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.avatarImageView.mas_top);
        make.left.equalTo(weakSelf.avatarImageView.mas_right).offset(margin/2.0);
        make.bottom.equalTo(weakSelf.avatarImageView.mas_bottom);
    }];
    
    // 内容详情
    [self.previewContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userNameLabel.mas_bottom).offset(margin/3.0);
        make.left.equalTo(weakSelf.photoImageView.mas_right).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.height.equalTo(weakSelf.photoImageView.mas_height).multipliedBy(2.0/5.0);
    }];
    
    // 赞
    {
        [self.digImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.previewContentLabel.mas_bottom);
            make.left.equalTo(weakSelf.photoImageView.mas_right).offset(margin);
            make.bottom.equalTo(weakSelf.photoImageView.mas_bottom);
            make.width.equalTo(@(digCommentImageSize));
        }];
        
        [self.digCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.previewContentLabel.mas_bottom).offset(2.0);
            make.left.equalTo(weakSelf.digImageView.mas_right).offset(margin/2.0);
            make.bottom.equalTo(weakSelf.photoImageView.mas_bottom);
        }];
    }
    
    // 评论
    {
        [self.commentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.previewContentLabel.mas_bottom);
            make.left.equalTo(weakSelf.digCountLabel.mas_right).offset(2*margin);
            make.bottom.equalTo(weakSelf.photoImageView.mas_bottom);
            make.width.equalTo(@(digCommentImageSize));
        }];
        
        [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.previewContentLabel.mas_bottom).offset(2.0);
            make.left.equalTo(weakSelf.commentImageView.mas_right).offset(margin/2.0);
            make.bottom.equalTo(weakSelf.photoImageView.mas_bottom);
        }];
    }
    
    // 分割线
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.photoImageView.mas_bottom).offset(margin);
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
- (void)setModel:(YHSTopicGroupHotTitleModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 图片
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:_model.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];

    // 标题
    [self.titleLabel setText:_model.Title];
    
    // 头像
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.Avatar] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 用户名
    [self.userNameLabel setText:_model.UserName];
    
    // 用户VIP标识
    {
        // 先删除再创建
        UIImageView *vipImageView = [self.publicContainerView viewWithTag:2000];
        if (vipImageView) {
            [vipImageView removeFromSuperview];
            vipImageView = nil;
        }
        vipImageView = [UIImageView new];
        [vipImageView setTag:2000];
        [vipImageView.layer setMasksToBounds:YES];
        [vipImageView setUserInteractionEnabled:YES];
        [vipImageView setImage:[UIImage imageNamed:@"icon_vip_small"]];
        [self.publicContainerView addSubview:vipImageView];
        
        WEAKSELF(weakSelf);
        CGFloat margin  =10.0;
        [vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.userNameLabel.mas_centerY);
            make.left.equalTo(weakSelf.userNameLabel.mas_right).offset(margin);
            make.width.equalTo(weakSelf.userNameLabel.mas_height).multipliedBy(4.0/5.0);
            make.height.equalTo(weakSelf.userNameLabel.mas_height).multipliedBy(4.0/5.0);
        }];
    }
    
    // 内容详情
    [self.previewContentLabel setText:_model.PreviewContent];
    
    // 点赞
    {
        [self.digImageView setImage:[UIImage imageNamed:@"ico_weaken_good"]];
        
        [self.digCountLabel setText:[NSString stringWithFormat:@"%ld", _model.DigCount]];
    }
    
    // 评论
    {
        [self.commentImageView setImage:[UIImage imageNamed:@"ico_weaken_comment"]];
        
        [self.commentCountLabel setText:[NSString stringWithFormat:@"%ld", _model.CommentCount]];
    }
    
}


#pragma mark - 触发操作事件

- (void)pressPublicContainerArea:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithTopicGroupHotTitleModel:)]) {
        [self.delegate didClickElementOfCellWithTopicGroupHotTitleModel:self.model];
    }
}

@end
