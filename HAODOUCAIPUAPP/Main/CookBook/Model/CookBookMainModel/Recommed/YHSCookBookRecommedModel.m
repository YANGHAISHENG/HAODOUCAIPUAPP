//
//  YHSCookBookRecommedModel.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookRecommedModel.h"

@implementation YHSCookBookRecommedModel
// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"recommedElemList" : @"list",  @"recommedAD" : @"ad"};
}
+ (NSDictionary *)objectClassInArray{
    return @{@"recommedElemList" : [YHSCookBookRecommedElemModel class]};
}
@end



@implementation YHSCookBookRecommedADModel

@end


@implementation YHSCookBookRecommedElemModel

@end


