//
//  YHSCookBookHotsAlbumTabAllViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsAlbumTabAllViewController.h"
#import "YHSCookBookDataUtil.h"


@implementation YHSCookBookHotsAlbumTabAllViewController

- (NSString *)getCookBookHotsAlbumMoreRequestURLString
{
    return [YHSCookBookDataUtil getCookBookHotsAlbumMoreAllRequestURLString];
}

- (NSMutableDictionary *)getCookBookHotsAlbumMoreRequestParams
{
    return [YHSCookBookDataUtil getCookBookHotsAlbumMoreAllRequestParams];
}

@end
