//
//  YHSFriendGroupModel.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSFriendGroupModel.h"

@implementation YHSFriendGroupModel
+ (NSDictionary *)objectClassInArray{
    return @{@"FavoriteList" : [YHSFriendGroupFavoriteElemModel class]};
}
@end


@implementation YHSFriendGroupCommonElemModel

@end


@implementation YHSFriendGroupFavoriteElemModel

@end


