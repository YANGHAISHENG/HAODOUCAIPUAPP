//
//  YHSCookBookGoodsTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookGoodsTableViewCell.h"
#import "YHSCookBookGoodsModel.h"
#import "Masonry.h"
#import "UIView+MasonryAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "YHSSysConst.h"
#import "YHSSysMacro.h"
#import "YHSUtilsMacro.h"

NSString * const CELL_IDENTIFIER_GOODS = @"YHSCookBookGoodsTableViewCellID";

@interface YHSCookBookGoodsTableViewCell ()
/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;
/**
 * 到家商品组件
 */
@property (nonnull, nonatomic, strong) UIView *goodsContainerView;
@property (nonnull, nonatomic, strong) NSMutableArray<UIView *> *goodsViews;
@property (nonnull, nonatomic, strong) NSMutableArray<UIImageView *> *goodsImageView;
@property (nonnull, nonatomic, strong) NSMutableArray<UILabel *> *goodsTitleLabels;
@property (nonnull, nonatomic, strong) NSMutableArray<UILabel *> *goodsSubTitleLabels;

@end


@implementation YHSCookBookGoodsTableViewCell

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
    
    // 到家商品组件
    self.goodsContainerView =[[UIView alloc] init];
    [self.rootContainerView addSubview:self.goodsContainerView];
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    // 根容器组件
    {
        [self.rootContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).with.offset(0);
        }];
    }
    
    // 到家商品组件
    {
        CGFloat goodsViewHeight = 130.0;
        CGFloat goodsViewWidth = SCREEN_WIDTH / 4.0;
        
        [self.goodsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
        }];
        
        CGFloat titleHeight = 20;
        CGFloat titleFontSize = 12;
        _goodsViews = [NSMutableArray arrayWithCapacity:4];
        _goodsImageView = [NSMutableArray arrayWithCapacity:4];
        _goodsTitleLabels = [NSMutableArray arrayWithCapacity:4];
        _goodsSubTitleLabels = [NSMutableArray arrayWithCapacity:4];
        NSArray<NSNumber *> *goodsViewTags = @[@501, @502, @503, @504];
        for (int index = 0; index < goodsViewTags.count; index ++) {
            // 容器
            UIView *goodsView = [[UIView alloc] init];
            [self.goodsContainerView addSubview:goodsView];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressGoodsViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [goodsView addGestureRecognizer:tapGesture];
            [goodsView setTag:goodsViewTags[index].intValue];
            
            // 主标题
            UILabel *titleLabel = ({
                UILabel *label = [[UILabel alloc] init];
                [goodsView addSubview:label];
                [label setTextColor:[UIColor blackColor]];
                [label setFont:[UIFont systemFontOfSize:titleFontSize]];
                [label setTextAlignment:NSTextAlignmentCenter];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(goodsView.mas_top).offset(10);
                    make.left.equalTo(goodsView.mas_left).offset(0);
                    make.right.equalTo(goodsView.mas_right).offset(0);
                    make.height.equalTo(@(titleHeight));
                }];
                
                label;
            });
            
            // 次标题
            UILabel *subTitleLabel = ({
                UILabel *label = [[UILabel alloc] init];
                [goodsView addSubview:label];
                [label setTextColor:[UIColor redColor]];
                [label setFont:[UIFont systemFontOfSize:titleFontSize]];
                [label setTextAlignment:NSTextAlignmentCenter];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(titleLabel.mas_bottom).offset(0);
                    make.left.equalTo(goodsView.mas_left).offset(0);
                    make.right.equalTo(goodsView.mas_right).offset(0);
                    make.height.equalTo(@(titleHeight));
                }];
                
                label;
            });

            // 图片
            UIImageView *imageView = ({
                UIImageView *imageView = [[UIImageView alloc] init];
                [imageView.layer setMasksToBounds:YES];
                [goodsView addSubview:imageView];
                
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(subTitleLabel.mas_bottom).offset(10.0);
                    make.centerX.equalTo(goodsView.mas_centerX).offset(0);
                    make.width.equalTo(goodsView.mas_width).multipliedBy(0.6);
                    make.height.equalTo(goodsView.mas_width).multipliedBy(0.6);
                }];
                
                imageView;
            });

            // 存储
            [_goodsViews addObject:goodsView];
            [_goodsImageView addObject:imageView];
            [_goodsTitleLabels addObject:titleLabel];
            [_goodsSubTitleLabels addObject:subTitleLabel];
        }
        
        // 水平布局toolViews容器
        [self.goodsViews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.goodsContainerView.mas_top).offset(0);
            make.centerY.equalTo(@[weakSelf.goodsViews[1], weakSelf.goodsViews[2], weakSelf.goodsViews[3]]);
            make.size.equalTo(@[weakSelf.goodsViews[1], weakSelf.goodsViews[2], weakSelf.goodsViews[3]]);
            make.size.mas_equalTo(CGSizeMake(goodsViewWidth, goodsViewHeight));
        }];
        [self.goodsContainerView distributeSpacingHorizontallyWith:weakSelf.goodsViews];
        
        
        // 公共容器组件
        [self.goodsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.goodsViews[0].mas_bottom);
        }];
    }
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookGoodsModel *)model
{
    _model = model;

    // 到家商品组件
    [_model.goodElemList enumerateObjectsUsingBlock:^(YHSCookBookGoodsElemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [_goodsTitleLabels[idx] setText:obj.Title];
        
        [_goodsSubTitleLabels[idx] setText:obj.SubTitle];
        
        [_goodsImageView[idx] sd_setImageWithURL:[NSURL URLWithString:obj.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        
    }];

}


#pragma mark - 触发操作事件

- (void)pressGoodsViewArea:(UITapGestureRecognizer *)gesture
{

    UIView *view = (UIView*)gesture.view;
    NSUInteger index = view.tag - 501;
    
    YHSLogLight(@"%s %@", __FUNCTION__, self.model.goodElemList[index].Title);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithGoodsElemModel:)]) {
        [self.delegate didClickElementOfCellWithGoodsElemModel:self.model.goodElemList[index]];
    }
    
}



@end
