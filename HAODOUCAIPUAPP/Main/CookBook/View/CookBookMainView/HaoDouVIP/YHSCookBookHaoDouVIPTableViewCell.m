//
//  YHSCookBookHaoDouVIPTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHaoDouVIPTableViewCell.h"
#import "YHSCookBookHaoDouVIPModel.h"


NSString * const CELL_IDENTIFIER_HAODOU_VIP = @"YHSCookBookHaoDouVIPTableViewCellID";

@interface YHSCookBookHaoDouVIPTableViewCell ()

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;


@end


@implementation YHSCookBookHaoDouVIPTableViewCell

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
- (void)setModel:(YHSCookBookHaoDouVIPModel *)model
{
    _model = model;
    
    // 内容是否为空
    if (!_model || !model.vipList.count) {
        return;
    }
    
    // Cell复用机制会出现阴影
    for(UIView *view in self.publicContainerView.subviews) {
        [view removeFromSuperview];
    }

    // 常量
    CGFloat margin = 10.0;
    CGFloat imgWidth = 45.0;
    CGFloat containerViewHeight = 90.0;
    
    WEAKSELF(weakSelf);
    
    // 详细根容器
    UIView *lastContainerView = nil;
    for (int i = 0; i < _model.vipList.count; i ++) {
        
        YHSCookBookHaoDouVIPElemModel *elem = _model.vipList[i];
        
        // 内容容器
        UIView *containerView = ({
            UIView *view = [[UIView alloc] init];
            [self.publicContainerView addSubview:view];
            
            [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(weakSelf.publicContainerView.mas_width).multipliedBy(1.0/_model.vipList.count);
                make.height.equalTo(@(containerViewHeight));
                
                if (!lastContainerView) {
                    make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(0);
                    make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(0);
                } else {
                    if (i % _model.vipList.count == 0) { // 每行第一个
                        make.top.equalTo(lastContainerView.mas_bottom).offset(0);
                        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(0);
                    } else {
                        make.top.equalTo(lastContainerView.mas_top).offset(0);
                        make.left.equalTo(lastContainerView.mas_right).offset(0);
                    }
                }
            }];

            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressVIPViewArea:)];
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
            [imageView.layer setCornerRadius:imgWidth/2.0];
            [imageView.layer setMasksToBounds:YES];
            [imageView sd_setImageWithURL:[NSURL URLWithString:elem.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
            [containerView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(containerView.mas_top).offset(margin/2.0);
                make.centerX.equalTo(containerView.mas_centerX);
                make.width.equalTo(@(imgWidth));
                make.height.equalTo(@(imgWidth));
            }];
            
            imageView;
        });
        
        // 标题
        {
            UILabel *label = [[UILabel alloc] init];
            [label setText:elem.Title];
            [label setNumberOfLines:1];
            [label setTextColor:[UIColor blackColor]];
            [label setFont:[UIFont systemFontOfSize:12]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [containerView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView.mas_bottom).offset(margin/2.0);
                make.left.equalTo(containerView.mas_left);
                make.right.equalTo(containerView.mas_right);
                make.bottom.equalTo(imageView.mas_bottom).offset(margin/2.0+25);
            }];
            
        }
        
    }
    
    // 详细根容器
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastContainerView.mas_bottom);
    }];
    
}


#pragma mark - 触发操作事件

- (void)pressVIPViewArea:(UITapGestureRecognizer *)gesture
{
    
    UIView *view = (UIView*)gesture.view;
    NSUInteger index = view.tag;
    
    YHSCookBookHaoDouVIPElemModel *model = self.model.vipList[index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithHaoDouVIPModel:)]) {
        [self.delegate didClickElementOfCellWithHaoDouVIPModel:model];
    }
    
}



@end




