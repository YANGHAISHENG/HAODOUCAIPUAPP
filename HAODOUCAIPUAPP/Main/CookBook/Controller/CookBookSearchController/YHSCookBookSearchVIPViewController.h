//
//  YHSCookBookSearchVIPViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithBackBarItemViewController.h"

@interface YHSCookBookSearchVIPViewController : YHSBasicWithBackBarItemViewController

@property (nonatomic, assign) NSUInteger limit;
@property (nonatomic, assign) NSUInteger offset;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *uid;

@end
