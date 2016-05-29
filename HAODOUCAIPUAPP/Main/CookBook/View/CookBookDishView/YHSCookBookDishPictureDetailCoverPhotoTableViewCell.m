//
//  YHSCookBookDishPictureDetailCoverPhotoTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDishPictureDetailCoverPhotoTableViewCell.h"
#import "YHSCookBookDishModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_COVER_PHOTO = @"YHSCookBookDishPictureDetailCoverPhotoTableViewCellID";


@interface YHSCookBookDishPictureDetailCoverPhotoTableViewCell ()

/**
 * 根容器组件
 */
@property (nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonatomic, strong) UIView *publicContainerView;

/**
 * 图片容器组件
 */
@property (nonatomic, strong) UIImageView *coverImageView;


@end


@implementation YHSCookBookDishPictureDetailCoverPhotoTableViewCell

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
    [self.rootContainerView addSubview:self.publicContainerView];
    
    // 图片容器组件
    self.coverImageView = [[UIImageView alloc] init];
    [self.coverImageView setUserInteractionEnabled:YES];
    [self.publicContainerView.layer setMasksToBounds:YES];
    [self.coverImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.publicContainerView addSubview:self.coverImageView];
    
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
    
    // 图片容器
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        // 注意此处，宽高比16：9优先级比1000低就行，在因为iPhone 4S宽高比不是16：9
        make.height.equalTo(weakSelf.coverImageView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
    }];
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.coverImageView.mas_bottom).offset(0.0);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookDishModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 图片
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.Cover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
}

#pragma mark - 触发操作事件

- (void)pressCoverImageViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithDishPictureDetailCoverPhotoModel:)]) {
        [self.delegate didClickElementOfCellWithDishPictureDetailCoverPhotoModel:self.model];
    }
    
}



@end
