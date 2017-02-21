//
//  YHSCookBookHotsAlbumDetailViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsAlbumMainDetailViewController.h"


@implementation YHSCookBookHotsAlbumMainDetailViewController

- (NSString *)getCookBookHotsAlbumDetailRequestURLString
{
    return [YHSCookBookDataUtil getCookBookHotsAlbumMainDetailRequestURLString];
}

- (NSMutableDictionary *)getCookBookHotsAlbumDetailRequestParams
{
    NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookHotsAlbumMainDetailRequestParams];
    [params setObject:@(self.limit) forKey:@"limit"];
    [params setObject:@(self.offset) forKey:@"offset"];
    [params setObject:self.appqs forKey:@"appqs"]; // 必须有
    [params setObject:self.aid forKey:@"aid"];
    
    return params;
}

@end





