//
//  YHSCookBookKitchenTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookKitchenModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_KITCHEN;

@protocol YHSCookBookKitchenTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookKitchenModel:(YHSCookBookKitchenModel *)model;
@end


@interface YHSCookBookKitchenTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookKitchenModel *model;

@property (nonatomic, strong) id<YHSCookBookKitchenTableViewCellDelegate> delegate;

@end


