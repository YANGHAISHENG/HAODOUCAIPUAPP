//
//  YHSCookBookGoodsTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookGoodsModel, YHSCookBookGoodsElemModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_GOODS;

@protocol YHSCookBookGoodsTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithGoodsElemModel:(YHSCookBookGoodsElemModel *)model;
@end


@interface YHSCookBookGoodsTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookGoodsModel *model;

@property (nonatomic, strong) id<YHSCookBookGoodsTableViewCellDelegate> delegate;

@end



