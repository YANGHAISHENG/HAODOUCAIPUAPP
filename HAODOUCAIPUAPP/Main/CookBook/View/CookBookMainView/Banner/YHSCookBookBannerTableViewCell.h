//
//  YHSCookBookBannerTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/16.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookBannerModel;

UIKIT_EXTERN CGFloat const SCROLL_BANNER_HEIGHT;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_BANNER;

@protocol YHSCookBookBannerTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithBannerModel:(YHSCookBookBannerModel *)model;
@end


@interface YHSCookBookBannerTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray<YHSCookBookBannerModel *> *model;

@property (nonatomic, strong) id<YHSCookBookBannerTableViewCellDelegate> delegate;

@end


