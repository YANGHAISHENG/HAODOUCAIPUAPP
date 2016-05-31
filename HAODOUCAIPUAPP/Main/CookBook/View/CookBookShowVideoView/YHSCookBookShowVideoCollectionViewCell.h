//
//  YHSCookBookShowVideoCollectionViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookShowVideoModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_SHOW_VIDEO_COLLECTION;

@protocol YHSCookBookShowVideoCollectionViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookShowVideoModel:(YHSCookBookShowVideoModel *)model;
@end


@interface YHSCookBookShowVideoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YHSCookBookShowVideoModel *model;

@property (nonatomic, strong) id<YHSCookBookShowVideoCollectionViewCellDelegate> delegate;

@end



