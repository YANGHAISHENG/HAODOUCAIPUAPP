//
//  YHSCookBookDishVideoPictureView.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/25.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDishVideoPictureView.h"
#import "YHSCookBookDishModel.h"


@interface YHSCookBookDishVideoPictureView ()

/**
 * 播放视屏
 */
@property (nonnull, nonatomic, strong) UIImageView *videoStartImageView;

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
@property (nonatomic, strong) UIView *likeCountView;
@property (nonatomic, strong) UIImageView *likeCountImageView;
@property (nonatomic, strong) UILabel *likeCountLabel;

@end

@implementation YHSCookBookDishVideoPictureView

- (instancetype)initWithFrame:(CGRect)frame andInfoModel:(YHSCookBookDishModel *)infoModel
{
    self = [super initWithFrame:frame];
    if (self) {
        _infoModel = infoModel;
        
        [self createView];
        [self setViewAtuoLayout];
        
        [self configUIView:_infoModel];
    }
    return self;
}


#pragma make 创建子控件
- (void) createView {
    
    // 图片
    {
        self.coverImageView = [UIImageView new];
        [self.coverImageView.layer setMasksToBounds:YES];
        [self.coverImageView setUserInteractionEnabled:YES];
        [self addSubview:self.coverImageView];
        
        // 透明层
        self.coverImageAplhaView = [UIView new];
        [self.coverImageAplhaView.layer setMasksToBounds:YES];
        [self.coverImageAplhaView setUserInteractionEnabled:YES];
        [self.coverImageAplhaView setBackgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:0.30]];
        [self.coverImageView addSubview:self.coverImageAplhaView];
    }
    
    // 视屏
    {
        self.videoStartImageView = [UIImageView new];
        [self.videoStartImageView.layer setMasksToBounds:YES];
        [self.videoStartImageView setUserInteractionEnabled:YES];
        [self.coverImageAplhaView addSubview:self.videoStartImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressVideoStartImageViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.videoStartImageView addGestureRecognizer:tapGesture];
    }
    
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
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    // 视屏
    {
        CGFloat videoStartImageSize = 50.0;
        [self.videoStartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
            make.size.mas_equalTo(CGSizeMake(videoStartImageSize, videoStartImageSize));
        }];
    }
    
    // 图片
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    // 透明层
    [self.coverImageAplhaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.coverImageView);
    }];
    
    // 点赞
    {
        CGFloat margin = 10;
        CGFloat likeImageSize = 45.0;
        
        [self.likeCountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-30.0);
            make.right.equalTo(weakSelf.coverImageAplhaView.mas_right).offset(-margin/2.0);
            make.size.mas_equalTo(CGSizeMake(likeImageSize, likeImageSize));
        }];
        
        [self.likeCountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.likeCountView);
        }];
        
        _likeCountLableWidth = 55.0;
        [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_bottom).offset(-30.0);
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-5.0);
            make.right.equalTo(weakSelf.coverImageAplhaView.mas_right).offset(0.0);
            make.width.equalTo(@(_likeCountLableWidth));
        }];
    }
    
}

- (void)configUIView:(YHSCookBookDishModel *)infoModel
{
    // 视屏
    [_videoStartImageView setImage:[UIImage imageNamed:@"video_start"]];
    
    // 图片
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:infoModel.Cover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 点赞
    NSString *likeCount = [NSString stringWithFormat:@"%ld", _infoModel.LikeCount];
    [_likeCountLabel setText:likeCount];
    [_likeCountImageView setImage:[UIImage imageNamed:@"btn_auxiliary_good_on"]];
    if (_infoModel.LikeCount > 9999999) {
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

}



#pragma mark - 触发操作事件

- (void)pressVideoStartImageViewArea:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickDishVideoStartWithInfoModel:)]) {
        [self.delegate didClickDishVideoStartWithInfoModel:self.infoModel];
    }
}


- (void)pressLikeCountImageViewArea:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickDishLikeCountWithInfoModel:)]) {
        [self.delegate didClickDishLikeCountWithInfoModel:self.infoModel];
    }
}



@end
