//
//  YHSCookBookHaoDouVIPTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookHaoDouVIPModel, YHSCookBookHaoDouVIPElemModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_HAODOU_VIP;

@protocol YHSCookBookHaoDouVIPTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithHaoDouVIPModel:(YHSCookBookHaoDouVIPElemModel *)model;
@end


@interface YHSCookBookHaoDouVIPTableViewCell : UITableViewCell

@property (nonatomic, strong) YHSCookBookHaoDouVIPModel *model;

@property (nonatomic, strong) id<YHSCookBookHaoDouVIPTableViewCellDelegate> delegate;

@end

