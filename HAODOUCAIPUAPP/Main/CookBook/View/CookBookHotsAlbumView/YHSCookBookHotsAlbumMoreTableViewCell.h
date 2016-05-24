//
//  YHSCookBookHotsAlbumMoreTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookMenuTableViewCell.h"
@class YHSCookBookHotsAlbumMoreModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_HOTS_ALBUM_MORE;

@protocol YHSCookBookHotsAlbumMoreTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookHotsAlbumMoreModel:(YHSCookBookHotsAlbumMoreModel *)model;
@end


@interface YHSCookBookHotsAlbumMoreTableViewCell : YHSCookBookMenuTableViewCell

@property (nonatomic, strong) YHSCookBookHotsAlbumMoreModel *model;

@property (nonatomic, strong) id<YHSCookBookHotsAlbumMoreTableViewCellDelegate> delegate;

@end



