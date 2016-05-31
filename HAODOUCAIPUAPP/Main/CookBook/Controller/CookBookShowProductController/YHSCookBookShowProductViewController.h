//
//  YHSCookBookShowProductViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

@interface YHSCookBookShowProductViewController : YHSBasicWithBackBarItemViewController

@property (nonatomic, strong) NSString *appqs;  
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, strong) NSString *uuid;

@end
