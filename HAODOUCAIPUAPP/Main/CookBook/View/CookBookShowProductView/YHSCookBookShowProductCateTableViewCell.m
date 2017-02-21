//
//  YHSCookBookShowProductCateTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookShowProductCateTableViewCell.h"
#import "YHSCookBookShowProductCateModel.h"

NSString * const CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_CATE = @"YHSCookBookShowProductCateTableViewCellID";

@interface YHSCookBookShowProductCateTableViewCell ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 公共容器组件
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

// 头部
@property (nonnull, nonatomic, strong) UIView *topView;
@property (nonnull, nonatomic, strong) UILabel *titleLabel;
@property (nonnull, nonatomic, strong) UILabel *moreLabel;

// 数组，赋值用
@property (nonnull, nonatomic, strong) NSMutableArray *mainContainerViews;
@property (nonnull, nonatomic, strong) NSMutableArray *imageViews;
@property (nonnull, nonatomic, strong) NSMutableArray *userNameLabels;
@property (nonnull, nonatomic, strong) NSMutableArray *countLabels;

@end



@implementation YHSCookBookShowProductCateTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUIViewAtuoLayout];
    }
    return self;
}

#pragma make 创建子控件，用Masonry进行约束
- (void) createUIViewAtuoLayout {

    WEAKSELF(weakSelf);
    
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
    
}


/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookShowProductCateModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 删除所有控件
    for (UIView *view in self.publicContainerView.subviews) {
        [view removeFromSuperview];
    }
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10;

    // 头部
    {
        // 容器
        UIView *topView = ({
            UIView *view = [UIView new];
            [view.layer setMasksToBounds:YES];
            [weakSelf.publicContainerView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(@(margin));
                make.left.equalTo(@(margin));
                make.right.equalTo(@(-margin));
            }];
            
            view;
        });
        self.topView = topView;
        
        // 查看更多
        UILabel *moreLabel = ({
            UILabel *label = [UILabel new];
            [label setText:@"查看更多 >"];
            [label setTextColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1.00]];
            [label setFont:[UIFont systemFontOfSize:12.0]];
            [label setTextAlignment:NSTextAlignmentRight];
            [label setUserInteractionEnabled:YES];
            [topView addSubview:label];
            
            // 点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressMoreViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [label addGestureRecognizer:tapGesture];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(topView);
                make.left.equalTo(topView.mas_right).offset(-80.0);
                make.right.equalTo(@(0.0));
                make.height.equalTo(@(40.0));
            }];
            
            label;
        });
        self.moreLabel = moreLabel;
        
        // 标题
        UILabel *titleLabel = ({
            UILabel *label = [UILabel new];
            [label setTextColor:[UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00]];
            [label setFont:[UIFont systemFontOfSize:20.0]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [topView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(topView);
                make.left.equalTo(@(0.0));
                make.right.equalTo(moreLabel.mas_left);
                make.height.equalTo(@(40.0));
            }];
            
            label;
        });
        self.titleLabel = titleLabel;
        
        // 分割线
        UIView *separatorLineView = ({
            UIView *view = [UIView new];
            [view setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
            [topView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleLabel.mas_bottom).offset(0.0);
                make.left.equalTo(topView.mas_left).offset(0.0);
                make.right.equalTo(topView.mas_right).offset(0.0);
                make.height.equalTo(@(1.0));
            }];
            
            view;
        });
        
        // 头部底部约束
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(separatorLineView.mas_bottom).offset(margin);
        }];
        
    }
    
    
    // 详情内容
    {
        CGFloat cornerRadio = 5.0;
        CGFloat titleFontSize = 14.0;
        CGFloat photoCountFontSize = 12.0;
        
        // 容器宽高
        CGFloat heightA = 230.0;
        CGFloat heightB = 170.0;
        NSArray<NSNumber *> *heights = [NSArray array];
        if (model.index %2 == 0) {
            heights = @[ @(heightA), @(heightB), @(heightB), @(heightA) ];
        } else {
            heights = @[ @(heightB), @(heightA), @(heightA), @(heightB) ];
        }
        CGFloat width = (SCREEN_WIDTH-3*margin)/2.0;
        
        _mainContainerViews = [NSMutableArray array];
        _imageViews = [NSMutableArray array];
        _userNameLabels = [NSMutableArray array];
        _countLabels = [NSMutableArray array];
        
        UIView *lastView = nil;
        UIView *lastFirstColum = nil;
        UIView *lastSecondColum = nil;
        for (int index = 0; index < 4; index ++) {
            // 容器
            UIView *containerView = ({
                UIView *view = [UIView new];
                [view setTag:1000+index];
                [view.layer setMasksToBounds:YES];
                [weakSelf.publicContainerView addSubview:view];
                
                if (index % 2 == 0) {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.width.equalTo(@(width));
                        make.height.equalTo(heights[index]);
                        if (lastFirstColum) {
                            make.top.equalTo(lastFirstColum.mas_bottom).offset(margin);
                            make.left.equalTo(@(margin));
                        } else {
                            make.top.equalTo(weakSelf.topView.mas_bottom);
                            make.left.equalTo(@(margin));
                        }
                    }];
                    lastFirstColum = view;
                } else {
                    [view mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.width.equalTo(@(width));
                        make.height.equalTo(heights[index]);
                        if (lastSecondColum) {
                            make.top.equalTo(lastSecondColum.mas_bottom).offset(margin);
                            make.left.equalTo(lastView.mas_right).offset(margin);
                        } else {
                            make.top.equalTo(lastView.mas_top);
                            make.left.equalTo(lastView.mas_right).offset(margin);
                        }
                    }];
                    lastSecondColum = view;
                }
                
                // 点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressPublicViewArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [view addGestureRecognizer:tapGesture];

                view;
            });
            lastView = containerView;
            [_mainContainerViews addObject:containerView];
            
            // 图片容器
            UIImageView *imageView = ({
                UIImageView *imageView = [UIImageView new];
                [imageView.layer setMasksToBounds:YES];
                [imageView setUserInteractionEnabled:YES];
                [imageView.layer setCornerRadius:cornerRadio];
                [containerView addSubview:imageView];
                
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(@(0.0));
                    make.left.equalTo(@(0.0));
                    make.right.equalTo(@(0.0));
                    make.bottom.equalTo(containerView.mas_bottom).offset(-45);
                }];
                
                imageView;
            });
            [_imageViews addObject:imageView];
            
            // 标题
            UILabel *userNameLabel = ({
                UILabel *label = [UILabel new];
                [label setTextColor:[UIColor blackColor]];
                [label setFont:[UIFont systemFontOfSize:titleFontSize]];
                [label setTextAlignment:NSTextAlignmentLeft];
                [containerView addSubview:label];
                
                // 标题
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(containerView.mas_bottom).offset(-40.0);
                    make.left.equalTo(containerView.mas_left).offset(0.0);
                    make.right.equalTo(containerView.mas_right).offset(0.0);
                }];
                
                label;
            });
            [_userNameLabels addObject:userNameLabel];
            
            // 数量
            UILabel *countLabel = ({
                UILabel *label = [UILabel new];
                [label setTextColor:[UIColor lightGrayColor]];
                [label setFont:[UIFont systemFontOfSize:photoCountFontSize]];
                [label setTextAlignment:NSTextAlignmentLeft];
                [containerView addSubview:label];
                
                // 标题
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(containerView.mas_bottom).offset(-20.0);
                    make.left.equalTo(containerView.mas_left).offset(0.0);
                    make.right.equalTo(containerView.mas_right).offset(0.0);
                }];
                
                label;
            });
            [_countLabels addObject:countLabel];
            
        }
        
        // 约束的完整性
        [weakSelf.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastView.mas_bottom).offset(margin);
        }];
    }

    
    // 赋值
    {
        // 标题
        [_titleLabel setText:model.Title];
        
        // 内容
        for (int index = 0; index < 4; index ++) {
            
            // 图片
            [_imageViews[index] sd_setImageWithURL:[NSURL URLWithString:_model.List[index].Cover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
            
            // 标题
            [_userNameLabels[index] setText:_model.List[index].UserName];
            
            // 数量
            [_countLabels[index] setText:[NSString stringWithFormat:@"%@个赞", _model.List[index].Count]];
            
        }
    }


}


#pragma mark - 触发操作事件

- (void)pressPublicViewArea:(UITapGestureRecognizer *)gesture
{
    UIView *view = (UIView *)gesture.view;
    NSInteger index = [view tag]-1000;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookShowProductCateItemModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookShowProductCateItemModel:self.model.List[index]];
    }
    
}


- (void)pressMoreViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookShowProductCateModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookShowProductCateModel:self.model];
    }
    
}


@end
