//
//  YHSCookBookYourLoveTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/12.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookYourLoveModel, YHSCookBookYourLoveElemModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_YOUR_LOVE;

@protocol YHSCookBookYourLoveTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithYourLoveModel:(YHSCookBookYourLoveElemModel *)model;
@end


@interface YHSCookBookYourLoveTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookYourLoveModel *model;

@property (nonatomic, strong) id<YHSCookBookYourLoveTableViewCellDelegate> delegate;

@end

