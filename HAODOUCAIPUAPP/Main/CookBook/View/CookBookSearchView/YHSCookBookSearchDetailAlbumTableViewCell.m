//
//  YHSCookBookSearchDetailAlbumTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/20.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "Masonry.h"
#import "UIImageView+WebCache.h"

#import "YHSCookBookSearchDetailAlbumTableViewCell.h"
#import "YHSCookBookSearchDetailAlbumModel.h"
#import "YHSSysConst.h"
#import "YHSSysMacro.h"
#import "YHSUtilsMacro.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_SEARCH_DETAIL_ALBUM = @"YHSCookBookSearchDetailAlbumTableViewCellID";


@interface YHSCookBookSearchDetailAlbumTableViewCell ()

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 图片
 */
@property (nonnull, nonatomic, strong) UIImageView *coverImageView;

/**
 * 菜的总数
 */
@property (nonnull, nonatomic, strong) UIView *alphaView;
@property (nonnull, nonatomic, strong) UILabel *recipeCountLabel;

/**
 * 标题
 */
@property (nonnull, nonatomic, strong) UILabel *titleLabel;

/**
 * 收藏总数/浏览总数
 */
@property (nonnull, nonatomic, strong) UILabel *collectionLabel;

/**
 * 详情
 */
@property (nonnull, nonatomic, strong) UILabel *introLabel;

/**
 * 分割线
 */
@property (nonnull, nonatomic, strong) UIView *separatorLineView;

@end


@implementation YHSCookBookSearchDetailAlbumTableViewCell

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
    {
        self.publicContainerView =[[UIView alloc] init];
        [self.publicContainerView.layer setMasksToBounds:YES];
        [self.rootContainerView addSubview:self.publicContainerView];
        
        // 点击手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressPublicContainerArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.publicContainerView addGestureRecognizer:tapGesture];
    }
    
    // 图片
    self.coverImageView = [UIImageView new];
    [self.coverImageView.layer setCornerRadius:3.0];
    [self.coverImageView.layer setMasksToBounds:YES];
    [self.coverImageView setUserInteractionEnabled:YES];
    [self.publicContainerView addSubview:self.coverImageView];

    // 透明层
    self.alphaView = [UIView new];
    [self.alphaView.layer setCornerRadius:3.0];
    [self.alphaView.layer setMasksToBounds:YES];
    [self.alphaView setUserInteractionEnabled:YES];
    [self.alphaView setBackgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:0.30]];
    [self.coverImageView addSubview:self.alphaView];
    
    // 专辑
    NSString *imageTypeName = @" 专辑";
    UILabel *imageType = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 33, 20)];
    [imageType setText:imageTypeName];
    [imageType setTextColor:[UIColor whiteColor]];
    [imageType setFont:[UIFont boldSystemFontOfSize:13]];
    [imageType setTextAlignment:NSTextAlignmentLeft];
    [imageType setBackgroundColor:[UIColor colorWithRed:0.49 green:0.71 blue:0.27 alpha:1.00]];
    [self.alphaView addSubview:imageType];
    
    // 菜的总数
    self.recipeCountLabel = [[UILabel alloc] init];
    [self.recipeCountLabel setTextColor:[UIColor whiteColor]];
    [self.recipeCountLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [self.recipeCountLabel setTextAlignment:NSTextAlignmentLeft];
    [self.alphaView addSubview:self.recipeCountLabel];
    
    // 标题
    self.titleLabel = [UILabel new];
    [self.titleLabel setUserInteractionEnabled:YES];
    [self.titleLabel setNumberOfLines:0];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.titleLabel];
    
    // 收藏总数/浏览总数
    self.collectionLabel = [UILabel new];
    [self.collectionLabel setUserInteractionEnabled:YES];
    [self.collectionLabel setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
    [self.collectionLabel setFont:[UIFont systemFontOfSize:15]];
    [self.collectionLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.collectionLabel];
    
    // 详情
    self.introLabel = [UILabel new];
    [self.introLabel setUserInteractionEnabled:YES];
    [self.introLabel setTextColor:[UIColor colorWithRed:0.56 green:0.56 blue:0.57 alpha:1.00]];
    [self.introLabel setNumberOfLines:0];
    [self.introLabel setFont:[UIFont systemFontOfSize:17]];
    [self.introLabel setTextAlignment:NSTextAlignmentLeft];
    [self.publicContainerView addSubview:self.introLabel];
    
    // 分割线
    self.separatorLineView =[[UIView alloc] init];
    [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    [self.rootContainerView addSubview:self.separatorLineView];
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10;
    
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
    
    // 图片
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(margin/2.0);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    
    // 透明层
    [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.coverImageView);
    }];
    
    // 菜的总数
    CGFloat recipeCountHeight = 10.0;
    [self.recipeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.alphaView.mas_bottom).offset(-margin-recipeCountHeight);
        make.left.equalTo(weakSelf.alphaView.mas_left).offset(margin);
        make.right.equalTo(weakSelf.coverImageView.mas_right).offset(margin);
        make.height.equalTo(@(recipeCountHeight));
    }];
    
    // 标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageView.mas_top);
        make.left.equalTo(weakSelf.coverImageView.mas_right).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
    }];
    
    // 收藏总数/浏览总数
    [self.collectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom);
        make.left.equalTo(weakSelf.coverImageView.mas_right).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
    }];
    
    // 详情
    [self.introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.collectionLabel.mas_bottom);
        make.left.equalTo(weakSelf.coverImageView.mas_right).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.bottom.equalTo(weakSelf.publicContainerView.mas_bottom).offset(-margin);
        make.height.lessThanOrEqualTo(@(35));
    }];
    
    // 分割线
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageView.mas_bottom).offset(margin);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(0.0);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(0.0);
        make.height.equalTo(@(1.0));
    }];
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.separatorLineView.mas_bottom).offset(0.0);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookSearchDetailAlbumModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 图片
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.Cover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 菜数
    [_recipeCountLabel setText:[NSString stringWithFormat:@"%ld道菜", _model.RecipeCount]];
    
    // 标题
    [_titleLabel setText:_model.Title];
    
    
    // 播放时长/收藏总数/浏览总数
    [_collectionLabel setText:_model.Collection];
    
    // 详情
    [_introLabel setText:_model.Intro];
    
}

#pragma mark - 触发操作事件

- (void)pressPublicContainerArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookSearchDetailAlbumModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookSearchDetailAlbumModel:self.model];
    }
    
}



@end
