//
//  YHSBackHomeADTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/3.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSBackHomeADModel;

UIKIT_EXTERN CGFloat const SCROLL_AD_HEIGHT;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_BACKHOME_AD;

@protocol YHSBackHomeADTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithBackHomeADModel:(YHSBackHomeADModel *)model;
@end


@interface YHSBackHomeADTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray<YHSBackHomeADModel *> *model;

@property (nonatomic, strong) id<YHSBackHomeADTableViewCellDelegate> delegate;

@end



