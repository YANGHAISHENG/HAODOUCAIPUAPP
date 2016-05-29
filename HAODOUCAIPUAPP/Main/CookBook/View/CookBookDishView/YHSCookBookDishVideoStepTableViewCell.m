//
//  YHSCookBookDishVideoStepTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/26.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDishVideoStepTableViewCell.h"
#import "YHSCookBookVideoModel.h"


NSString * const CELL_IDENTIFIER_DISH_VIDEO_STEP_INFO = @"YHSCookBookDishVideoStepTableViewCellID";


@interface YHSCookBookDishVideoStepTableViewCell ()

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 序号
 */
@property (nonnull, nonatomic, strong) UILabel *numLabel;

/**
 * 内容
 */
@property (nonnull, nonatomic, strong) UILabel *contentLabel;

/**
 * 图片
 */
@property (nonnull, nonatomic, strong) UIImageView *videoImageView;


/**
 * 分割线
 */
@property (nonnull, nonatomic, strong) UIView *separatorLineView;

@end


@implementation YHSCookBookDishVideoStepTableViewCell

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
    
    // 序号
    self.numLabel = [UILabel new];
    [self.numLabel setNumberOfLines:1];
    [self.numLabel setTextColor:[UIColor colorWithRed:0.49 green:0.71 blue:0.27 alpha:1.00]];
    [self.numLabel setFont:[UIFont systemFontOfSize:18]];
    [self.numLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.numLabel];
    
    // 图片
    self.videoImageView = [UIImageView new];
    [self.videoImageView.layer setCornerRadius:12.5];
    [self.videoImageView.layer setMasksToBounds:YES];
    [self.videoImageView setUserInteractionEnabled:YES];
    [self.publicContainerView addSubview:self.videoImageView];
    
    // 内容
    self.contentLabel = [UILabel new];
    [self.contentLabel setNumberOfLines:0];
    [self.contentLabel setTextColor:[UIColor blackColor]];
    [self.contentLabel setUserInteractionEnabled:YES];
    [self.contentLabel setFont:[UIFont systemFontOfSize:16]];
    [self.contentLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.contentLabel];

    // 分割线
    self.separatorLineView =[[UIView alloc] init];
    [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    [self.rootContainerView addSubview:self.separatorLineView];
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
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
    
    // 标题
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publicContainerView).offset(margin);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
        make.size.mas_equalTo(CGSizeMake(15, 20));
    }];
    
    // 图片
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publicContainerView).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    // 内容详情
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publicContainerView).offset(margin);
        make.left.equalTo(weakSelf.numLabel.mas_right).offset(margin);
        make.right.equalTo(weakSelf.videoImageView.mas_left).offset(-margin);
    }];
    
    // 分割线
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentLabel.mas_bottom).offset(margin);
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
- (void)setModel:(YHSCookBookVideoStepModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 注意复用的问题
    [self didSelectPublicContainerView:model.selected];
    
    // 图片
    [self.videoImageView setImage:[UIImage imageNamed:@"ico_video_small"]];
    
    // 序号
    [self.numLabel setText:model.num];

    // 内容
    [self.contentLabel setText:_model.Content];
    
}

#pragma mark - 触发操作事件

- (void)didSelectPublicContainerView:(BOOL)selected
{
    if (!selected) {
        [self.contentLabel setTextColor:[UIColor blackColor]];
        [self.videoImageView setImage:[UIImage imageNamed:@"ico_video_small"]];
        [self.publicContainerView setBackgroundColor:[UIColor whiteColor]];
    } else {
        [self.videoImageView setImage:[UIImage imageNamed:@"video_step_ico_select"]];
        [self.contentLabel setTextColor:[UIColor colorWithRed:0.49 green:0.71 blue:0.27 alpha:1.00]];
        [self.publicContainerView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    }

}



@end
