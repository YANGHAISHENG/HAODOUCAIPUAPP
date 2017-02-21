//
//  YHSCookBookDataUtil.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDataUtil.h"
#import "YHSCookBookShowVideoCateModel.h"


@implementation YHSCookBookDataUtil

#pragma mark - N001.首页请求数据
+ (NSString *)getCookBookMainRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1462965652904&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Index.index&virtual=&signmethod=md5&v=2&timestamp=1462970899&nonce=0.1726062234284439&appsign=0b7453175cacb0a7a5cb1f37a7f1942b";
}
#pragma mark - N001.首页请求数据
+ (NSMutableDictionary *)getCookBookMainRequestParams
{
    return @{@"uid":@"9798666",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"limit":@"10",
             @"offset":@"0",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N002.首页导航分类请求数据
+ (NSString *)getCategoryRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463398867032&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Search.getCateList&virtual=&signmethod=md5&v=2&timestamp=1463404611&nonce=0.7931470992553015&appsign=9fd750a812663d0a1a1e694689680520";
}
#pragma mark - N002.首页导航分类请求数据
+ (NSMutableDictionary *)getCategoryRequestParams
{
    return nil;
}


#pragma mark - N003.分类标签搜索结果
+ (NSString *)getCategorySearchRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463619679803&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Search.getList&virtual=&signmethod=md5&v=2&timestamp=1463621811&nonce=0.004797499080657075&appsign=fec6fdbeabb7c10b56ed9f8e2678f835";
}
#pragma mark - N003.分类标签搜索结果
+ (NSMutableDictionary *)getCategorySearchRequestParams
{
    return @{@"tagid":@"",
             @"limit":@"20",
             @"offset":@"0",
             @"scene":@"t1",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N004.猜你喜欢结果
+ (NSString *)getYourLoveRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463655416896&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Search.getList&virtual=&signmethod=md5&v=2&timestamp=1463659523&nonce=0.31166672462827627&appsign=f93162effd4af07383bd684ab7f67374";
}
#pragma mark - N004.猜你喜欢结果
+ (NSMutableDictionary *)getYourLoveRequestParams
{
    return @{@"tagid":@"",
             @"limit":@"20",
             @"offset":@"0",
             @"appqs":@"haodourecipe://haodou.com/recipe/tag/?id=1096&name=%E5%8C%85%E5%AD%90",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N005.猜你喜欢头部点击结果
+ (NSString *)getYourLoveHeaderSectionRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463655416896&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Recipe.getCollectRecomment&virtual=&signmethod=md5&v=2&timestamp=1463664345&nonce=0.21497449105062583&appsign=6e1dd9b5929187f7c170077e74d17874";
}
#pragma mark - N005.猜你喜欢头部点击结果
+ (NSMutableDictionary *)getYourLoveHeaderSectionRequestParams
{
    return @{@"rid":@"",
             @"limit":@"10",
             @"offset":@"0",
             @"type":@"猜你喜欢",
             @"uid":@"9798666",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"appqs":@"haodourecipe://haodou.com/recommend/recipe/?keyword=%E7%8C%9C%E4%BD%A0%E5%96%9C%E6%AC%A2&title=%E7%8C%9C%E4%BD%A0%E5%96%9C%E6%AC%A2",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N006.导航搜索查询
+ (NSString *)getSearchByKeyRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463717614359&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Search.getSuggestion&virtual=&signmethod=md5&v=2&timestamp=1463732393&nonce=0.7483489943736075&appsign=1715ccd7175ae9c005f6af99f519afbd";
}
#pragma mark - N006.导航搜索查询
+ (NSMutableDictionary *)getSearchByKeyRequestParams
{
    return @{@"keyword":@"搜索"}.mutableCopy;
}


#pragma mark - N007.导航搜索查询-详细信息
+ (NSString *)getSearchResultDetailRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463745548660&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Search.getList&virtual=&signmethod=md5&v=2&timestamp=1463745583&nonce=0.20254741689788414&appsign=18ca1c103e73166e916bca30ed8ad147";
}
#pragma mark - N007.导航搜索查询-详细信息
+ (NSMutableDictionary *)getSearchResultDetailRequestParams
{
    return @{@"tagid":@"",
             @"limit":@"20",
             @"offset":@"0",
             @"scene":@"k1",
             @"keyword":@"搜索关键字",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N008.搜索豆友列表
+ (NSString *)getSearchVIPInfoRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463821724634&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=RecipeUser.getUserByName&virtual=&signmethod=md5&v=2&timestamp=1463821979&nonce=0.9755978470724113&appsign=7f6d48f867287132e81cdc6b863e8017";
}
#pragma mark - N008.搜索豆友列表
+ (NSMutableDictionary *)getSearchVIPInfoRequestParams
{
    return @{@"uid":@"9798666",
             @"limit":@"20",
             @"offset":@"0",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"name":@""}.mutableCopy;
}


#pragma mark - N009.热门专辑详情-主页
+ (NSString *)getCookBookHotsAlbumMainDetailRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463881279922&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getAlbumInfo&virtual=&signmethod=md5&v=2&timestamp=1463883954&nonce=0.4028842570493436&appsign=ad567b296d24ec3c201ef347685df27e";
}
#pragma mark - N009.热门专辑详情-主页
+ (NSMutableDictionary *)getCookBookHotsAlbumMainDetailRequestParams
{
    return @{@"uid":@"9798666",
             @"limit":@"20",
             @"offset":@"0",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"appqs":@"haodourecipe://haodou.com/collect/info/?id=12585386", // id变动，对就Url
             @"aid":@"12585386", // 变动
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N010.热门专辑-推荐
+ (NSString *)getCookBookHotsAlbumMoreRecommendRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463906894633&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Recipe.getAlbumList&virtual=&signmethod=md5&v=2&timestamp=1463907081&nonce=0.05653383538488721&appsign=abbf4b66c202a83823dfc9735d17d358";
}
#pragma mark - N010.热门专辑-推荐
+ (NSMutableDictionary *)getCookBookHotsAlbumMoreRecommendRequestParams
{
    return @{@"type":@"0",
             @"limit":@"20",
             @"offset":@"0",
             @"appqs":@"haodourecipe://haodou.com/collect/list/",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N011.热门专辑-全部
+ (NSString *)getCookBookHotsAlbumMoreAllRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463906894633&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Recipe.getAlbumList&virtual=&signmethod=md5&v=2&timestamp=1463907454&nonce=0.052887573305478996&appsign=fa541d259b3d5777f80f828c4d2298e7";
}
#pragma mark - N011.热门专辑-全部
+ (NSMutableDictionary *)getCookBookHotsAlbumMoreAllRequestParams
{
    return @{@"type":@"1",
             @"limit":@"20",
             @"offset":@"0",
             @"request_id":@"0ba5cb08e3d53747acfc081eb1afd5c2",
             @"appqs":@"haodourecipe://haodou.com/collect/list/",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;

}


#pragma mark - N012.热门专辑详情-TAB页面
+ (NSString *)getCookBookHotsAlbumTabDetailRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463906894633&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getAlbumInfo&virtual=&signmethod=md5&v=2&timestamp=1463916719&nonce=0.2890657375797244&appsign=7bf10dfa653978accd43d75f706a69a4";
}
#pragma mark - N012.热门专辑详情-TAB页面
+ (NSMutableDictionary *)getCookBookHotsAlbumTabDetailRequestParams
{
    return @{@"uid":@"9798666",
             @"limit":@"20",
             @"offset":@"0",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"return_request_id":@"ad6ae6f1e152a07395434276a7b2838b",
             @"aid":@"12585386", // 变动
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N013.广告栏详情页面（Collect）-主页
+ (NSString *)getCookBookBannerDetailCollectRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463964408330&vc=83&vn=6.1.0&loguid=0&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getAlbumInfo&virtual=&signmethod=md5&v=2&timestamp=1463964465&nonce=0.12038221754383738&appsign=3fcee9c085cea7a0e6d4744d16f7fe64";
}
#pragma mark - N013.广告栏详情页面（Collect）-主页
+ (NSMutableDictionary *)getCookBookBannerDetailCollectRequestParams
{
    return @{@"uid":@"0",
             @"limit":@"20",
             @"offset":@"0",
             @"sign":@"",
             @"appqs":@"haodourecipe://haodou.com/collect/info/?id=12600047", // id变动，对就Url
             @"aid":@"12600047", // 变动
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N014.摇一摇
+ (NSString *)getCookBookShakeItOffRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463966474368&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.shake&virtual=&signmethod=md5&v=2&timestamp=1463970775&nonce=0.5331311009804208&appsign=622b5697561c2c9b0c9b3bd4979d9ba0";
}
#pragma mark - N014.摇一摇
+ (NSMutableDictionary *)getCookBookShakeItOffRequestParams
{
    return @{@"limit":@"20",
             @"offset":@"0",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N015.菜谱制作过程 - 视屏
+ (NSString *)getCookBookDishVideoRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463983700629&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1463992804&nonce=0.5871638156398401&appsign=37e20a1fb5551dd49ab2e71ccd70bdd2";
}
#pragma mark - N015.菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCookBookDishVideoRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"942688",
             @"return_request_id":@"6d6cf691d98020b3a641372cff8bf224",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N016.菜谱制作过程 - 图片
+ (NSString *)getCookBookDishPictureRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463983700629&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1463994004&nonce=0.9121156427655553&appsign=a9f1cd6f7aed11eb03af4e565c4be690";
}
#pragma mark - N016.菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCookBookDishPictureRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"234337",
             @"return_request_id":@"21def6239262427a6b450dd7ed59f848",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N017.分类 - 菜谱制作过程 - 视屏
+ (NSString *)getCategoryDishVideoRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463995531638&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1463999031&nonce=0.1298180652170272&appsign=c0f305085f6b0bc268a8979df0253b2d";
}
#pragma mark - N017.分类 - 菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCategoryDishVideoRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"880831",
             @"return_request_id":@"f7a76b77c2050361636afbdef807ec66",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N018.分类 - 菜谱制作过程 - 图片
+ (NSString *)getCategoryDishPictureRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1463995531638&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1463999247&nonce=0.759052565708856&appsign=b758b9196d813e9dce594312d3c5288b";
}
#pragma mark - N018.分类 - 菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCategoryDishPictureRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"329708",
             @"return_request_id":@"f7a76b77c2050361636afbdef807ec66",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N019.猜你喜欢 - 菜谱制作过程 - 视屏
+ (NSString *)getCookBookYourLoveDishVideoRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464001957319&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1464002687&nonce=0.20740962450677036&appsign=665e2113cea0446d6e3f78f87ef3407d";
}
#pragma mark - N019.猜你喜欢 - 菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCookBookYourLoveDishVideoRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"858841",
             @"return_request_id":@"",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N020.猜你喜欢 - 菜谱制作过程 - 图片
+ (NSString *)getCookBookYourLoveDishPictureRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464001957319&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1464002607&nonce=0.06016796647528566&appsign=c59bb5d7e22c1329ad473e0c0f98c9f6";
}
#pragma mark - N020.猜你喜欢 - 菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCookBookYourLoveDishPictureRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"290048",
             @"return_request_id":@"",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N020.头部广告 - 菜谱制作过程 - 视屏
+ (NSString *)getCookBookBannnerDetailRecipeDishVideoRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464003345147&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1464004212&nonce=0.8871432242142046&appsign=8e01ac2e712a2482d1aff508ea363d2d";
}
#pragma mark - N020.头部广告 - 菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCookBookBannnerDetailRecipeDishVideoRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"1071795",
             @"return_request_id":@"",
             @"appqs":@"haodourecipe://haodou.com/recipe/info/?id=1071795&video=1",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N021.头部广告 - 菜谱制作过程 - 图片
+ (NSString *)getCookBookBannnerDetailRecipeDishPictureRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464003345147&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1464004126&nonce=0.5796810503835658&appsign=3e606ab403b62a827efa89ba69e14c46";
}
#pragma mark - N021.头部广告 - 菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCookBookBannnerDetailRecipeDishPictureRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"1071795",
             @"return_request_id":@"",
             @"appqs":@"haodourecipe://haodou.com/recipe/info/?id=1071795&video=0",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N022.搜索 - 热门专辑
+ (NSString *)getCookBookSearchHotsAlbumDetailRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464003345147&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getAlbumInfo&virtual=&signmethod=md5&v=2&timestamp=1464007590&nonce=0.4352785530701043&appsign=1a34c3a1e6f6562642f7f5768d9a4742";
}
#pragma mark - N022.搜索 - 热门专辑
+ (NSMutableDictionary *)getCookBookSearchHotsAlbumDetailRequestParams
{
    return @{@"uid":@"9798666",
             @"aid":@"60703",
             @"return_request_id":@"26ae6da7b6c1b21faef1a5ab1fccd707",
             @"offset":@"0",
             @"limit":@"20",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N023.头部搜索 - 菜谱制作过程 - 视屏
+ (NSString *)getCookBookSearchDetailDishVideoRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464003345147&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1464009819&nonce=0.605686122913885&appsign=651d1878fd01ce26ae719a6da38bc34a";
}
#pragma mark - N023.头部搜索 - 菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCookBookSearchDetailDishVideoRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"1016496",
             @"return_request_id":@"c6cea38d07d59e6d7d0b65dc9467b31a",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N024.头部搜索 - 菜谱制作过程 - 图片
+ (NSString *)getCookBookSearchDetailDishPictureRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464003345147&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1464009212&nonce=0.9375132545760037&appsign=cf526db5d4b364867afccb60198834cb";
}
#pragma mark - N024.头部搜索 - 菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCookBookSearchDetailDishPictureRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"263808",
             @"return_request_id":@"26ae6da7b6c1b21faef1a5ab1fccd707",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N025.摇一摇 - 菜谱制作过程 - 视屏
+ (NSString *)getCookBookShakeItOffDishVideoRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464001957319&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1464002687&nonce=0.20740962450677036&appsign=665e2113cea0446d6e3f78f87ef3407d";
}
#pragma mark - N025.摇一摇 - 菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCookBookShakeItOffDishVideoRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"858841",
             @"return_request_id":@"",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N026.摇一摇 - 菜谱制作过程 - 图片
+ (NSString *)getCookBookShakeItOffDishPictureRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464003345147&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getInfo&virtual=&signmethod=md5&v=2&timestamp=1464010528&nonce=0.3527169526623912&appsign=1550445ec542682fdcb456075d154b79";
}
#pragma mark - N026.摇一摇 - 菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCookBookShakeItOffDishPictureRequestParams
{
    return @{@"uid":@"9798666",
             @"rid":@"53026",
             @"return_request_id":@"",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}



#pragma mark - N027.视屏菜谱MP4
+ (NSString *)getCookBookDishVideoMP4RequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464242593898&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Info.getVideoUrl&virtual=&signmethod=md5&v=2&timestamp=1464251853&nonce=0.370684750812453&appsign=22b6b8cf43861ec060f882c4744920ac";
}
#pragma mark - N027.视屏菜谱MP4
+ (NSMutableDictionary *)getCookBookDishVideoMP4RequestParams
{
    return @{@"rid":@"53026"}.mutableCopy;
}


#pragma mark - N027.厨房宝典
+ (NSString *)getCookBookKitchenRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464576107391&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Wiki.getListByType&virtual=&signmethod=md5&v=2&timestamp=1464588211&nonce=0.026340558162819994&appsign=050889dc1a996c27390cc206a0a17f12";
}
#pragma mark - N027.厨房宝典
+ (NSMutableDictionary *)getCookBookKitchenRequestParams
{
    return @{@"tagid":@"0",
             @"limit":@"20",
             @"offset":@"0",
             @"type":@"1",
             @"appqs":@"haodourecipe://haodou.com/wiki/list/",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N028.晒作品
+ (NSString *)getCookBookShowProductRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464576107391&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Show.discovery&virtual=&signmethod=md5&v=2&timestamp=1464593045&nonce=0.37931975070846347&appsign=8d0848afdf8475e8c1b7a9a81dbdaaea";
}
#pragma mark - N028.晒作品
+ (NSMutableDictionary *)getCookBookShowProductRequestParams
{
    return @{@"uid":@"9798666",
             @"limit":@"10",
             @"offset":@"0",
             @"sign":@"a8b56ca6aefe903b94030c71e145d536",
             @"appqs":@"haodourecipe://haodou.com/find/",
             @"uuid":@"72b9cf70da593de0478cbb90f6025bf7"}.mutableCopy;
}


#pragma mark - N029.视屏
+ (NSString *)getCookBookShowVideoRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464674709074&vc=83&vn=6.1.0&loguid=9798666&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Video.getVideoListByCate&virtual=&signmethod=md5&v=2&timestamp=1464678841&nonce=0.9873694802201092&appsign=0a84e8c73803710ad10c6bd2cd2a1780";
}
#pragma mark - N029.视屏
+ (NSMutableDictionary *)getCookBookShowVideoRequestParams
{
    NSMutableDictionary *dictParams = @{@"type":@"1",
                                        @"limit":@"20",
                                        @"offset":@"0",
                                        @"cate_id":@"49"}.mutableCopy;
    return dictParams;
}


#pragma mark - N030.评论
+ (NSString *)getCookBookCommentInfoRequestURLString
{
    return @"http://api.haodou.com/index.php?appid=2&appkey=9ef269eec4f7a9d07c73952d06b5413f&format=json&sessionid=1464693162233&vc=83&vn=6.1.0&loguid=9832584&deviceid=haodou864601020999058&uuid=72b9cf70da593de0478cbb90f6025bf7&channel=huawei_v610&method=Comment.getList&virtual=&signmethod=md5&v=2&timestamp=1464695201&nonce=0.04330409132841262&appsign=ee52ce53b8f816ff560035c45500c2ca";
}
#pragma mark - N030.评论
+ (NSMutableDictionary *)getCookBookCommentInfoRequestParams
{
    return @{@"cid":@"",
             @"uid":@"9832584",
             @"limit":@"10",
             @"offset":@"0",
             @"rid":@"850877",
             @"sign":@"1133e1de8081f6500b20d31f3f6729e3",
             @"type":@"0"}.mutableCopy;
}






@end
