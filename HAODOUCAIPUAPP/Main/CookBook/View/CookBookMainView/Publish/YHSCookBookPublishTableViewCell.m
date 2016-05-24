//
//  YHSCookBookPublishTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookPublishTableViewCell.h"
#import "YHSCookBookPublishModel.h"
#import "Masonry.h"
#import "UIView+MasonryAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "YHSSysConst.h"
#import "YHSSysMacro.h"
#import "YHSUtilsMacro.h"

NSString * const CELL_IDENTIFIER_PUBLISH = @"YHSCookBookPublishTableViewCellID";


@interface YHSCookBookPublishTableViewCell ()

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 分享组件
 */
@property (nonnull, nonatomic, strong) UIView *publishContainerView;

@end


@implementation YHSCookBookPublishTableViewCell

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
    
    // 分享
    UIView *publishContainerView = ({
        UIView *view = [[UIView alloc] init];
        [self.publicContainerView addSubview:view];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressPublishViewArea:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:tapGesture];
        
        view;
    });
    self.publishContainerView = publishContainerView;
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
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
    
    CGFloat imageSize = 40.0;
    CGFloat titleWidth = 55.0;
    CGFloat containerWidth = imageSize + titleWidth;
    CGFloat containerHeight = 50.0;
    
    // 分享
    [self.publishContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.publicContainerView);
        make.width.equalTo(@(containerWidth));
        make.height.equalTo(@(containerHeight));
    }];

    // 公共容器组件
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.publishContainerView.mas_bottom);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookPublishModel *)model
{
    _model = model;
    
    // 内容是否为空
    if (!_model) {
        return;
    }
    
    // Cell复用机制会出现阴影
    for(UIView *view in self.publishContainerView.subviews) {
        [view removeFromSuperview];
    }

    WEAKSELF(weakSelf);
    
    CGFloat margin = 10.0;
    CGFloat imageSize = 40.0;
    CGFloat titleWidth = 55.0;

    // 图片
    UIImageView *imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView.layer setMasksToBounds:YES];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        [self.publishContainerView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.publishContainerView).offset(margin/2.0);
            make.left.equalTo(weakSelf.publishContainerView);
            make.size.mas_equalTo(CGSizeMake(imageSize, imageSize));
        }];
        
        imageView;
    });
    
    
    // 标题
    UILabel *label = [[UILabel alloc] init];
    [label setText:model.title];
    [label setNumberOfLines:0];
    [label setTextColor:[UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00]];
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setTextAlignment:NSTextAlignmentLeft];
    [self.publishContainerView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right);
        make.centerY.equalTo(imageView.mas_centerY).offset(2.0);
        make.width.equalTo(@(titleWidth));
        make.height.greaterThanOrEqualTo(@(20));
    }];
    
}


#pragma mark - 触发操作事件

- (void)pressPublishViewArea:(UITapGestureRecognizer *)gesture
{

    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithPublishModel:)]) {
        [self.delegate didClickElementOfCellWithPublishModel:self.model];
    }
    
}



@end
