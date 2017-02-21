//
//  YHSCookBookPublishTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookPublishModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_PUBLISH;

@protocol YHSCookBookPublishTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithPublishModel:(YHSCookBookPublishModel *)model;
@end


@interface YHSCookBookPublishTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookPublishModel *model;

@property (nonatomic, strong) id<YHSCookBookPublishTableViewCellDelegate> delegate;

@end

