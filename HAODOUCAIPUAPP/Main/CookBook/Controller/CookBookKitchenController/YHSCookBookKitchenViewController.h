//
//  YHSCookBookKitchenViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

@interface YHSCookBookKitchenViewController : YHSBasicWithBackBarItemViewController

@property (nonatomic, strong) NSString *appqs; // haodourecipe://haodou.com/collect/list/
@property (nonatomic, strong) NSString *tagid;
@property (nonatomic, strong) NSString *type; // 0/1
@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, strong) NSString *uuid;


@end
