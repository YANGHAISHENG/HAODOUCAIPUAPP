//
//  YHSCookBookFoodieFavoriteGoodsTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/3.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSBackHomeFoodieFavoriteGoodsModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_BACKHOME_FOODIEFAVORITE_GOODS;

@protocol YHSCookBookFoodieFavoriteGoodsTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithBackHomeFoodieFavoriteGoods:(YHSBackHomeFoodieFavoriteGoodsModel *)model;
@end


@interface YHSCookBookFoodieFavoriteGoodsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray<YHSBackHomeFoodieFavoriteGoodsModel *> *model;

@property (nonatomic, strong) id<YHSCookBookFoodieFavoriteGoodsTableViewCellDelegate> delegate;

@end


