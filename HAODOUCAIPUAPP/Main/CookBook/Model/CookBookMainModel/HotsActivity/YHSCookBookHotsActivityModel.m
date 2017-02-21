//
//  YHSCookBookHotsActivityModel.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHotsActivityModel.h"

@implementation YHSCookBookHotsActivityModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"activityList" : @"list"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"activityList" : [YHSCookBookHotsActivityElemModel class]};
}
@end


@implementation YHSCookBookHotsActivityElemModel

@end


