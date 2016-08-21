//
//  YHSDevelopUtil.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/8/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSDevelopUtil : NSObject

+ (float)fileSizeAtPath:(NSString *)path;

+ (float)folderSizeAtPath:(NSString *)path;

+ (void)clearCaches:(NSString *)path;

@end
