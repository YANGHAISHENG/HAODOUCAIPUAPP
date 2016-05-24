//
//  YHSCookBookHotsActivityTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookHotsActivityModel, YHSCookBookHotsActivityElemModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_HOTS_ACTIVITY;

@protocol YHSCookBookHotsActivityTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithHotsActivityModel:(YHSCookBookHotsActivityElemModel *)model;
@end


@interface YHSCookBookHotsActivityTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookHotsActivityModel *model;

@property (nonatomic, strong) id<YHSCookBookHotsActivityTableViewCellDelegate> delegate;


@end


