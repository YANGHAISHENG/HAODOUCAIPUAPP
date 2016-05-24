//
//  YHSCookBookHotsAlbumDetailShareTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "Masonry.h"
#import "UIImageView+WebCache.h"

#import "YHSCookBookHotsAlbumDetailShareTableViewCell.h"
#import "YHSSysConst.h"
#import "YHSSysMacro.h"
#import "YHSUtilsMacro.h"
#import "UIView+MasonryAutoLayout.h"

#import "YHSCookBookHotsAlbumDetailShareModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_HOTS_ALBUM_DETAIL_SHARE = @"YHSCookBookHotsAlbumDetailShareTableViewCellID";

@interface YHSCookBookHotsAlbumDetailShareTableViewCell ()

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 描述信息
 */
@property (nonnull, nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, assign) CGFloat descriptionLabelHeight;
@property (nonatomic, assign) CGFloat descriptionLabelFontSize;

// 动态变高
@property (strong, nonatomic) MASConstraint *descriptionLabelHeightConstraint;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end


@implementation YHSCookBookHotsAlbumDetailShareTableViewCell

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
    
    // 描述信息
    {
        CGFloat margin = 10.0;
        CGFloat preferredMaxWidth = SCREEN_WIDTH-2*margin; // 计算UILabel的preferredMaxLayoutWidth值，多行时必须设置这个值，否则系统无法决定Label的宽度
        
        self.descriptionLabelFontSize = 16.0;
        self.descriptionLabel = [UILabel new];
        [self.descriptionLabel setTextColor:[UIColor blackColor]];
        [self.descriptionLabel setNumberOfLines:0];
        [self.descriptionLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [self.descriptionLabel setClipsToBounds:YES];
        [self.descriptionLabel setUserInteractionEnabled:YES];
        [self.descriptionLabel setPreferredMaxLayoutWidth:preferredMaxWidth];
        [self.descriptionLabel setFont:[UIFont systemFontOfSize:self.descriptionLabelFontSize]];
        [self.descriptionLabel setTextAlignment:NSTextAlignmentLeft];
        [self.publicContainerView addSubview:self.descriptionLabel];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressDescriptionLabel:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.descriptionLabel addGestureRecognizer:tapGesture];
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
        make.top.equalTo(@(0));
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
    }];
    
    // 描述信息
    _descriptionLabelHeight = 80.0;
    [self.descriptionLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(margin);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        // 加上高度的限制，优先级只设置成High，比正常的高度约束低一些，防止冲突
        _descriptionLabelHeightConstraint = make.height.lessThanOrEqualTo(@(_descriptionLabelHeight)).with.priorityHigh();
    }];
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.descriptionLabel.mas_bottom).offset(margin*1.5);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookHotsAlbumDetailShareModel *)model indexPath:(NSIndexPath *)indexPath;
{
    _model = model;
    
    _indexPath = indexPath;
    
    if (!_model) {
        return;
    }

    // 描述信息
    [_descriptionLabel setText:_model.Desc];

    // 约束
    if (_model.isExpanded) {
        [_descriptionLabelHeightConstraint uninstall];
    } else {
        [_descriptionLabelHeightConstraint install];
    }
    
}


#pragma mark - 触发操作事件

- (void)pressDescriptionLabel:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithHotsAlbumDetailShareModel:expandedStateWithIndexPath:)]) {
        [self.delegate didClickElementOfCellWithHotsAlbumDetailShareModel:self.model expandedStateWithIndexPath:self.indexPath];
    }
    
}


@end
