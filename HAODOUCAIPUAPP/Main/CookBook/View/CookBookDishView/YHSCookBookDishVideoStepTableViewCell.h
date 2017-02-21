//
//  YHSCookBookDishVideoStepTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/26.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookVideoStepModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_DISH_VIDEO_STEP_INFO;

@interface YHSCookBookDishVideoStepTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookVideoStepModel *model;

- (void)didSelectPublicContainerView:(BOOL)selected;

@end

