//
//  YHSCookBookRecommedTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookRecommedTableViewCell.h"
#import "YHSCookBookRecommedModel.h"
#import "Masonry.h"
#import "UIView+MasonryAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "YHSSysConst.h"
#import "YHSSysMacro.h"
#import "YHSUtilsMacro.h"

NSString * const CELL_IDENTIFIER_RECOMMED = @"YHSCookBookRecommedTableViewCellID";

@interface YHSCookBookRecommedTableViewCell ()
/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 左上组件
 */
@property (nonnull, nonatomic, strong) UIImageView *leftUpImageView;
@property (nonnull, nonatomic, strong) UILabel *leftUpTitleLabel;

/**
 * 左下组件
 */
@property (nonnull, nonatomic, strong) UIImageView *leftDownImageView;
@property (nonnull, nonatomic, strong) UILabel *leftDownTitleLabel;

/**
 * 右边组件
 */
@property (nonnull, nonatomic, strong) UIImageView *rightImageView;

@end


@implementation YHSCookBookRecommedTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
        [self setViewAtuoLayout];
    }
    return self;
}

#pragma make 创建子控件
- (void) createView {
    
    
    // 根容器组件
    self.rootContainerView = [[UIView alloc] init];
    [self.contentView addSubview:self.rootContainerView];
    
    
    // 公共容器组件
    self.publicContainerView = [[UIView alloc] init];
    [self.rootContainerView addSubview:self.publicContainerView];
    
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
    
    
    CGFloat margin = 10.0;
    CGFloat containerViewWidth = (SCREEN_WIDTH - 3.0*margin) / 2.0;
    CGFloat containerViewHeight = (SCREEN_WIDTH - 3.0*margin) / 2.0;
    CGFloat containerViewLeftHeight = (containerViewHeight - margin / 2.0) / 2.0;

    
    // 左上组件
    {
        UIImageView *leftUpImageView = ({
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setTag:501];
            [imageView.layer setCornerRadius:5.0];
            [imageView.layer setMasksToBounds:YES];
            [imageView setUserInteractionEnabled:YES];
            [self.publicContainerView addSubview:imageView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressLeftImageViewArea:)];
            tapGesture.numberOfTapsRequired = 1;
            tapGesture.numberOfTouchesRequired = 1;
            [imageView addGestureRecognizer:tapGesture];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(margin);
                make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
                make.width.equalTo(@(containerViewWidth));
                make.height.equalTo(@(containerViewLeftHeight));
            }];
            
            imageView;
        });
        self.leftUpImageView = leftUpImageView;
        
        
        UILabel *leftUpTitleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [self.leftUpImageView addSubview:label];
            [label setTextColor:[UIColor whiteColor]];
            [label setNumberOfLines:0];
            [label setFont:[UIFont boldSystemFontOfSize:14]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setBackgroundColor:[UIColor colorWithRed:0.49 green:0.71 blue:0.27 alpha:1.00]];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.leftUpImageView.mas_top).offset(0.0);
                make.left.equalTo(weakSelf.leftUpImageView.mas_left).offset(0.0);
                make.bottom.equalTo(weakSelf.leftUpImageView.mas_bottom).offset(0.0);
                make.width.equalTo(@25);
            }];
            
            label;
        });
        self.leftUpTitleLabel = leftUpTitleLabel;
        
    }


    // 左下组件
    {
        UIImageView *leftDownImageView = ({
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setTag:502];
            [imageView.layer setCornerRadius:5.0];
            [imageView.layer setMasksToBounds:YES];
            [imageView setUserInteractionEnabled:YES];
            [self.publicContainerView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.leftUpImageView.mas_bottom).offset(margin/2.0);
                make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
                make.width.equalTo(@(containerViewWidth));
                make.height.equalTo(@(containerViewLeftHeight));
            }];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressLeftImageViewArea:)];
            tapGesture.numberOfTapsRequired = 1;
            tapGesture.numberOfTouchesRequired = 1;
            [imageView addGestureRecognizer:tapGesture];
            
            imageView;
        });
        self.leftDownImageView = leftDownImageView;
        
        UILabel *leftDownTitleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [self.leftDownImageView addSubview:label];
            [label setTextColor:[UIColor whiteColor]];
            [label setNumberOfLines:0];
            [label setFont:[UIFont boldSystemFontOfSize:14]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setBackgroundColor:[UIColor colorWithRed:0.49 green:0.71 blue:0.27 alpha:1.00]];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.leftDownImageView.mas_top).offset(0.0);
                make.left.equalTo(weakSelf.leftDownImageView.mas_left).offset(0.0);
                make.bottom.equalTo(weakSelf.leftDownImageView.mas_bottom).offset(0.0);
                make.width.equalTo(@25);
            }];
            
            label;
        });
        self.leftDownTitleLabel = leftDownTitleLabel;
        
    }
    
    
    // 右边组件
    UIImageView *rightImageView = ({
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setTag:503];
        [imageView.layer setCornerRadius:5.0];
        [imageView.layer setMasksToBounds:YES];
        [imageView setUserInteractionEnabled:YES];
        [self.publicContainerView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(margin);
            make.left.equalTo(weakSelf.leftUpImageView.mas_right).offset(margin);
            make.width.equalTo(@(containerViewWidth));
            make.height.equalTo(@(containerViewHeight));
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressRightImageViewArea:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [imageView addGestureRecognizer:tapGesture];
        
        imageView;
    });
    self.rightImageView = rightImageView;
    
    
    // 公共容器组件(为什么是greaterThanOrEqualTo)
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(weakSelf.rightImageView.mas_bottom).offset(margin);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookRecommedModel *)model {
    
    _model = model;
    
    // 左上
    if (model.recommedElemList.count > 0) {
        YHSCookBookRecommedElemModel *elem = model.recommedElemList[0];
        [self.leftUpTitleLabel setText:elem.Title];
        [self.leftUpImageView sd_setImageWithURL:[NSURL URLWithString:elem.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    }

    // 左下
    if (model.recommedElemList.count > 1) {
        YHSCookBookRecommedElemModel *elem = model.recommedElemList[1];
        [self.leftDownTitleLabel setText:elem.Title];
        [self.leftDownImageView sd_setImageWithURL:[NSURL URLWithString:elem.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    }
    
    // 右边
    if (model.recommedAD) {
        YHSCookBookRecommedADModel *ad = model.recommedAD;
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:ad.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    }
    
}


#pragma mark - 触发操作事件

- (void)pressLeftImageViewArea:(UITapGestureRecognizer *)gesture
{

    UIView *view = (UIView*)gesture.view;
    NSUInteger index = view.tag - 501;
    
    YHSLogLight(@"%s %@", __FUNCTION__, self.model.recommedElemList[index].Title);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithRecommedElemModel:)]) {
        [self.delegate didClickElementOfCellWithRecommedElemModel:self.model.recommedElemList[index]];
    }
   
}

- (void)pressRightImageViewArea:(UITapGestureRecognizer *)gesture
{
    
    YHSLogLight(@"%s %@", __FUNCTION__, self.model.recommedAD.Title);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithRecommedADModel:)]) {
        [self.delegate didClickElementOfCellWithRecommedADModel:self.model.recommedAD];
    }
    
}





@end
