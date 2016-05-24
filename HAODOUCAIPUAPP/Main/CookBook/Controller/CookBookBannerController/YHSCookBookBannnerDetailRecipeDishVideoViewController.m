//
//  YHSCookBookBannnerDetailRecipeDishVedioViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookBannnerDetailRecipeDishVideoViewController.h"
#import "YHSCookBookDataUtil.h"


@implementation YHSCookBookBannnerDetailRecipeDishVideoViewController

- (NSString *)getCookBookBannnerDetailRecipeDishVedioRequestURLString
{
    // 默认主页面内容，子类必须继承
    return [YHSCookBookDataUtil getCookBookBannnerDetailRecipeDishVideoRequestURLString];
}

- (NSMutableDictionary *)getCookBookBannnerDetailRecipeDishVedioRequestParams
{
    // 默认主页面内容，子类必须继承
    NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookBannnerDetailRecipeDishVideoRequestParams];
    [params setObject:self.appqs forKey:@"appqs"];
    [params setObject:self.rid forKey:@"rid"];  // 必须有
    return params;
}

@end
