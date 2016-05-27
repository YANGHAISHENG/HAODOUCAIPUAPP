//
//  YHSCookBookHotsAlbumTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/12.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsAlbumTableViewCell.h"
#import "YHSCookBookHotsAlbumModel.h"


NSString * const CELL_IDENTIFIER_HOTS_ALBUM = @"YHSCookBookHotsAlbumTableViewCellID";

@interface YHSCookBookHotsAlbumTableViewCell ()
/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 热门专辑
 */
@property (nonnull, nonatomic, strong) NSMutableArray<UILabel *> *albumTitleLabels;
@property (nonnull, nonatomic, strong) NSMutableArray<UILabel *> *albumImageRecipeLabels;
@property (nonnull, nonatomic, strong) NSMutableArray<UIImageView *> *albumImageViews;
@property (nonnull, nonatomic, strong) NSMutableArray<NSMutableArray<UIImageView *> *> *albumSmallImageViews;
@end


@implementation YHSCookBookHotsAlbumTableViewCell

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
    [self.rootContainerView addSubview:self.publicContainerView];
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
    
    // 公共容器组件
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
    }];

    // 两大部分组件
    {
        CGFloat margin = 10.0;
        CGFloat margin_mid = 8.0;
        CGFloat titleLabelHeight = 30;
        CGFloat containerViewWidth = (SCREEN_WIDTH-2.0*margin-margin_mid) / 2.0;
        CGFloat containerViewHeight = 160;
        
        _albumTitleLabels = [NSMutableArray<UILabel *> arrayWithCapacity:2];
        _albumImageRecipeLabels = [NSMutableArray<UILabel *> arrayWithCapacity:2];
        _albumImageViews = [NSMutableArray<UIImageView *> arrayWithCapacity:2];
        _albumSmallImageViews = [NSMutableArray<NSMutableArray<UIImageView *> *> arrayWithCapacity:2];
        
        UIView *lastContainerView = nil;
        NSArray<NSNumber *> *containerViewTags = @[@501, @502];
        for (int index = 0; index < containerViewTags.count; index ++) {
            
            // 容器
            UIView *containerView = [[UIView alloc] init];
            [self.publicContainerView addSubview:containerView];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressHotsAlbumViewArea:)];
            tapGesture.numberOfTapsRequired = 1;
            tapGesture.numberOfTouchesRequired = 1;
            [containerView addGestureRecognizer:tapGesture];
            [containerView setTag:containerViewTags[index].intValue];

            [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.publicContainerView).offset(0.0);
                make.width.equalTo(@(containerViewWidth));
                make.height.equalTo(@(containerViewHeight));
                
                if (lastContainerView) {
                    make.left.equalTo(lastContainerView.mas_right).offset(margin_mid);
                } else {
                    make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
                }
            }];
            
            lastContainerView = containerView;

            
            // 主图片
            UIImageView *imageView = ({
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, containerViewWidth-35, containerViewHeight-titleLabelHeight-margin)];
                [containerView addSubview:imageView];
                [imageView setUserInteractionEnabled:YES];
                [imageView.layer setMasksToBounds:YES];
                
                // 单边圆角
                UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds
                                                               byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                                     cornerRadii:CGSizeMake(5, 5)];
                CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
                maskLayer.frame = imageView.bounds;
                maskLayer.path = maskPath.CGPath;
                imageView.layer.mask = maskLayer;
                
                imageView;
            });
            [self.albumImageViews addObject:imageView];

            // 主图片上的透明标题
            UILabel *imgRecipeLabel = ({
                UILabel *label = [[UILabel alloc] init];
                [containerView addSubview:label];
                [label setTextColor:[UIColor whiteColor]];
                [label setFont:[UIFont boldSystemFontOfSize:12]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label.layer setCornerRadius:5.0];
                [label.layer setMasksToBounds:YES];
                [label setBackgroundColor:[UIColor colorWithRed:0.49 green:0.71 blue:0.27 alpha:1.00]];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(imageView.mas_bottom).offset(-25);
                    make.centerX.equalTo(imageView.mas_centerX).offset(0);
                    make.bottom.equalTo(imageView.mas_bottom).offset(-margin/2.0);
                    make.width.greaterThanOrEqualTo(@50);
                }];
                
                label;
            });
            [self.albumImageRecipeLabels addObject:imgRecipeLabel];
            
            // 标题
            UILabel *titleLabel = ({
                UILabel *label = [[UILabel alloc] init];
                [containerView addSubview:label];
                [label setTextColor:[UIColor blackColor]];
                [label setFont:[UIFont systemFontOfSize:14]];
                [label setTextAlignment:NSTextAlignmentCenter];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(imageView.mas_bottom).offset(0);
                    make.left.equalTo(containerView.mas_left).offset(0);
                    make.bottom.equalTo(containerView.mas_bottom).offset(-margin);
                    make.right.equalTo(containerView.mas_right).offset(0);
                }];
                
                label;
            });
            [self.albumTitleLabels addObject:titleLabel];

            
            // 小图片列表
            UIImageView *lastImageView = nil;
            NSMutableArray<UIImageView *> *smallImageViews = [NSMutableArray<UIImageView *> arrayWithCapacity:3];
            for (int i = 0; i < 3; i ++) {
                
                UIImageView *smallImageView = [[UIImageView alloc] init];
                [smallImageView.layer setBorderWidth:0.5];
                [smallImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
                [smallImageView.layer setCornerRadius:3.0];
                [smallImageView.layer setMasksToBounds:YES];
                [containerView addSubview:smallImageView];
                
                [smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageView.mas_right).offset(0.5);
                    make.right.equalTo(containerView);
                    make.height.equalTo(imageView.mas_height).multipliedBy(1.0/3.0);
                    if (lastImageView) {
                        make.top.equalTo(lastImageView.mas_bottom);
                    } else {
                        make.top.equalTo(imageView.mas_top);
                    }
                }];
                
                lastImageView = smallImageView;
                
                [smallImageViews addObject:smallImageView];
            }
            [self.albumSmallImageViews addObject:smallImageViews];
            
        }
        
        // 公共容器组件
        [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastContainerView.mas_bottom);
        }];
        
    }

}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookHotsAlbumModel *)model {
    
    _model = model;
    
    // 热门专辑
    [_model.albumElemModelList enumerateObjectsUsingBlock:^(YHSCookBookAlbumElemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 主图片
        [_albumImageViews[idx] sd_setImageWithURL:[NSURL URLWithString:obj.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        
        // 主图片上透明标题
        CGFloat titleWidth = 10;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]};
        CGSize size = [obj.Recipe boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                               options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:attributes
                                               context:nil].size;
        titleWidth += size.width;
        _albumImageRecipeLabels[idx].text = obj.Recipe;
        [_albumImageRecipeLabels[idx] mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.greaterThanOrEqualTo(@(titleWidth));
        }];
        
        // 标题
        _albumTitleLabels[idx].text = obj.Title;
        
        // 小图片列表
        [obj.albumSmallModelList enumerateObjectsUsingBlock:^(YHSCookBookAlbumSmallModel * _Nonnull objSmall, NSUInteger idxSmall, BOOL * _Nonnull stopSmall) {
           [_albumSmallImageViews[idx][idxSmall] sd_setImageWithURL:[NSURL URLWithString:objSmall.Cover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        }];
        
    }];
}


#pragma mark - 触发操作事件
/** 点击分类操作 */
- (void)pressHotsAlbumViewArea:(UITapGestureRecognizer *)gesture {
    
    YHSLogLight(@"%s", __FUNCTION__);
    
    UIView *view = (UIView*)gesture.view;
    NSUInteger index = view.tag - 501;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithHotsAlbumModel:)]) {
        [self.delegate didClickElementOfCellWithHotsAlbumModel:self.model.albumElemModelList[index]];
    }
    
}



@end
