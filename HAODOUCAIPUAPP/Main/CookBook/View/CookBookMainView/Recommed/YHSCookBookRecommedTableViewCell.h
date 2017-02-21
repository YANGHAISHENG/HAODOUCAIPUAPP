//
//  YHSCookBookRecommedTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookRecommedModel, YHSCookBookRecommedElemModel, YHSCookBookRecommedADModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_RECOMMED;

@protocol YHSCookBookRecommedTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithRecommedElemModel:(YHSCookBookRecommedElemModel *)model;
- (void)didClickElementOfCellWithRecommedADModel:(YHSCookBookRecommedADModel *)model;
@end


@interface YHSCookBookRecommedTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookRecommedModel *model;

@property (nonatomic, strong) id<YHSCookBookRecommedTableViewCellDelegate> delegate;

@end

