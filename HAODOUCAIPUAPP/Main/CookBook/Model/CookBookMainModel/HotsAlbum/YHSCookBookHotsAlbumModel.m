//
//  YHSCookBookHotsAlbumModel.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/12.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsAlbumModel.h"

@implementation YHSCookBookHotsAlbumModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"albumElemModelList" : @"list"};
}
+ (NSDictionary *)objectClassInArray{
    return @{@"albumElemModelList" : [YHSCookBookAlbumElemModel class]};
}
@end


@implementation YHSCookBookAlbumElemModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"albumSmallModelList" : @"List"};
}
+ (NSDictionary *)objectClassInArray{
    return @{@"albumSmallModelList" : [YHSCookBookAlbumSmallModel class]};
}
@end


@implementation YHSCookBookAlbumSmallModel

@end


