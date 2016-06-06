//
//  YHSTopicGroupTodayStarTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSTopicGroupTodayStarTableViewCell.h"
#import "YHSTopicGroupTodayStarModel.h"

NSString * const CELL_IDENTIFIER_TOPIC_GROUP_TODAY_STAR = @"YHSTopicGroupTodayStarTableViewCellID";

@interface YHSTopicGroupTodayStarTableViewCell ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 公共容器组件
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

// 头像列表
@property (nonnull, nonatomic, strong) UIView *userContainerView;
@property (nonnull, nonatomic, strong) NSMutableArray<UIImageView *> *avatarImageViews;
@property (nonnull, nonatomic, strong) NSMutableArray<UILabel *> *userNameLabels;

@end


@implementation YHSTopicGroupTodayStarTableViewCell

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
    
    
    // 头像列表
    {
        // 容器
        CGFloat containerHeight = 70.0;
        UIView *userContainerView = ({
            UIView *view = [UIView new];
            [publicContainerView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(margin/2.0);
                make.left.equalTo(@(margin));
                make.right.equalTo(@(-margin));
                make.height.equalTo(@(containerHeight));
            }];
            
            view;
        });
        self.userContainerView = userContainerView;
        
        // 头像
        int count = 5;
        CGFloat avatarImageSize = 50.0;
        _avatarImageViews = [NSMutableArray array];
        for (int index = 0; index < count; index ++) {
            UIImageView *imageView = ({
                UIImageView *imageView = [UIImageView new];
                [imageView setTag:(index+1000)];
                [imageView.layer setMasksToBounds:YES];
                [imageView setUserInteractionEnabled:YES];
                [imageView.layer setCornerRadius:avatarImageSize/2.0];
                [userContainerView addSubview:imageView];
                
                // 点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressAvatarViewArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [imageView addGestureRecognizer:tapGesture];
                
                imageView;
            });
            [_avatarImageViews addObject:imageView];
        }
        [_avatarImageViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:avatarImageSize leadSpacing:0.0 tailSpacing:0.0];
        [_avatarImageViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userContainerView.mas_top);
            make.height.equalTo(@(avatarImageSize));
        }];
        
        
        // 用户名
        _userNameLabels = [NSMutableArray array];
        for (int index = 0; index < count; index ++) {
            UILabel *userNameLabel = ({
                UILabel *label = [UILabel new];
                [label setTag:(index+2000)];
                [label setUserInteractionEnabled:YES];
                [label setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
                [label setFont:[UIFont systemFontOfSize:12]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [userContainerView addSubview:label];
                
                // 点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressUserNameLabelArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [label addGestureRecognizer:tapGesture];
                
                label;
            });
            [_userNameLabels addObject:userNameLabel];
        }
        [_userNameLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:avatarImageSize leadSpacing:0.0 tailSpacing:0.0];
        [_userNameLabels mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userContainerView.mas_top).offset(avatarImageSize+margin);
            make.bottom.equalTo(weakSelf.userContainerView.mas_bottom);
        }];

    }
    
    // 约束的完整性
    [weakSelf.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.userContainerView.mas_bottom).offset(0.0);
    }];
    
}


/**
 *  设置控件属性
 */
- (void)setModel:(NSMutableArray<YHSTopicGroupTodayStarModel *> *)model
{
    _model = model;
    
    if (!_model && 0 == model.count) {
        return;
    }
    
    // 头像
    [model enumerateObjectsUsingBlock:^(YHSTopicGroupTodayStarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < 5) {
            [_avatarImageViews[idx] sd_setImageWithURL:[NSURL URLWithString:obj.Avatar] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
            [_userNameLabels[idx] setText:obj.UserName];
        }
    }];
    
    
}

#pragma mark - 触发操作事件

- (void)pressAvatarViewArea:(UITapGestureRecognizer *)gesture
{
    UIImageView *view = (UIImageView *)gesture.view;
    NSInteger index = [view tag]-1000;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithTopicGroupTodayStarModel:)]) {
        [self.delegate didClickElementOfCellWithTopicGroupTodayStarModel:self.model[index]];
    }
    
}

- (void)pressUserNameLabelArea:(UITapGestureRecognizer *)gesture
{
    UILabel *label = (UILabel *)gesture.view;
    NSInteger index = [label tag]-2000;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithTopicGroupTodayStarModel:)]) {
        [self.delegate didClickElementOfCellWithTopicGroupTodayStarModel:self.model[index]];
    }
    
}



@end
