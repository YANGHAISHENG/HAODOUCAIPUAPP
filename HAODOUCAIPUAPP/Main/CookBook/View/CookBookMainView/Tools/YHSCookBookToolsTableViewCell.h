//
//  YHSCookBookToolsTableViewCell.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookToolsModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_TOOLS;

@protocol YHSCookBookToolsTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithToolModel:(YHSCookBookToolsModel *)model;
@end


@interface YHSCookBookToolsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray<YHSCookBookToolsModel *> *model;

@property (nonatomic, strong) id<YHSCookBookToolsTableViewCellDelegate> delegate;

@end



