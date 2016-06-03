//
//  YHSBackHomeDataUtil.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/3.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBackHomeDataUtil.h"

@implementation YHSBackHomeDataUtil


#pragma mark - N001.到家请求数据
+ (NSString *)getBackHomeRequestURLString
{
    return @"http://api.haodou.com/mall/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464934935237&vc=83&vn=6.1.0&loguid=9832584&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=idx.index&virtual=&signmethod=md5&v=2&timestamp=1464934961&nonce=0.7106389847391082&appsign=73ed13b0625ac94a5ebb49895508b7dd";
}
#pragma mark - N001.到家请求数据
+ (NSMutableDictionary *)getBackHomeMainRequestParams
{
    return @{@"Latitude":@"30.45974",
             @"Longitude":@"114.436491",
             @"limit":@"20",
             @"offset":@"0",
             @"uid":@"9832584",
             @"sign":@"1133e1de8081f6500b20d31f3f6729e3",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}



@end
