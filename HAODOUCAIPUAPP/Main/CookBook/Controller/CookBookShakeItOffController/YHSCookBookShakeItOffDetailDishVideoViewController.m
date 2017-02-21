//
//  YHSCookBookShakeItOffDetailDishVideoViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookShakeItOffDetailDishVideoViewController.h"


@implementation YHSCookBookShakeItOffDetailDishVideoViewController

- (NSString *)getCookBookDishVedioRequestURLString
{
    // 默认主页面内容，子类必须继承
    return [YHSCookBookDataUtil getCookBookShakeItOffDishVideoRequestURLString];
}

- (NSMutableDictionary *)getCookBookDishVedioRequestParams
{
    // 默认主页面内容，子类必须继承
    NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookShakeItOffDishVideoRequestParams];
    [params setObject:self.return_request_id forKey:@"return_request_id"];
    [params setObject:self.rid forKey:@"rid"];  // 必须有
    return params;
}

@end


