//
//  YHSBackHomeGoodTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/3.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSBackHomeGoodsModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_BACKHOME_GOODS;

@protocol YHSBackHomeGoodTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithGoodDetailInfoInfoAction:(YHSBackHomeGoodsModel *)model;
- (void)didClickElementOfCellWithUserDetailInfoAction:(YHSBackHomeGoodsModel *)model;
- (void)didClickElementOfCellWithBuyAction:(YHSBackHomeGoodsModel *)model;
@end


@interface YHSBackHomeGoodTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSBackHomeGoodsModel *model;

@property (nonatomic, strong) id<YHSBackHomeGoodTableViewCellDelegate> delegate;

@end


