//
//  YHSCookBookSearchModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHSDBObject.h"

@interface YHSCookBookSearchModel : YHSDBObject

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, assign) NSInteger modelType; // 数据类型

@end
