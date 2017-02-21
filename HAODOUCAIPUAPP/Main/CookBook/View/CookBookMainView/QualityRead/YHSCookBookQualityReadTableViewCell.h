//
//  YHSCookBookQualityReadTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookQualityReadModel, YHSCookBookQualityReadElemModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_QUALITY_READ;

@protocol YHSCookBookQualityReadTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithQualityReadModel:(YHSCookBookQualityReadElemModel *)model;
@end

@interface YHSCookBookQualityReadTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookQualityReadModel *model;

@property (nonatomic, strong) id<YHSCookBookQualityReadTableViewCellDelegate> delegate;

@end


