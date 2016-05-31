//
//  YHSCookBookShowProductDayTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookShowProductDayTableViewCell.h"
#import "YHSCookBookShowProductDayModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_DAY = @"YHSCookBookShowProductDayTableViewCellID";

@interface YHSCookBookShowProductDayTableViewCell ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 公共容器组件
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

// 左图
@property (nonnull, nonatomic, strong) UIView *leftAplhaView;
@property (nonnull, nonatomic, strong) UIImageView *leftImageView;
@property (nonnull, nonatomic, strong) UILabel *leftThemeTitleLabel;
@property (nonnull, nonatomic, strong) UILabel *leftPhotoCountLabel;

// 右上图
@property (nonnull, nonatomic, strong) UIView *rightUpAplhaView;
@property (nonnull, nonatomic, strong) UIImageView *rightUpImageView;
@property (nonnull, nonatomic, strong) UILabel *rightUpThemeTitleLabel;
@property (nonnull, nonatomic, strong) UILabel *rightUpPhotoCountLabel;

// 右下图
@property (nonnull, nonatomic, strong) UIView *rightDownAplhaView;
@property (nonnull, nonatomic, strong) UIImageView *rightDownImageView;
@property (nonnull, nonatomic, strong) UILabel *rightDownThemeTitleLabel;
@property (nonnull, nonatomic, strong) UILabel *rightDownPhotoCountLabel;

// 数组，赋值用
@property (nonnull, nonatomic, strong) NSMutableArray<UIView *> *imageViews;
@property (nonnull, nonatomic, strong) NSMutableArray *themeTitleLabels;
@property (nonnull, nonatomic, strong) NSMutableArray *photoCountLabels;

@end


@implementation YHSCookBookShowProductDayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUIViewWithAuLayout];
    }
    return self;
}

#pragma make 创建子控件，并添加约束
- (void) createUIViewWithAuLayout {
    
    WEAKSELF(weakSelf);
    
    CGFloat gap = 2.5;
    CGFloat margin = 10.0;
    CGFloat cornerRadio = 4.0;
    CGFloat titleFontSize = 16.0;
    CGFloat photoCountFontSize = 14.0;
    
    
    // 设置背景色
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    
    // 根容器组件
    UIView *rootContainerView = ({
        UIView *view = [UIView new];
        [self.contentView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).with.offset(0);
        }];
        
        view;
    });
    self.rootContainerView = rootContainerView;
    
    
    // 公共容器组件
    UIView *publicContainerView = ({
        UIView *view = [UIView new];
        [view.layer setMasksToBounds:YES];
        [rootContainerView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(rootContainerView.mas_bottom).offset(0);
        }];
        
        view;
    });
    self.publicContainerView = publicContainerView;
    
    
    // 左图
    {
        // 图片
        UIImageView *leftImageView = ({
            
            // 图片容器
            UIImageView *imageView = [UIImageView new];
            [imageView setTag:1000];
            [imageView.layer setMasksToBounds:YES];
            [imageView setUserInteractionEnabled:YES];
            [imageView.layer setCornerRadius:cornerRadio];
            [publicContainerView addSubview:imageView];
            
            // 点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressImageViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [imageView addGestureRecognizer:tapGesture];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(margin));
                make.left.equalTo(@(margin));
                make.width.equalTo(publicContainerView.mas_width).multipliedBy(5.5/10.0);
                make.height.equalTo(@(SCREEN_WIDTH*0.50));
            }];
            
            imageView;
        });
        self.leftImageView = leftImageView;
        
        // 透明层
        UIView *laplhaView = ({
            UIView *view = [UIView new];
            [view.layer setMasksToBounds:YES];
            [view setUserInteractionEnabled:YES];
            [view setBackgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:0.30]];
            [leftImageView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(leftImageView);
            }];
            
            view;
        });
        self.leftAplhaView = laplhaView;
        
        // 标题
        UILabel *themeTitleLabel = ({
            UILabel *label = [UILabel new];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:titleFontSize]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [laplhaView addSubview:label];
            
            // 标题
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(laplhaView.mas_bottom).offset(-50.0);
                make.left.equalTo(laplhaView.mas_left).offset(margin);
                make.right.equalTo(laplhaView.mas_right).offset(-margin);
            }];
            
            label;
        });
        self.leftThemeTitleLabel = themeTitleLabel;
        
        // 数量
        UILabel *photoCountLabel = ({
            UILabel *label = [UILabel new];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:photoCountFontSize]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [laplhaView addSubview:label];
            
            // 标题
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(laplhaView.mas_bottom).offset(-30.0);
                make.left.equalTo(laplhaView.mas_left).offset(margin);
                make.right.equalTo(laplhaView.mas_right).offset(-margin);
            }];
            
            label;
        });
        self.leftPhotoCountLabel = photoCountLabel;
    }
    
    
    // 右上图
    {
        UIImageView *rightUpImageView = ({
            
            // 图片容器
            UIImageView *imageView = [UIImageView new];
            [imageView setTag:1001];
            [imageView.layer setMasksToBounds:YES];
            [imageView setUserInteractionEnabled:YES];
            [imageView.layer setCornerRadius:cornerRadio];
            [publicContainerView addSubview:imageView];
            
            // 点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressImageViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [imageView addGestureRecognizer:tapGesture];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(margin));
                make.left.equalTo(weakSelf.leftImageView.mas_right).offset(gap);
                make.right.equalTo(@(-margin));
            }];
            
            imageView;
        });
        self.rightUpImageView = rightUpImageView;
        
        
        // 透明层
        UIView *laplhaView = ({
            UIView *view = [UIView new];
            [view.layer setMasksToBounds:YES];
            [view setUserInteractionEnabled:YES];
            [view setBackgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:0.30]];
            [rightUpImageView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(rightUpImageView);
            }];
            
            view;
        });
        self.rightUpAplhaView = laplhaView;
        
        // 标题
        UILabel *themeTitleLabel = ({
            UILabel *label = [UILabel new];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:titleFontSize]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [laplhaView addSubview:label];
            
            // 标题
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(laplhaView.mas_bottom).offset(-50.0);
                make.left.equalTo(laplhaView.mas_left).offset(margin);
                make.right.equalTo(laplhaView.mas_right).offset(-margin);
            }];
            
            label;
        });
        self.rightUpThemeTitleLabel = themeTitleLabel;
        
        // 数量
        UILabel *photoCountLabel = ({
            UILabel *label = [UILabel new];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:photoCountFontSize]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [laplhaView addSubview:label];
            
            // 标题
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(laplhaView.mas_bottom).offset(-30.0);
                make.left.equalTo(laplhaView.mas_left).offset(margin);
                make.right.equalTo(laplhaView.mas_right).offset(-margin);
            }];
            
            label;
        });
        self.rightUpPhotoCountLabel = photoCountLabel;
    }

    
    // 右下图
    {
        UIImageView *rightDownImageView = ({
            
            // 图片容器
            UIImageView *imageView = [UIImageView new];
            [imageView setTag:1002];
            [imageView.layer setMasksToBounds:YES];
            [imageView setUserInteractionEnabled:YES];
            [imageView.layer setCornerRadius:cornerRadio];
            [publicContainerView addSubview:imageView];
            
            // 点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressImageViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [imageView addGestureRecognizer:tapGesture];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.rightUpImageView.mas_bottom).offset(gap);
                make.left.equalTo(weakSelf.leftImageView.mas_right).offset(gap);
                make.right.equalTo(@(-margin));
                make.bottom.equalTo(weakSelf.leftImageView.mas_bottom);
                make.height.equalTo(weakSelf.rightUpImageView.mas_height);
            }];
            
            imageView;
        });
        self.rightDownImageView = rightDownImageView;
        
        // 透明层
        UIView *laplhaView = ({
            UIView *view = [UIView new];
            [view.layer setMasksToBounds:YES];
            [view setUserInteractionEnabled:YES];
            [view setBackgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:0.30]];
            [rightDownImageView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(rightDownImageView);
            }];
            
            view;
        });
        self.rightDownAplhaView = laplhaView;
        
        // 标题
        UILabel *themeTitleLabel = ({
            UILabel *label = [UILabel new];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:titleFontSize]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [laplhaView addSubview:label];
            
            // 标题
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(laplhaView.mas_bottom).offset(-50.0);
                make.left.equalTo(laplhaView.mas_left).offset(margin);
                make.right.equalTo(laplhaView.mas_right).offset(-margin);
            }];
            
            label;
        });
        self.rightDownThemeTitleLabel = themeTitleLabel;
        
        // 数量
        UILabel *photoCountLabel = ({
            UILabel *label = [UILabel new];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:photoCountFontSize]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [laplhaView addSubview:label];
            
            // 标题
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(laplhaView.mas_bottom).offset(-30.0);
                make.left.equalTo(laplhaView.mas_left).offset(margin);
                make.right.equalTo(laplhaView.mas_right).offset(-margin);
            }];
            
            label;
        });
        self.rightDownPhotoCountLabel = photoCountLabel;
        
    }

    
    // 约束的完整性
    [publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.leftImageView.mas_bottom).offset(margin);
    }];
 
    
    // setModel方法赋值用
    _imageViews = [NSMutableArray array];
    [_imageViews addObject:self.leftImageView];
    [_imageViews addObject:self.rightUpImageView];
    [_imageViews addObject:self.rightDownImageView];
    
    _themeTitleLabels = [NSMutableArray array];
    [_themeTitleLabels addObject:self.leftThemeTitleLabel];
    [_themeTitleLabels addObject:self.rightUpThemeTitleLabel];
    [_themeTitleLabels addObject:self.rightDownThemeTitleLabel];
    
    _photoCountLabels = [NSMutableArray array];
    [_photoCountLabels addObject:self.leftPhotoCountLabel];
    [_photoCountLabels addObject:self.rightUpPhotoCountLabel];
    [_photoCountLabels addObject:self.rightDownPhotoCountLabel];
    
}


/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookShowProductDayModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    
    [self.imageViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 图片
        [obj sd_setImageWithURL:[NSURL URLWithString:_model.List[idx].ThemeCover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        
        // 标题
        [_themeTitleLabels[idx] setText:_model.List[idx].ThemeTitle];
        
        // 数量
        [_photoCountLabels[idx] setText:[NSString stringWithFormat:@"%ld作品", _model.List[idx].PhotoCount]];
    }];
    
}


#pragma mark - 触发操作事件

- (void)pressImageViewArea:(UITapGestureRecognizer *)gesture
{
    UIImageView *imageView = (UIImageView *)gesture.view;
    NSInteger index = [imageView tag]-1000;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookShowProductDayItemModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookShowProductDayItemModel:self.model.List[index]];
    }
    
}


@end
