//
//  YHSCookBookSearchDetailTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/20.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookSearchDetailTableViewCell.h"
#import "YHSCookBookSearchDetailModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_SEARCH_DETAIL = @"YHSCookBookSearchDetailTableViewCellID";

@implementation YHSCookBookSearchDetailTableViewCell

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookSearchDetailModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 图片
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.Cover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 视屏标记图标
    for (UIView *view in self.coverImageView.subviews) {
        [view removeFromSuperview];
    }
    if (_model.HasVideo) {
        
        CGFloat size = 25.0;
        CGFloat margin = 5.0;
        
        UIImageView *videoImageView = [UIImageView new];
        [videoImageView.layer setCornerRadius:size/2.0];
        [videoImageView setImage:[UIImage imageNamed:@"ico_video_small"]];
        [self.coverImageView addSubview:videoImageView];
        
        WEAKSELF(weakSelf);
        
        [videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.coverImageView.mas_top).offset(margin);
            make.right.equalTo(weakSelf.coverImageView.mas_right).offset(-margin);
            make.size.mas_equalTo(CGSizeMake(size, size));
        }];
    }
    
    // 标题
    [self.titleLabel setText:_model.Title];
    
    
    // 播放时长/收藏总数/浏览总数
    if (_model.HasVideo) {
        
        [self.collectionLabel setText:_model.Duration];
        
    } else {
        
        [self.collectionLabel setText:[NSString stringWithFormat:@"%ld收藏  %ld浏览", _model.FavoriteCount, _model.ViewCount]];
        
    }
    
    // 详情
    [self.contentLabel setText:_model.Stuff];
    
}

#pragma mark - 触发操作事件

- (void)pressPublicContainerArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookSearchDetailModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookSearchDetailModel:self.model];
    }
    
}


@end
