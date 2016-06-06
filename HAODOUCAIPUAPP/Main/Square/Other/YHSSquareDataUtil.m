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
    return @"http://api.haodou.com/mall/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1465111200576&vc=83&vn=6.1.0&loguid=9832584&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=idx.index&virtual=&signmethod=md5&v=2&timestamp=1465111330&nonce=0.5391561331120396&appsign=18e0fcb3b7f31a834c67da857bec7f4d";
}
#pragma mark - N001.广场话题请求数据
+ (NSMutableDictionary *)getTopicGroupRequestParams
{
    return @{@"Latitude":@"30.45974",
             @"Longitude":@"114.436491",
             @"RecommendType":@"0",
             @"limit":@"20",
             @"offset":@"0",
             @"uid":@"9832584",
             @"sign":@"1133e1de8081f6500b20d31f3f6729e3",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}

@end
