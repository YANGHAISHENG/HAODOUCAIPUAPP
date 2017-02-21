//
//  YHSCookBookHotsAlbumTabAllViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsAlbumTabAllViewController.h"


@implementation YHSCookBookHotsAlbumTabAllViewController

- (NSString *)getCookBookHotsAlbumMoreRequestURLString
{
    return [YHSCookBookDataUtil getCookBookHotsAlbumMoreAllRequestURLString];
}

- (NSMutableDictionary *)getCookBookHotsAlbumMoreRequestParams
{
    return [YHSCookBookDataUtil getCookBookHotsAlbumMoreAllRequestParams];
}

- (void)setCurrentSelectedIndexOfHotsAlbumTab
{
    [self.hotsAlbumMoreViewController setCurrentSelectedIndex:1];
}


@end
