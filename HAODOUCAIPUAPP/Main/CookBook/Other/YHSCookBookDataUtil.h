//
//  YHSCookBookDataUtil.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/11.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSCookBookDataUtil : NSObject

#pragma mark - N001.首页请求数据
+ (NSString *)getCookBookMainRequestURLString;
#pragma mark - N001.首页请求数据
+ (NSMutableDictionary *)getCookBookMainRequestParams;


#pragma mark - N002.首页导航分类请求数据
+ (NSString *)getCategoryRequestURLString;
#pragma mark - N002.首页导航分类请求数据
+ (NSMutableDictionary *)getCategoryRequestParams;


#pragma mark - N003.分类标签搜索结果
+ (NSString *)getCategorySearchRequestURLString;
#pragma mark - N003.分类标签搜索结果
+ (NSMutableDictionary *)getCategorySearchRequestParams;

#pragma mark - N004.猜你喜欢结果
+ (NSString *)getYourLoveRequestURLString;
#pragma mark - N004.猜你喜欢结果
+ (NSMutableDictionary *)getYourLoveRequestParams;


#pragma mark - N005.猜你喜欢头部点击结果
+ (NSString *)getYourLoveHeaderSectionRequestURLString;
#pragma mark - N005.猜你喜欢头部点击结果
+ (NSMutableDictionary *)getYourLoveHeaderSectionRequestParams;


#pragma mark - N006.导航搜索查询
+ (NSString *)getSearchByKeyRequestURLString;
#pragma mark - N006.导航搜索查询
+ (NSMutableDictionary *)getSearchByKeyRequestParams;


#pragma mark - N007.导航搜索查询-详细信息
+ (NSString *)getSearchResultDetailRequestURLString;
#pragma mark - N007.导航搜索查询-详细信息
+ (NSMutableDictionary *)getSearchResultDetailRequestParams;


#pragma mark - N008.搜索豆友列表
+ (NSString *)getSearchVIPInfoRequestURLString;
#pragma mark - N008.搜索豆友列表
+ (NSMutableDictionary *)getSearchVIPInfoRequestParams;


#pragma mark - N009.热门专辑详情-主页
+ (NSString *)getCookBookHotsAlbumMainDetailRequestURLString;
#pragma mark - N009.热门专辑详情-主页
+ (NSMutableDictionary *)getCookBookHotsAlbumMainDetailRequestParams;


#pragma mark - N010.热门专辑-推荐
+ (NSString *)getCookBookHotsAlbumMoreRecommendRequestURLString;
#pragma mark - N010.热门专辑-推荐
+ (NSMutableDictionary *)getCookBookHotsAlbumMoreRecommendRequestParams;


#pragma mark - N011.热门专辑-全部
+ (NSString *)getCookBookHotsAlbumMoreAllRequestURLString;
#pragma mark - N011.热门专辑-全部
+ (NSMutableDictionary *)getCookBookHotsAlbumMoreAllRequestParams;


#pragma mark - N012.热门专辑详情-TAB页面
+ (NSString *)getCookBookHotsAlbumTabDetailRequestURLString;
#pragma mark - N012.热门专辑详情-TAB页面
+ (NSMutableDictionary *)getCookBookHotsAlbumTabDetailRequestParams;


#pragma mark - N013.广告栏详情页面（Collect）-主页
+ (NSString *)getCookBookBannerDetailCollectRequestURLString;
#pragma mark - N013.广告栏详情页面（Collect）-主页
+ (NSMutableDictionary *)getCookBookBannerDetailCollectRequestParams;


#pragma mark - N014.摇一摇
+ (NSString *)getCookBookShakeItOffRequestURLString;
#pragma mark - N014.摇一摇
+ (NSMutableDictionary *)getCookBookShakeItOffRequestParams;


#pragma mark - N015.菜谱制作过程 - 视屏
+ (NSString *)getCookBookDishVideoRequestURLString;
#pragma mark - N015.菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCookBookDishVideoRequestParams;


#pragma mark - N016.菜谱制作过程 - 图片
+ (NSString *)getCookBookDishPictureRequestURLString;
#pragma mark - N016.菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCookBookDishPictureRequestParams;


#pragma mark - N017.分类 - 菜谱制作过程 - 视屏
+ (NSString *)getCategoryDishVideoRequestURLString;
#pragma mark - N017.分类 - 菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCategoryDishVideoRequestParams;

#pragma mark - N018.分类 - 菜谱制作过程 - 图片
+ (NSString *)getCategoryDishPictureRequestURLString;
#pragma mark - N018.分类 - 菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCategoryDishPictureRequestParams;


#pragma mark - N019.猜你喜欢 - 菜谱制作过程 - 视屏
+ (NSString *)getCookBookYourLoveDishVideoRequestURLString;
#pragma mark - N019.猜你喜欢 - 菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCookBookYourLoveDishVideoRequestParams;


#pragma mark - N020.猜你喜欢 - 菜谱制作过程 - 图片
+ (NSString *)getCookBookYourLoveDishPictureRequestURLString;
#pragma mark - N020.猜你喜欢 - 菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCookBookYourLoveDishPictureRequestParams;


#pragma mark - N020.头部广告 - 菜谱制作过程 - 视屏
+ (NSString *)getCookBookBannnerDetailRecipeDishVideoRequestURLString;
#pragma mark - N020.头部广告 - 菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCookBookBannnerDetailRecipeDishVideoRequestParams;


#pragma mark - N021.头部广告 - 菜谱制作过程 - 图片
+ (NSString *)getCookBookBannnerDetailRecipeDishPictureRequestURLString;
#pragma mark - N021.头部广告 - 菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCookBookBannnerDetailRecipeDishPictureRequestParams;


#pragma mark - N022.搜索 - 热门专辑
+ (NSString *)getCookBookSearchHotsAlbumDetailRequestURLString;
#pragma mark - N022.搜索 - 热门专辑
+ (NSMutableDictionary *)getCookBookSearchHotsAlbumDetailRequestParams;


#pragma mark - N023.头部搜索 - 菜谱制作过程 - 视屏
+ (NSString *)getCookBookSearchDetailDishVideoRequestURLString;
#pragma mark - N023.头部搜索 - 菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCookBookSearchDetailDishVideoRequestParams;


#pragma mark - N024.头部搜索 - 菜谱制作过程 - 图片
+ (NSString *)getCookBookSearchDetailDishPictureRequestURLString;
#pragma mark - N024.头部搜索 - 菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCookBookSearchDetailDishPictureRequestParams;


#pragma mark - N025.摇一摇 - 菜谱制作过程 - 视屏
+ (NSString *)getCookBookShakeItOffDishVideoRequestURLString;
#pragma mark - N025.摇一摇 - 菜谱制作过程 - 视屏
+ (NSMutableDictionary *)getCookBookShakeItOffDishVideoRequestParams;


#pragma mark - N026.摇一摇 - 菜谱制作过程 - 图片
+ (NSString *)getCookBookShakeItOffDishPictureRequestURLString;
#pragma mark - N026.摇一摇 - 菜谱制作过程 - 图片
+ (NSMutableDictionary *)getCookBookShakeItOffDishPictureRequestParams;


@end





