//
//  YHSCookBookSearchHotsAlbumDetailViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookSearchHotsAlbumDetailViewController.h"
#import "YHSCookBookDataUtil.h"


@implementation YHSCookBookSearchHotsAlbumDetailViewController

- (NSString *)getCookBookHotsAlbumDetailRequestURLString
{
    return [YHSCookBookDataUtil getCookBookSearchHotsAlbumDetailRequestURLString];
}

- (NSMutableDictionary *)getCookBookHotsAlbumDetailRequestParams
{
    NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookSearchHotsAlbumDetailRequestParams];
    [params setObject:@(self.limit) forKey:@"limit"];
    [params setObject:@(self.offset) forKey:@"offset"];
    [params setObject:self.return_request_id forKey:@"return_request_id"]; // 必须有
    [params setObject:self.aid forKey:@"aid"];
    
    return params;
}


@end
