//
//  YHSCookBookHotsAlbumTabDetailViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsAlbumTabDetailViewController.h"
#import "YHSCookBookDataUtil.h"


@implementation YHSCookBookHotsAlbumTabDetailViewController

- (NSString *)getCookBookHotsAlbumDetailRequestURLString
{
    return [YHSCookBookDataUtil getCookBookHotsAlbumTabDetailRequestURLString];
}

- (NSMutableDictionary *)getCookBookHotsAlbumDetailRequestParams
{
    NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookHotsAlbumTabDetailRequestParams];
    [params setObject:@(self.limit) forKey:@"limit"];
    [params setObject:@(self.offset) forKey:@"offset"];
    [params setObject:self.return_request_id forKey:@"return_request_id"]; // 必须有
    [params setObject:self.aid forKey:@"aid"];
    
    return params;
}

@end
