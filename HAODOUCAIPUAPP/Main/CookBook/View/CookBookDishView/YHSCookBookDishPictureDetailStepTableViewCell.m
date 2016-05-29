
//
//  YHSCookBookDishPictureDetailStepTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDishPictureDetailStepTableViewCell.h"
#import "YHSCookBookDishModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_PICTURE_DETAIL_STEP = @"YHSCookBookDishPictureDetailStepTableViewCellID";


@interface YHSCookBookDishPictureDetailStepTableViewCell ()

/**
 * 根容器组件
 */
@property (nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonatomic, strong) UIView *publicContainerView;

/**
 * 图片
 */
@property (nonatomic, strong) UIImageView *stepPhotoView;

/**
 * 序号
 */
@property (nonnull, nonatomic, strong) UILabel *numLabel;

/**
 * 详情
 */
@property (nonatomic, strong) UILabel *introLabel;


@end


@implementation YHSCookBookDishPictureDetailStepTableViewCell


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
    
    // 图片
    self.stepPhotoView = [[UIImageView alloc] init];
    [self.stepPhotoView setUserInteractionEnabled:YES];
    [self.stepPhotoView.layer setMasksToBounds:YES];
    [self.stepPhotoView.layer setCornerRadius:5.0];
    [self.stepPhotoView setContentMode:UIViewContentModeScaleAspectFill];
    [self.publicContainerView addSubview:self.stepPhotoView];
    
    // 序号
    self.numLabel = [UILabel new];
    [self.numLabel setNumberOfLines:1];
    [self.numLabel setTextColor:[UIColor blackColor]];
    [self.numLabel setFont:[UIFont systemFontOfSize:22]];
    [self.numLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.numLabel];
    
    // 详情
    self.introLabel = [UILabel new];
    [self.introLabel setNumberOfLines:0];
    [self.introLabel setTextColor:[UIColor blackColor]];
    [self.introLabel setUserInteractionEnabled:YES];
    [self.introLabel setFont:[UIFont systemFontOfSize:16]];
    [self.introLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.introLabel];
    
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
    
    // 图片
    [self.stepPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(margin));
        make.left.equalTo(@(margin));
        make.width.equalTo(weakSelf.publicContainerView.mas_width).multipliedBy(3.0/10.0);
        make.height.equalTo(weakSelf.stepPhotoView.mas_width).multipliedBy(7.0f/10.0f).with.priority(750);
    }];
    
    // 序号
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.stepPhotoView).offset(margin/2.0);
        make.left.equalTo(weakSelf.stepPhotoView.mas_right).offset(margin);
    }];
    
    // 详情
    [self.introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.stepPhotoView).offset(0.0);
        make.left.equalTo(weakSelf.numLabel.mas_right).offset(margin/2.0);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
    }];
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.greaterThanOrEqualTo(@(SCREEN_WIDTH*21.0/100.0+2*margin));
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookDishStepsModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 图片
    [self.stepPhotoView sd_setImageWithURL:[NSURL URLWithString:_model.StepPhoto] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 序号
    [self.numLabel setText:_model.num];
    NSDictionary *numAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:22]};
    CGSize numSize = [_model.num boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:numAttributes
                                              context:nil].size;
    [self.numLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(numSize);
    }];
    
    
    // 详情
    [self.introLabel setText:_model.Intro];
    {
        WEAKSELF(weakSelf);
        CGFloat margin = 10.0;
        CGFloat maxWidth = SCREEN_WIDTH*7.0/10.0-numSize.width-3.5*margin;
        NSDictionary *introAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]};
        CGSize introSize = [_model.Intro boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   attributes:introAttributes
                                                      context:nil].size;
        if (introSize.height > SCREEN_WIDTH*21.0/100.0) {
            [self.introLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.publicContainerView).offset(margin);
                make.left.equalTo(weakSelf.numLabel.mas_right).offset(margin/2.0);
                make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
                make.bottom.equalTo(weakSelf.publicContainerView.mas_bottom).offset(-margin);
            }];
        } else {
            [self.introLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.publicContainerView).offset(margin);
                make.left.equalTo(weakSelf.numLabel.mas_right).offset(margin/2.0);
                make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
            }];
        }
        
    }

    
}

#pragma mark - 触发操作事件

- (void)pressCoverImageViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithDishPictureStepModel:)]) {
        [self.delegate didClickElementOfCellWithDishPictureStepModel:self.model];
    }
    
}





@end
