//
//  YHSSquareDataUtil.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSSquareDataUtil.h"

@implementation YHSSquareDataUtil

#pragma mark - N001.广场话题请求数据
+ (NSString *)getTopicGroupRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1465196747580&vc=84&vn=6.1.1&loguid=9832584&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v611&method=Topic.indexTopic&virtual=&signmethod=md5&v=3&timestamp=1465197550&nonce=0.9284769544340404&appsign=69582baf414a273a0bcf76e68bc18dc0";
}
#pragma mark - N001.广场话题请求数据
+ (NSMutableDictionary *)getTopicGroupRequestParams
{
    return @{@"uid":@"9832584",
             @"offset":@"0",
             @"sign":@"1133e1de8081f6500b20d31f3f6729e3"}.mutableCopy;
}


#pragma mark - N002.广场豆友请求数据
+ (NSString *)getFriendGroupRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1465283867820&vc=84&vn=6.1.1&loguid=9832584&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v611&method=Topic.indexPeople&virtual=&signmethod=md5&v=3&timestamp=1465284069&nonce=0.8586627405175541&appsign=1c15f617a70edbf608e402465705f224";
}
#pragma mark - N002.广场豆友请求数据
+ (NSMutableDictionary *)getFriendGroupRequestParams
{
    return @{@"position":@"中国湖北省武汉市江夏区金融港四路",
             @"lng":@"114.436479",
             @"lat":@"30.459732",
             @"offset":@"0",
             @"limit":@"20",
             @"sign":@"1133e1de8081f6500b20d31f3f6729e3",
             @"uid":@"9832584"}.mutableCopy;
}


#pragma mark - N003.广场f动态请求数据
+ (NSString *)getDynamicGroupRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1465196747580&vc=84&vn=6.1.1&loguid=9832584&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v611&method=UserFeed.getFollowUserFeed&virtual=&signmethod=md5&v=3&timestamp=1465197853&nonce=0.6701287047443995&appsign=d0e4efd0edfb600492ef6a6fe07ba03c";
}
#pragma mark - N003.广场动态请求数据
+ (NSMutableDictionary *)getDynamicGroupRequestParams
{
    return @{@"offset":@"0",
             @"limit":@"10",
             @"sign":@"1133e1de8081f6500b20d31f3f6729e3",
             @"uid":@"9832584"}.mutableCopy;
}



@end
