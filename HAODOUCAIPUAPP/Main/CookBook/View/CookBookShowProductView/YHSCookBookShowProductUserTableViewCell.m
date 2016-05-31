//
//  YHSCookBookShowProductUserTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookShowProductUserTableViewCell.h"
#import "YHSCookBookShowProductUserModel.h"

NSString * const CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_USER = @"YHSCookBookShowProductUserTableViewCellID";

@interface YHSCookBookShowProductUserTableViewCell ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 公共容器组件
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

// 头部
@property (nonnull, nonatomic, strong) UIView *topView;
@property (nonnull, nonatomic, strong) UILabel *titleLabel;

// 头像列表
@property (nonnull, nonatomic, strong) UIView *userContainerView;
@property (nonnull, nonatomic, strong) NSMutableArray *imageViews;

@end


@implementation YHSCookBookShowProductUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUIViewAtuoLayout];
    }
    return self;
}

#pragma make 创建子控件，用Masonry进行约束
- (void) createUIViewAtuoLayout {
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10.0;
    
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
                make.right.equalTo(topView.mas_right);
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
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(separatorLineView.mas_bottom).offset(margin);
        }];
        
    }

    
    // 头像列表
    {
        // 容器
        UIView *userContainerView = ({
            UIView *view = [UIView new];
            [publicContainerView addSubview:view];

            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.topView.mas_bottom);
                make.left.equalTo(@(margin));
                make.right.equalTo(@(-margin));
                make.height.equalTo(@(60));
            }];
            
            view;
        });
        self.userContainerView = userContainerView;
        
        
        // 头像
        int count = 6;
        CGFloat imageSize = 50.0;
        _imageViews = [NSMutableArray array];
        for (int index = 0; index < count; index ++) {
            UIImageView *imageView = ({
                UIImageView *imageView = [UIImageView new];
                [imageView setTag:(index+1000)];
                [imageView.layer setMasksToBounds:YES];
                [imageView setUserInteractionEnabled:YES];
                [imageView.layer setCornerRadius:imageSize/2.0];
                [userContainerView addSubview:imageView];

                // 点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressAvatarViewArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [imageView addGestureRecognizer:tapGesture];
                
                imageView;
            });
            [_imageViews addObject:imageView];
        }
        [_imageViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:imageSize leadSpacing:0.0 tailSpacing:0.0];
        [_imageViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(userContainerView.mas_centerY);
            make.height.equalTo(@(imageSize));
        }];
        
    }

    // 约束的完整性
    [weakSelf.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.userContainerView.mas_bottom).offset(margin);
    }];
    
}


/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookShowProductUserModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 标题
    [_titleLabel setText:@"Ta的作品很被赞"];
    
    // 头像
    [model.List enumerateObjectsUsingBlock:^(YHSCookBookShowProductUserItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < 6) {
            // 图片
            [_imageViews[idx] sd_setImageWithURL:[NSURL URLWithString:obj.Avatar] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        }
    }];
    

}

#pragma mark - 触发操作事件

- (void)pressAvatarViewArea:(UITapGestureRecognizer *)gesture
{
    UIImageView *view = (UIImageView *)gesture.view;
    NSInteger index = [view tag]-1000;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookShowProductUserItemModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookShowProductUserItemModel:self.model.List[index]];
    }
    
}




@end
