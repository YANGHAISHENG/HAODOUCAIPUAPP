//
//  YHSCookBookSearchVIPTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookSearchVIPModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_COOKBOOK_SEARCH_VIP;

@protocol YHSCookBookSearchVIPTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithCookBookSearchVIPModel:(YHSCookBookSearchVIPModel *)model;
- (void)didClickElementOfCellWithCookBookSearchVIPRelationModel:(YHSCookBookSearchVIPModel *)model;
@end


@interface YHSCookBookSearchVIPTableViewCell : UITableViewCell
@property (nonatomic, strong) YHSCookBookSearchVIPModel *model;
@property (nonatomic, strong) id<YHSCookBookSearchVIPTableViewCellDelegate> delegate;
@end

