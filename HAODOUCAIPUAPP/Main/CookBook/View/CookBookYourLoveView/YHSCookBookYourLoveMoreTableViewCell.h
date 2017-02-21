//
//  YHSCookBookYourLoveMoreTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/19.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookYourLoveMoreModel, YHSCookBookYourLoveMoreTagModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_YOUR_LOVE_MORE;

@protocol YHSCookBookYourLoveMoreTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithYourLoveMoreModel:(YHSCookBookYourLoveMoreModel *)model;
- (void)didClickElementOfCellLikeCountWithYourLoveMoreModel:(YHSCookBookYourLoveMoreModel *)model;
- (void)didClickElementOfCellWithYourLoveMoreTagModel:(YHSCookBookYourLoveMoreTagModel *)model;
@end


@interface YHSCookBookYourLoveMoreTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookYourLoveMoreModel *model;

@property (nonatomic, strong) id<YHSCookBookYourLoveMoreTableViewCellDelegate> delegate;

@end



