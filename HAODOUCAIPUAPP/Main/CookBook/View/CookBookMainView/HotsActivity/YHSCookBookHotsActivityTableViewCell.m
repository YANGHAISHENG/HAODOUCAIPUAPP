//
//  YHSCookBookHotsActivityTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsActivityTableViewCell.h"
#import "YHSCookBookHotsActivityModel.h"


NSString * const CELL_IDENTIFIER_HOTS_ACTIVITY = @"YHSCookBookHotsActivityTableViewCellID";

@interface YHSCookBookHotsActivityTableViewCell ()

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;


@end


@implementation YHSCookBookHotsActivityTableViewCell


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
    self.publicContainerView =[[UIView alloc] init];
    [self.publicContainerView.layer setMasksToBounds:YES];
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
    
}


/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookHotsActivityModel *)model
{
    _model = model;
    
    // 内容是否为空
    if (!_model || !model.activityList.count) {
        return;
    }
    
    // Cell复用机制会出现阴影
    for(UIView *view in self.publicContainerView.subviews) {
        [view removeFromSuperview];
    }
    
    CGFloat margin = 10;
    
    // 详细根容器
    UIView *lastContainerView = nil;
    for (int i = 0; i < _model.activityList.count; i ++) {
        
        YHSCookBookHotsActivityElemModel *elem = _model.activityList[i];
        
        // 内容容器
        UIView *containerView = ({
            UIView *view = [[UIView alloc] init];
            [self.publicContainerView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.publicContainerView).offset(margin);
                make.right.equalTo(self.publicContainerView).offset(-margin);
                if (lastContainerView) {
                    make.top.equalTo(lastContainerView.mas_bottom);
                } else {
                    make.top.equalTo(self.publicContainerView.mas_top);
                }
            }];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressActivityViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [view addGestureRecognizer:tapGesture];
            [view setTag:i];

            view;
        });
        lastContainerView = containerView;
        
        // 图片
        UIImageView *imageView = ({
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView sd_setImageWithURL:[NSURL URLWithString:elem.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
            [containerView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(containerView);
                make.left.equalTo(containerView);
                make.width.equalTo(@120);
                make.height.equalTo(@80); // 为什么？
            }];
            
            imageView;
        });
        
        
        // 标题
        UILabel *titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [label setText:elem.Title];
            [label setNumberOfLines:0];
            [label setTextColor:[UIColor blackColor]];
            [label setFont:[UIFont systemFontOfSize:15]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [containerView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView.mas_top);
                make.left.equalTo(imageView.mas_right).offset(margin/2.0);
                make.right.equalTo(containerView.mas_right).offset(0.0);
                make.height.greaterThanOrEqualTo(@(20));
            }];
            
            label;
        });
        
        
        // 内容
        {
            UILabel *label = [[UILabel alloc] init];
            [label setText:elem.Intro];
            [label setNumberOfLines:0];
            [label setTextColor:[UIColor lightGrayColor]];
            [label setFont:[UIFont systemFontOfSize:13]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [containerView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleLabel.mas_bottom).offset(margin/2.0);
                make.left.equalTo(imageView.mas_right).offset(margin/2.0);
                make.right.equalTo(containerView.mas_right).offset(0.0);
                make.height.greaterThanOrEqualTo(@(20));
                make.height.lessThanOrEqualTo(imageView.mas_height).multipliedBy(1.0/2.0);
            }];
        }
        
        // 内容主容器
        [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(imageView.mas_bottom).offset(margin);
        }];
        
    }
    
    // 详细根容器
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(lastContainerView.mas_bottom);
    }];
    
}


#pragma mark - 触发操作事件

- (void)pressActivityViewArea:(UITapGestureRecognizer *)gesture
{
    
    UIView *view = (UIView*)gesture.view;
    NSUInteger index = view.tag;

    YHSCookBookHotsActivityElemModel *model = self.model.activityList[index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithHotsActivityModel:)]) {
        [self.delegate didClickElementOfCellWithHotsActivityModel:model];
    }
    
}




@end
