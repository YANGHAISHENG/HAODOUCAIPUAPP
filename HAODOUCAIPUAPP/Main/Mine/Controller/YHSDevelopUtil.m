//
//  YHSDevelopUtil.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/8/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSDevelopUtil.h"

@implementation YHSDevelopUtil

// 计算单个文件大小
+ (float)fileSizeAtPath:(NSString *)path
{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}

// 计算目录大小
+ (float)folderSizeAtPath:(NSString *)path
{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [YHSDevelopUtil fileSizeAtPath:absolutePath];
        }
        // SDWebImage框架自身计算缓存的实现
        folderSize += [[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0;
        return folderSize;
    }
    return 0;
}

// 根据路径删除文件
+ (void)clearCaches:(NSString *)path
{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            // 如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    // 清除SDWebImage框架的缓存
    [[SDImageCache sharedImageCache] cleanDisk];
}


@end
