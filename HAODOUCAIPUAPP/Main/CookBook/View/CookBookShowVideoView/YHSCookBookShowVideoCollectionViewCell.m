//
//  YHSCookBookShowVideoCollectionViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookShowVideoCollectionViewCell.h"
#import "YHSCookBookShowVideoModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_SHOW_VIDEO_COLLECTION = @"YHSCookBookShowVideoCollectionViewCellID";


@interface YHSCookBookShowVideoCollectionViewCell ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 视屏图片
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIView *coverAplhaView;

// 标题
@property (nonatomic, strong) UILabel *titleLabel;

// 浏览数量
@property (nonatomic, strong) UIImageView *playCountBgImageView;
@property (nonatomic, strong) UIImageView *playCountVideoImageView;

@end


@implementation YHSCookBookShowVideoCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
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
            make.edges.equalTo(weakSelf.contentView);
        }];
        
        view;
    });
    self.rootContainerView = rootContainerView;
    
    // 视屏图片
    UIImageView *coverImageView = ({
        UIImageView *imageView = [UIImageView new];
        [imageView.layer setMasksToBounds:YES];
        [imageView setUserInteractionEnabled:YES];
        [rootContainerView addSubview:imageView];
        
        // 点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressImageViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [imageView addGestureRecognizer:tapGesture];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(rootContainerView);
        }];
        
        imageView;
    });
    self.coverImageView = coverImageView;
    
    // 透明层
    UIView *coverAplhaView = ({
        UIView *view = [UIView new];
        [view.layer setMasksToBounds:YES];
        [view setUserInteractionEnabled:YES];
        [view setBackgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:0.30]];
        [coverImageView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(coverImageView);
        }];
        
        view;
    });
    self.coverAplhaView = coverAplhaView;
    
    // 标题
    UILabel *titleLabel = ({
        UILabel *label = [UILabel new];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:16.0]];
        [label setTextAlignment:NSTextAlignmentLeft];
        [coverAplhaView addSubview:label];
        
        // 标题
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coverAplhaView.mas_bottom).offset(-25.0);
            make.left.equalTo(coverAplhaView.mas_left).offset(margin/2.0);
            make.right.equalTo(coverAplhaView.mas_right).offset(-margin/2.0);
        }];
        
        label;
    });
    self.titleLabel = titleLabel;
 
    // 浏览数量
    UIImageView *playCountBgImageView = ({
        UIImageView *imageView = [UIImageView new];
        [imageView.layer setMasksToBounds:YES];
        [imageView setUserInteractionEnabled:YES];
        [imageView setImage:[UIImage imageNamed:@"bg_vedio_small"]];
        [coverAplhaView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coverAplhaView.mas_top).offset(0.0);
            make.right.equalTo(coverAplhaView.mas_right).offset(0.0);
            make.size.mas_equalTo(CGSizeMake(153, 20));
        }];
        
        imageView;
    });
    self.playCountBgImageView = playCountBgImageView;
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookShowVideoModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }

    // 浏览数量
    {
        for (UIView *view in self.playCountBgImageView.subviews) {
            [view removeFromSuperview];
        }
     
        WEAKSELF(weakSelf);
        
        CGFloat margin = 10.0;
        
        // 标题
        UILabel *playCountLabel = ({
            
            NSString *playCount = [NSString stringWithFormat:@"%ld",model.PlayCount];
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]};
            CGSize size = [playCount boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:attributes
                                                  context:nil].size;
            
            UILabel *label = [UILabel new];
            [label setText:playCount];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:12.0]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [self.playCountBgImageView addSubview:label];
        
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf.playCountBgImageView.mas_centerY);
                make.right.equalTo(weakSelf.playCountBgImageView.mas_right).offset(-margin/2.0);
                make.size.mas_equalTo(size);
            }];
            
            label;
        });

        // 摄影机
        UIImageView *videoImageView = [UIImageView new];
        [videoImageView.layer setMasksToBounds:YES];
        [videoImageView setUserInteractionEnabled:YES];
        [videoImageView setImage:[UIImage imageNamed:@"ico_vedio_small"]];
        [self.playCountBgImageView addSubview:videoImageView];
        [videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.playCountBgImageView.mas_centerY);
            make.right.equalTo(playCountLabel.mas_left).offset(-margin/2.0);
            make.size.mas_equalTo(CGSizeMake(15, 10));
        }];

    }
    
    // 图片
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:model.Cover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 标题
    [_titleLabel setText:model.Title];
    
}



#pragma mark - 触发操作事件

- (void)pressImageViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookShowVideoModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookShowVideoModel:self.model];
    }
    
}




@end
