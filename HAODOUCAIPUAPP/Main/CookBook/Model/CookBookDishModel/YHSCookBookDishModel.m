//
//  YHSCookBookDishModel.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/25.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDishModel.h"

@implementation YHSCookBookDishModel


+ (NSDictionary *)objectClassInArray{
    return @{@"RecommendTopic" : [YHSCookBookDishRecommendtopicModel class], @"Stuff" : [YHSCookBookDishStuffModel class], @"CommentList" : [YHSCookBookDishCommentlistModel class], @"LastDiggUsers" : [YHSCookBookDishLastdiggusersModel class], @"Product" : [YHSCookBookDishProductModel class], @"Steps" : [YHSCookBookDishStepsModel class], @"Tags" : [YHSCookBookDishTagsModel class], @"MainStuff" : [YHSCookBookDishMainStuffModel class], @"OtherStuff" : [YHSCookBookDishOtherStuffModel class], @"Album" : [YHSCookBookDishAlbumModel class]};
}
@end
@implementation YHSCookBookDishAd_DataModel

@end


@implementation YHSCookBookDishUserInfoModel

+ (NSDictionary *)objectClassInArray{
    return @{@"FavoriteList" : [YHSCookBookDishUserInfoFavoritelistModel class]};
}

@end


@implementation YHSCookBookDishUserInfoFavoritelistModel

@end


@implementation YHSCookBookDishRewardModel

@end


@implementation YHSCookBookDishRecommendtopicModel

@end


@implementation YHSCookBookDishStuffModel

@end


@implementation YHSCookBookDishCommentlistModel

@end


@implementation YHSCookBookDishLastdiggusersModel

@end


@implementation YHSCookBookDishProductModel

@end


@implementation YHSCookBookDishStepsModel

@end


@implementation YHSCookBookDishTagsModel

@end


@implementation YHSCookBookDishMainStuffModel

@end


@implementation YHSCookBookDishOtherStuffModel

@end


@implementation YHSCookBookDishAlbumModel

@end


