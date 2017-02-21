//
//  YHSUtilsMacro.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

// 方便使用的宏定义

#import <UIKit/UIKit.h>
#import "YHSUtilsMacro.h"
#import "YHSVenderMacro.h"

@interface YHSUtilsMacro : NSObject

#pragma mark 控制台颜色
#define XCODE_COLORS_ESCAPE @"\033["
#define XCODE_COLORS_RESET_FG XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET XCODE_COLORS_ESCAPE @";" // Clear any foreground or background color

#pragma mark 项目打包上线不会打印日志
#ifdef DEBUG
#define YHSLogRed(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogGreen(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg28,172,120;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogBlue(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg13,152,186;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogOrange(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,117,56;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogBrown(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg165,42,42;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogLight(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg162,173,208;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogRedBrick(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg203,65,84;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogGreenForest(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg109,174,129;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogBlueMidnight(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg26,72,118;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogOrangeSunset(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg253,94,83;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogBrownSpeia(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg180,103,177;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define YHSLogLightYonder(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg197,208,230;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#else
#define YHSLogRed(frmt, ...)
#define YHSLogGreen(frmt, ...)
#define YHSLogBlue(frmt, ...)
#define YHSLogOrange(frmt, ...)
#define YHSLogBrown(frmt, ...)
#define YHSLogLight(frmt, ...)
#define YHSLogRedBrick(frmt, ...)
#define YHSLogGreenForest(frmt, ...)
#define YHSLogBlueMidnight(frmt, ...)
#define YHSLogOrangeSunset(frmt, ...)
#define YHSLogBrownSpeia(frmt, ...)
#define YHSLogLightYonder(frmt, ...)
#endif


@end
