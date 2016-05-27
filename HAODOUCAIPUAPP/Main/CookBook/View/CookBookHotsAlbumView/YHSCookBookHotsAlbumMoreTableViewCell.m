//
//  YHSCookBookHotsAlbumMoreTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsAlbumMoreTableViewCell.h"
#import "YHSCookBookHotsAlbumMoreModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_HOTS_ALBUM_MORE = @"YHSCookBookHotsAlbumMoreTableViewCellID";

@implementation YHSCookBookHotsAlbumMoreTableViewCell

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookHotsAlbumMoreModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 图片
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.Cover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    // 标题
    [self.titleLabel setText:_model.Title];
    
    
    // 收藏总数/浏览总数
    [self.collectionLabel setText:_model.Collection];
    
    // 详情
    [self.contentLabel setText:_model.Content];
    
}

#pragma mark - 触发操作事件

- (void)pressPublicContainerArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookHotsAlbumMoreModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookHotsAlbumMoreModel:self.model];
    }
    
}



@end
