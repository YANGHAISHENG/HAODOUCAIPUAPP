//
//  YHSTopicGroupGroupTitleTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSTopicGroupGroupTitleTableViewCell.h"
#import "YHSTopicGroupGroupTitleModel.h"


NSString * const CELL_IDENTIFIER_TOPIC_GROUP_GROUPTITLE = @"YHSTopicGroupGroupTitleTableViewCellID";

@interface YHSTopicGroupGroupTitleTableViewCell ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 公共容器组件
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

// 图片
@property (nonnull, nonatomic, strong) UIImageView *photoImageView;

// 名称
@property (nonnull, nonatomic, strong) UILabel *nameLabel;

// 浏览
@property (nonnull, nonatomic, strong) UILabel *viewDescLabel;

// 内容详情
@property (nonnull, nonatomic, strong) UILabel *descLabel;

// 分割线
@property (nonnull, nonatomic, strong) UIView *separatorLineView;

@end


@implementation YHSTopicGroupGroupTitleTableViewCell

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
    
    // 名称
    self.nameLabel = [UILabel new];
    [self.nameLabel setUserInteractionEnabled:YES];
    [self.nameLabel setTextColor:[UIColor blackColor]];
    [self.nameLabel setFont:[UIFont systemFontOfSize:16]];
    [self.nameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.nameLabel];
    
    // 浏览
    self.viewDescLabel = [UILabel new];
    [self.viewDescLabel setUserInteractionEnabled:YES];
    [self.viewDescLabel setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
    [self.viewDescLabel setFont:[UIFont systemFontOfSize:14]];
    [self.publicContainerView addSubview:self.viewDescLabel];
    
    // 内容详情
    self.descLabel = [UILabel new];
    [self.descLabel setNumberOfLines:0];
    [self.descLabel setUserInteractionEnabled:YES];
    [self.descLabel setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
    [self.descLabel setFont:[UIFont systemFontOfSize:14]];
    [self.publicContainerView addSubview:self.descLabel];
    
    // 分割线
    self.separatorLineView =[[UIView alloc] init];
    [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    [self.publicContainerView addSubview:self.separatorLineView];
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout {
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10;
    CGFloat photoImageSize = 60.0;
    
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
    
    // 名称
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.photoImageView.mas_top);
        make.left.equalTo(weakSelf.photoImageView.mas_right).offset(margin);
        make.height.equalTo(weakSelf.photoImageView.mas_height).multipliedBy(1.0/3.0);
    }];
    
    // 浏览
    [self.viewDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.nameLabel.mas_centerY);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.bottom.equalTo(weakSelf.nameLabel.mas_bottom);
    }];
    
    // 内容详情
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(margin/2.0);
        make.left.equalTo(weakSelf.photoImageView.mas_right).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.height.lessThanOrEqualTo(weakSelf.photoImageView.mas_height).multipliedBy(2.0/3.0);
    }];
    
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
- (void)setModel:(YHSTopicGroupGroupTitleModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 图片
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:_model.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 名称
    [self.nameLabel setText:_model.Name];
    
    // 浏览
    [self.viewDescLabel setText:_model.ViewDesc];
    
    // 内容详情
    [self.descLabel setText:_model.Desc];
    
}


#pragma mark - 触发操作事件

- (void)pressPublicContainerArea:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithTopicGroupGroupTitleModel:)]) {
        [self.delegate didClickElementOfCellWithTopicGroupGroupTitleModel:self.model];
    }
}


@end
