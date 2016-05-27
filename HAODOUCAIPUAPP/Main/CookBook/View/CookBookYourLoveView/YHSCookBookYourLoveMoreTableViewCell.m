//
//  YHSCookBookYourLoveMoreTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/19.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookYourLoveMoreTableViewCell.h"
#import "YHSCookBookYourLoveMoreModel.h"


NSString * const CELL_IDENTIFIER_YOUR_LOVE_MORE = @"YHSCookBookYourLoveMoreTableViewCellID";


@interface YHSCookBookYourLoveMoreTableViewCell ()

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
@property (nonnull, nonatomic, strong) UIView *coverImageAplhaView;

/**
 * 点赞
 */
@property (nonatomic, assign) CGFloat likeCountImageSize;
@property (nonatomic, assign) CGFloat likeCountLableWidth;
@property (nonnull, nonatomic, strong) UIView *likeCountView;
@property (nonnull, nonatomic, strong) UIImageView *likeCountImageView;
@property (nonnull, nonatomic, strong) UILabel *likeCountLabel;

/**
 * 标题
 */
@property (nonnull, nonatomic, strong) UILabel *titleLabel;

/**
 * 作者
 */
@property (nonnull, nonatomic, strong) UILabel *userNameLabel;

/**
 * 底部标签
 */
@property (nonnull, nonatomic, strong) UIView *tagsContainerView;
@property (nonnull, nonatomic, strong) UIImageView *tagImageView;
@property (nonnull, nonatomic, strong) UIView *tagContainerView;

@end


@implementation YHSCookBookYourLoveMoreTableViewCell


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
    
    // 图片
    {
        self.coverImageView = [UIImageView new];
        [self.coverImageView.layer setMasksToBounds:YES];
        [self.coverImageView setUserInteractionEnabled:YES];
        [self.publicContainerView addSubview:self.coverImageView];
        
        // 透明层
        self.coverImageAplhaView = [UIView new];
        [self.coverImageAplhaView.layer setMasksToBounds:YES];
        [self.coverImageAplhaView setUserInteractionEnabled:YES];
        [self.coverImageAplhaView setBackgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:0.30]];
        [self.coverImageView addSubview:self.coverImageAplhaView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressCoverImageViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.coverImageAplhaView addGestureRecognizer:tapGesture];
    }
    
    // 标题
    self.titleLabel = [UILabel new];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.coverImageAplhaView addSubview:self.titleLabel];
 
    // 作者
    self.userNameLabel = [UILabel new];
    [self.userNameLabel setTextColor:[UIColor whiteColor]];
    [self.userNameLabel setFont:[UIFont systemFontOfSize:16]];
    [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [self.coverImageAplhaView addSubview:self.userNameLabel];
    
    // 点赞
    {
        _likeCountImageSize = 45.0;
        self.likeCountView = [UIView new];
        [self.likeCountView.layer setMasksToBounds:YES];
        [self.likeCountView.layer setCornerRadius:_likeCountImageSize/2.0];
        [self.likeCountView setBackgroundColor:[UIColor whiteColor]];
        [self.coverImageAplhaView addSubview:self.likeCountView];
        
        self.likeCountImageView = [UIImageView new];
        [self.likeCountImageView setUserInteractionEnabled:YES];
        [self.likeCountView addSubview:self.likeCountImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressLikeCountImageViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.likeCountImageView addGestureRecognizer:tapGesture];
        
        self.likeCountLabel = [UILabel new];
        [self.likeCountLabel setTextColor:[UIColor whiteColor]];
        [self.likeCountLabel setFont:[UIFont systemFontOfSize:12]];
        [self.likeCountLabel setTextAlignment:NSTextAlignmentCenter];
        [self.coverImageAplhaView addSubview:self.likeCountLabel];
    }
    
    // 标签容器
    self.tagsContainerView = [UIView new];
    [self.publicContainerView addSubview:self.tagsContainerView];
    
    // 标签图标
    self.tagImageView = [UIImageView new];
    [self.coverImageView.layer setMasksToBounds:YES];
    [self.tagsContainerView addSubview:self.tagImageView];
    
    // 标签
    self.tagContainerView = [UIView new];
    [self.tagsContainerView addSubview:self.tagContainerView];
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10;
    CGFloat coverImageHeight = 200.0;
    CGFloat tagLabelHeight = 25.0;
    CGFloat tagImageSize = 20.0;
    CGFloat likeImageSize = 45.0;
    
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
        make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(margin);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.height.equalTo(@(coverImageHeight));
    }];
    
    // 透明层
    [self.coverImageAplhaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.coverImageView);
    }];
    
    // 标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageAplhaView.mas_bottom).offset(-60.0);
        make.left.equalTo(weakSelf.coverImageAplhaView.mas_left).offset(margin);
        make.right.equalTo(weakSelf.coverImageAplhaView.mas_right).offset(-margin);
        make.height.greaterThanOrEqualTo(@(tagLabelHeight));
    }];
    
    // 作者
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageAplhaView.mas_bottom).offset(-30.0);
        make.left.equalTo(weakSelf.coverImageAplhaView.mas_left).offset(margin);
        make.right.equalTo(weakSelf.likeCountLabel.mas_left).offset(-margin);
        make.height.greaterThanOrEqualTo(@(tagLabelHeight));
    }];
    
    // 点赞
    {
        [self.likeCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.titleLabel.mas_bottom).offset(margin/2.0);
            make.right.equalTo(weakSelf.coverImageAplhaView.mas_right).offset(-margin/2.0);
            make.size.mas_equalTo(CGSizeMake(likeImageSize, likeImageSize));
        }];
        
        [self.likeCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.likeCountView);
        }];
        
        _likeCountLableWidth = 55.0;
        [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.userNameLabel.mas_top).offset(0.0);
            make.bottom.equalTo(weakSelf.userNameLabel.mas_bottom).offset(0.0);
            make.right.equalTo(weakSelf.coverImageAplhaView.mas_right).offset(0.0);
            make.width.equalTo(@(_likeCountLableWidth));
        }];
    }
    
    // 标签容器
    [self.tagsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageView.mas_bottom).offset(0.0);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(margin);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(-margin);
        make.height.equalTo(@(tagLabelHeight));
    }];
    
    // 标签图标
    [self.tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tagsContainerView.mas_top).offset((tagLabelHeight-tagImageSize));
        make.left.equalTo(weakSelf.tagsContainerView.mas_left).offset(0.0);
        make.size.mas_equalTo(CGSizeMake(tagImageSize, tagImageSize));
    }];
    
    // 所有标签
    [self.tagContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tagsContainerView.mas_top).offset(0.0);
        make.left.equalTo(weakSelf.tagImageView.mas_right).offset(0.0);
        make.bottom.equalTo(weakSelf.tagsContainerView.mas_bottom).offset(0.0);
        make.right.equalTo(weakSelf.tagsContainerView.mas_right).offset(0.0);
    }];
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.tagsContainerView.mas_bottom).offset(margin);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookYourLoveMoreModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    WEAKSELF(weakSelf);
    
    // 图片
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.Cover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 视屏标记图标
    for (UIView *view in _coverImageAplhaView.subviews) {
        if (1000 == view.tag) {
            [view removeFromSuperview];
        }
    }
    if (_model.HasVideo) {
        
        CGFloat size = 40.0;
        CGFloat margin = 5.0;
        
        UIImageView *videoImageView = [UIImageView new];
        [videoImageView setTag:1000];
        [videoImageView setImage:[UIImage imageNamed:@"ico_video"]];
        [_coverImageAplhaView addSubview:videoImageView];
        
        [videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.coverImageAplhaView.mas_top).offset(margin);
            make.right.equalTo(weakSelf.coverImageAplhaView.mas_right).offset(-margin);
            make.size.mas_equalTo(CGSizeMake(size, size));
        }];
    }
    
    
    // 标题
    [_titleLabel setText:_model.Title];
    
    // 作者
    [_userNameLabel setText:[NSString stringWithFormat:@"by  %@", _model.UserName]];
    
    // 点赞
    NSString *likeCount = [NSString stringWithFormat:@"%ld", _model.LikeCount];
    [_likeCountLabel setText:likeCount];
    [_likeCountImageView setImage:[UIImage imageNamed:@"btn_auxiliary_good_on"]];
    if (_model.LikeCount > 9999999) {
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGSize size = [likeCount boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:attributes
                                              context:nil].size;
        [self.likeCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(size.width+10));
        }];
    } else {
        [self.likeCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(_likeCountLableWidth));
        }];
    }
    
    // 标签图标
    [_tagImageView setImage:[UIImage imageNamed:@"ico_tag"]];
    
    // 标签
    {
        for (UIView *tagLabel in self.tagContainerView.subviews) {
            [tagLabel removeFromSuperview];
        }
        
        CGFloat margin = 10.0;
        __block CGFloat lineTagsWidth = 0.0; // 记录一行标签宽度和
        UILabel *lastTag = nil;
        for (int index = 0; index < self.model.Tags.count; index ++) {
            
            YHSCookBookYourLoveMoreTagModel *tag = self.model.Tags[index];
            
            UILabel *tagLabel = ({
                UILabel *label = [[UILabel alloc] init];
                [label setTag:index+1000];
                [label setText:tag.Name];
                [label.layer setMasksToBounds:YES];
                [label setUserInteractionEnabled:YES];
                [label setTextAlignment:NSTextAlignmentLeft];
                [label setFont:[UIFont systemFontOfSize:14.0]];
                [self.tagContainerView addSubview:label];
                
                // 点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressTagOfLabel:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [label addGestureRecognizer:tapGesture];
                
                // 标签宽度
                CGFloat labelWidth = 10.0;
                CGFloat labelHeight = 25.0;
                NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]};
                CGSize size = [tag.Name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                  attributes:attributes
                                                     context:nil].size;
                labelWidth += size.width;
                
                // 计算一行标签宽度和
                lineTagsWidth += labelWidth + margin;
                
                // 标签位置
                if (lineTagsWidth < SCREEN_WIDTH - margin*3 - 20) { // 10+20+10+X+10
                    
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.width.equalTo(@(labelWidth));
                        make.height.equalTo(@(labelHeight));
                        
                        if (lastTag) {
                            make.top.equalTo(lastTag.mas_top).offset(0.0);
                            make.left.equalTo(lastTag.mas_right).offset(margin);
                        } else {
                            make.top.equalTo(weakSelf.tagContainerView.mas_top).offset(margin/2.0);
                            make.left.equalTo(weakSelf.tagContainerView.mas_left).offset(margin);
                        }
                    }];
                    
                } else {
                    
                    break;
                    
                }
                
                label;
            });
            
            // 记录上一个分类标签
            lastTag = tagLabel;
            
        }
    }

}


#pragma mark - 触发操作事件

- (void)pressCoverImageViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithYourLoveMoreModel:)]) {
        [self.delegate didClickElementOfCellWithYourLoveMoreModel:self.model];
    }
    
}

- (void)pressLikeCountImageViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellLikeCountWithYourLoveMoreModel:)]) {
        [self.delegate didClickElementOfCellLikeCountWithYourLoveMoreModel:self.model];
    }
    
}

- (void)pressTagOfLabel:(UITapGestureRecognizer *)gesture
{
    UILabel *label = (UILabel*)gesture.view;
    
    NSUInteger index = label.tag - 1000;
    
    if (index >= self.model.Tags.count) {
        YHSLogRed(@"数组越界，请检测代码。");
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithYourLoveMoreTagModel:)]) {
        [self.delegate didClickElementOfCellWithYourLoveMoreTagModel:self.model.Tags[index]];
    }
    
}

@end
