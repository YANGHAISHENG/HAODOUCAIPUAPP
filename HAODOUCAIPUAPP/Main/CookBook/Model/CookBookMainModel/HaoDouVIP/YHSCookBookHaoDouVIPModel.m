//
//  YHSCookBookHaoDouVIPModel.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookHaoDouVIPModel.h"

@implementation YHSCookBookHaoDouVIPModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"vipList" : @"list"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"vipList" : [YHSCookBookHaoDouVIPElemModel class]};
}

@end


@implementation YHSCookBookHaoDouVIPElemModel

@end





