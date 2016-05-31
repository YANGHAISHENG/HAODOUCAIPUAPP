//
//  YHSCookBookShowProductUserTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookShowProductUserModel, YHSCookBookShowProductUserItemModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_USER;

@protocol YHSCookBookShowProductUserTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookShowProductUserItemModel:(YHSCookBookShowProductUserItemModel *)model;
@end


@interface YHSCookBookShowProductUserTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookShowProductUserModel *model;

@property (nonatomic, strong) id<YHSCookBookShowProductUserTableViewCellDelegate> delegate;

@end



