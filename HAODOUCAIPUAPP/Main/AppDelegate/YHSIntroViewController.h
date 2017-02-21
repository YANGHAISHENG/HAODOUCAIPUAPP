//
//  YHSIntroViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/15.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicViewController.h"

typedef void (^YHSDidSelectedLastPage)();

@interface YHSIntroViewController : YHSBasicViewController

@property (nonatomic, copy) YHSDidSelectedLastPage didSelectedLastPage;

@end
