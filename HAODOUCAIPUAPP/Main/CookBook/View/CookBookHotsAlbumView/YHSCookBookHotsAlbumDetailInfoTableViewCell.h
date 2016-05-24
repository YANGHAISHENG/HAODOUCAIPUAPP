//
//  YHSCookBookHotsAlbumDetailInfoTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookHotsAlbumDetailInfoModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_HOTS_ALBUM_DETAIL_INFO;

@protocol YHSCookBookHotsAlbumDetailInfoTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithHotsAlbumDetailInfoModel:(YHSCookBookHotsAlbumDetailInfoModel *)model;
@end


@interface YHSCookBookHotsAlbumDetailInfoTableViewCell : UITableViewCell
@property (nonatomic, strong) YHSCookBookHotsAlbumDetailInfoModel *model;
@property (nonatomic, strong) id<YHSCookBookHotsAlbumDetailInfoTableViewCellDelegate> delegate;
@end

