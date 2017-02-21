//
//  YHSCookBookHotsAlbumTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/12.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookHotsAlbumModel, YHSCookBookAlbumElemModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_HOTS_ALBUM;

@protocol YHSCookBookHotsAlbumTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithHotsAlbumModel:(YHSCookBookAlbumElemModel *)model;
@end


@interface YHSCookBookHotsAlbumTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookHotsAlbumModel *model;

@property (nonatomic, strong) id<YHSCookBookHotsAlbumTableViewCellDelegate> delegate;

@end
