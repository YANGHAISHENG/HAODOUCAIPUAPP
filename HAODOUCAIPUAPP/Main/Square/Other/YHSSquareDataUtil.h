//
//  YHSSquareDataUtil.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSSquareDataUtil : NSObject

#pragma mark - N001.广场话题请求数据
+ (NSString *)getTopicGroupRequestURLString;
#pragma mark - N001.广场话题请求数据
+ (NSMutableDictionary *)getTopicGroupRequestParams;


#pragma mark - N002.广场话题请求数据
+ (NSString *)getFriendGroupRequestURLString;
#pragma mark - N002.广场话题请求数据
+ (NSMutableDictionary *)getFriendGroupRequestParams;


#pragma mark - N003.广场话题请求数据
+ (NSString *)getDynamicGroupRequestURLString;
#pragma mark - N003.广场话题请求数据
+ (NSMutableDictionary *)getDynamicGroupRequestParams;




@end
