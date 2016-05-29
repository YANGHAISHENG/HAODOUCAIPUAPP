//
//  YHSSysMacro.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHSUtilsMacro.h"
#import "YHSVenderMacro.h"

@interface YHSSysMacro : NSObject

#define MAP(a, b, c) MIN(MAX(a, b), c)

#pragma mark - 弱引用自已（用于避免循环引用）
#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#pragma mark 屏幕高宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark - 颜色
#define YHSColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define YHSColorAlpha(r,g,b,alp) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(alp)]

#pragma mark - 导航条颜色
#define COLOR_NAVIGATION_BAR [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]
#define COLOR_NAVIGATION_BAR_TITLE [UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00]

#define COLOR_NAVIGATION_BAR_SEARCH [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00]
#define COLOR_NAVIGATION_BAR_SEARCH_TITLE_WHITE [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00]
#define COLOR_NAVIGATION_BAR_SEARCH_TITLE_GRAY [UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00]


#pragma mark 菜谱视屏或图片的高度
#define HEADER_VIDEO_PICTURE_HEIGHT (SCREEN_WIDTH * 9.0 / 16.0)

@end
