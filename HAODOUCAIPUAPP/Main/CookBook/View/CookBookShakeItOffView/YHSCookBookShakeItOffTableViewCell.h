//
//  YHSCookBookShakeItOffTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookMenuTableViewCell.h"
@class YHSCookBookShakeItOffModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_SHAKE_IT_OFF;

@protocol YHSCookBookShakeItOffTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookShakeItOffModel:(YHSCookBookShakeItOffModel *)model;
@end


@interface YHSCookBookShakeItOffTableViewCell : YHSCookBookMenuTableViewCell

@property (nonatomic, strong) YHSCookBookShakeItOffModel *model;

@property (nonatomic, strong) id<YHSCookBookShakeItOffTableViewCellDelegate> delegate;

@end

