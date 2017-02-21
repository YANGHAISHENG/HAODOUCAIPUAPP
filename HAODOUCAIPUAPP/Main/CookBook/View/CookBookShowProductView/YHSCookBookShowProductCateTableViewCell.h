//
//  YHSCookBookShowProductCateTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookShowProductCateModel, YHSCookBookShowProductCateItemModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_SHOW_PRODUCT_CATE;

@protocol YHSCookBookShowProductCateTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookShowProductCateItemModel:(YHSCookBookShowProductCateItemModel *)model;
- (void)didClickElementOfCellWithCookBookShowProductCateModel:(YHSCookBookShowProductCateModel *)model;
@end


@interface YHSCookBookShowProductCateTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookShowProductCateModel *model;

@property (nonatomic, strong) id<YHSCookBookShowProductCateTableViewCellDelegate> delegate;

@end




