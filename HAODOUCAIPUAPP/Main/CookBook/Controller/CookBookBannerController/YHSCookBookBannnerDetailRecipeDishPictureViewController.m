//
//  YHSCookBookBannnerDetailRecipeDishPictureViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookBannnerDetailRecipeDishPictureViewController.h"


@implementation YHSCookBookBannnerDetailRecipeDishPictureViewController

- (NSString *)getCookBookBannnerDetailRecipeDishPictureRequestURLString
{
    // 默认主页面内容，子类必须继承
    return [YHSCookBookDataUtil getCookBookBannnerDetailRecipeDishPictureRequestURLString];
}

- (NSMutableDictionary *)getCookBookBannnerDetailRecipeDishPictureRequestParams
{
    // 默认主页面内容，子类必须继承
    NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookBannnerDetailRecipeDishPictureRequestParams];
    [params setObject:self.appqs forKey:@"appqs"];
    [params setObject:self.rid forKey:@"rid"];  // 必须有
    return params;
}

@end
