//
//  YHSCookBookShowProductDayTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookShowProductDayModel, YHSCookBookShowProductDayItemModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_DAY;

@protocol YHSCookBookShowProductDayTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookShowProductDayItemModel:(YHSCookBookShowProductDayItemModel *)model;
@end


@interface YHSCookBookShowProductDayTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookShowProductDayModel *model;

@property (nonatomic, strong) id<YHSCookBookShowProductDayTableViewCellDelegate> delegate;

@end


