//
//  YHSCookBookBannnerDetailCollectViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookBannnerDetailCollectViewController.h"
#import "YHSCookBookDataUtil.h"


@implementation YHSCookBookBannnerDetailCollectViewController

- (NSString *)getCookBookHotsAlbumDetailRequestURLString
{
    return [YHSCookBookDataUtil getCookBookBannerDetailCollectRequestURLString];
}

- (NSMutableDictionary *)getCookBookHotsAlbumDetailRequestParams
{
    NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookBannerDetailCollectRequestParams];
    [params setObject:@(self.limit) forKey:@"limit"];
    [params setObject:@(self.offset) forKey:@"offset"];
    [params setObject:self.appqs forKey:@"appqs"]; // 必须有
    [params setObject:self.aid forKey:@"aid"];
    
    return params;
}

@end

