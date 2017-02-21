//
//  YHSCookBookSearchDetailAlbumTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/20.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookSearchDetailAlbumModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_SEARCH_DETAIL_ALBUM;

@protocol YHSCookBookSearchDetailAlbumTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookSearchDetailAlbumModel:(YHSCookBookSearchDetailAlbumModel *)model;
@end


@interface YHSCookBookSearchDetailAlbumTableViewCell : UITableViewCell
@property (nonatomic, strong) YHSCookBookSearchDetailAlbumModel *model;
@property (nonatomic, strong) id<YHSCookBookSearchDetailAlbumTableViewCellDelegate> delegate;
@end

