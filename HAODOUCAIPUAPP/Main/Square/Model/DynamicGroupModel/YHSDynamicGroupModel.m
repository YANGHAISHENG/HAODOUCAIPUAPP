//
//  YHSDynamicGroupModel.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/7.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSDynamicGroupModel.h"

@implementation YHSDynamicGroupModel

@end


@implementation YHSDynamicGroupUserInfoModel

@end


@implementation YHSDynamicGroupDataModel
+ (NSDictionary *)objectClassInArray{
    return @{@"CommentList" : [YHSDynamicGroupCommentElemModel class]};
}
@end


@implementation YHSDynamicGroupCommentElemModel

@end


