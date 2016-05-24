//
//  YHSCookBookQualityReadModel.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookQualityReadModel.h"

@implementation YHSCookBookQualityReadModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"readList" : @"list"};
}
+ (NSDictionary *)objectClassInArray{
    return @{@"readList" : [YHSCookBookQualityReadElemModel class]};
}
@end


@implementation YHSCookBookQualityReadElemModel

@end


