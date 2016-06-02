//
//  YHSCookBookHotsAlbumTabRecommendViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsAlbumTabRecommendViewController.h"


@implementation YHSCookBookHotsAlbumTabRecommendViewController

- (NSString *)getCookBookHotsAlbumMoreRequestURLString
{
    return [YHSCookBookDataUtil getCookBookHotsAlbumMoreRecommendRequestURLString];
}

- (NSMutableDictionary *)getCookBookHotsAlbumMoreRequestParams
{
    return [YHSCookBookDataUtil getCookBookHotsAlbumMoreRecommendRequestParams];
}


- (void)setCurrentSelectedIndexOfHotsAlbumTab
{
    [self.hotsAlbumMoreViewController setCurrentSelectedIndex:0];
}

@end
