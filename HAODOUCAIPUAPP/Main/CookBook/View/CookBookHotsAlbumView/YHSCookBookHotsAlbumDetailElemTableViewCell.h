//
//  YHSCookBookHotsAlbumDetailElemTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookHotsAlbumDetailElemModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_HOTS_ALBUM_DETAIL_ELEM;

@protocol YHSCookBookHotsAlbumDetailElemTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithHotsAlbumDetailElemModel:(YHSCookBookHotsAlbumDetailElemModel *)model;
- (void)didClickElementOfCellLikeCountWithHotsAlbumDetailElemModel:(YHSCookBookHotsAlbumDetailElemModel *)model;
@end


@interface YHSCookBookHotsAlbumDetailElemTableViewCell : UITableViewCell
@property (nonatomic, strong) YHSCookBookHotsAlbumDetailElemModel *model;
@property (nonatomic, strong) id<YHSCookBookHotsAlbumDetailElemTableViewCellDelegate> delegate;
@end


