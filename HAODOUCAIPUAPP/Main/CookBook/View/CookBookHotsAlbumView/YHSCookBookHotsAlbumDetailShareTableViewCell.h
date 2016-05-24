//
//  YHSCookBookHotsAlbumDetailShareTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookHotsAlbumDetailShareModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_HOTS_ALBUM_DETAIL_SHARE;

@protocol YHSCookBookHotsAlbumDetailShareTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithHotsAlbumDetailShareModel:(YHSCookBookHotsAlbumDetailShareModel *)model expandedStateWithIndexPath:(NSIndexPath *)index;
@end


@interface YHSCookBookHotsAlbumDetailShareTableViewCell : UITableViewCell
@property (nonatomic, strong) YHSCookBookHotsAlbumDetailShareModel *model;
@property (nonatomic, strong) id<YHSCookBookHotsAlbumDetailShareTableViewCellDelegate> delegate;

- (void)setModel:(YHSCookBookHotsAlbumDetailShareModel *)model indexPath:(NSIndexPath *)indexPath;

@end
