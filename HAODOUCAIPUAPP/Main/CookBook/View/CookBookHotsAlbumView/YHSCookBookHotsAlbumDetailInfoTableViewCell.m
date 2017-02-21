//
//  YHSCookBookHotsAlbumDetailInfoTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsAlbumDetailInfoTableViewCell.h"
#import "YHSCookBookHotsAlbumDetailInfoModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_HOTS_ALBUM_DETAIL_INFO = @"YHSCookBookHotsAlbumDetailInfoTableViewCellID";

@interface YHSCookBookHotsAlbumDetailInfoTableViewCell ()

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
@property (nonnull, nonatomic, strong) UIImageView *albumCoverImageView;
@property (nonnull, nonatomic, strong) UIView *albumCoverImageAplhaView;

/**
 * 标题
 */
@property (nonnull, nonatomic, strong) UILabel *titleLabel;

/**
 * 作者
 */
@property (nonatomic, assign) CGFloat userAvatarSize;
@property (nonnull, nonatomic, strong) UIImageView *userAvatarImageView;
@property (nonnull, nonatomic, strong) UILabel *userNameLabel;


@end

@implementation YHSCookBookHotsAlbumDetailInfoTableViewCell

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
        self.albumCoverImageView = [UIImageView new];
        [self.albumCoverImageView.layer setMasksToBounds:YES];
        [self.albumCoverImageView setUserInteractionEnabled:YES];
        [self.publicContainerView addSubview:self.albumCoverImageView];
        
        // 透明层
        self.albumCoverImageAplhaView = [UIView new];
        [self.albumCoverImageAplhaView.layer setMasksToBounds:YES];
        [self.albumCoverImageAplhaView setUserInteractionEnabled:YES];
        [self.albumCoverImageAplhaView setBackgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:0.30]];
        [self.albumCoverImageView addSubview:self.albumCoverImageAplhaView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressAlbumAvatarViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.albumCoverImageAplhaView addGestureRecognizer:tapGesture];
    }
    
    // 标题
    self.titleLabel = [UILabel new];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.albumCoverImageAplhaView addSubview:self.titleLabel];
    
    // 作者
    {
        _userAvatarSize = 35.0;
        self.userAvatarImageView = [UIImageView new];
        [self.userAvatarImageView.layer setMasksToBounds:YES];
        [self.userAvatarImageView setUserInteractionEnabled:YES];
        [self.userAvatarImageView.layer setCornerRadius:_userAvatarSize/2.0];
        [self.albumCoverImageAplhaView addSubview:self.userAvatarImageView];
        
        self.userNameLabel = [UILabel new];
        [self.userNameLabel setTextColor:[UIColor whiteColor]];
        [self.userNameLabel setFont:[UIFont systemFontOfSize:17.0]];
        [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.albumCoverImageAplhaView addSubview:self.userNameLabel];
    }

    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10.0;
    CGFloat coverImageHeight = 160.0;
    CGFloat tagLabelHeight = 25.0;
    
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
    [self.albumCoverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(0.0);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(0.0);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(0.0);
        make.height.equalTo(@(coverImageHeight));
    }];
    
    // 透明层
    [self.albumCoverImageAplhaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.albumCoverImageView);
    }];
    
    // 标题
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.albumCoverImageAplhaView.mas_centerY).offset(-tagLabelHeight/2.0);
        make.left.equalTo(weakSelf.albumCoverImageAplhaView.mas_left).offset(0.0);
        make.right.equalTo(weakSelf.albumCoverImageAplhaView.mas_right).offset(0.0);
        make.height.greaterThanOrEqualTo(@(tagLabelHeight));
    }];
    
    // 作者
    {
        [self.userAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.albumCoverImageAplhaView.mas_centerY).offset(margin+self.userAvatarSize/2.0);
            make.centerX.equalTo(weakSelf.albumCoverImageAplhaView.mas_centerX).offset(-self.userAvatarSize);
            make.size.mas_equalTo(CGSizeMake(self.userAvatarSize, self.userAvatarSize));
        }];
        
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.userAvatarImageView.mas_centerY);
            make.left.equalTo(weakSelf.userAvatarImageView.mas_right).offset(5.0);
            make.right.equalTo(weakSelf.albumCoverImageAplhaView.mas_right).offset(-margin);
            make.height.greaterThanOrEqualTo(@(tagLabelHeight));
        }];
    }
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.albumCoverImageView.mas_bottom).offset(margin);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookHotsAlbumDetailInfoModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 图片
    [_albumCoverImageView sd_setImageWithURL:[NSURL URLWithString:_model.AlbumCover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 标题
    [_titleLabel setText:_model.AlbumTitle];
    
    // 作者
    {
        [_userAvatarImageView sd_setImageWithURL:[NSURL URLWithString:_model.AlbumAvatarUrl] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        
        [_userNameLabel setText:_model.AlbumUserName];
        
        
        {
            WEAKSELF(weakSelf);
            
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]};
            CGSize size = [_model.AlbumUserName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:attributes
                                                             context:nil].size;
            CGFloat userNmaeWidth = size.width + _userAvatarSize + 5.0;
            
            [self.userAvatarImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(weakSelf.albumCoverImageAplhaView.mas_centerX).offset(-userNmaeWidth/2.0);
            }];
        }
    }
    

}



#pragma mark - 触发操作事件

- (void)pressAlbumAvatarViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithHotsAlbumDetailInfoModel:)]) {
        [self.delegate didClickElementOfCellWithHotsAlbumDetailInfoModel:self.model];
    }
    
}


@end
