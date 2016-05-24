//
//  YHSDBObject.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSDBObject.h"
#import "YHSSysMacro.h"


@implementation YHSDBObject


+ (LKDBHelper *)getUsingLKDBHelper
{
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *sqlitePath = [YHSDBObject downloadPath];
        NSString* dbpath = [sqlitePath stringByAppendingPathComponent:[NSString stringWithFormat:@"HaoDouCaiPuApp.db"]];
        db = [[LKDBHelper alloc] initWithDBPath:dbpath];
    });
    return db;
}

+ (NSString *)downloadPath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *downloadPath = [documentPath stringByAppendingPathComponent:@"YangHaiShengiOS"];
    YHSLogOrange(@"%@", downloadPath);
    return downloadPath;
}



@end
