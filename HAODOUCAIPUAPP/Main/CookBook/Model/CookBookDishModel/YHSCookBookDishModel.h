//
//  YHSCookBookDishModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/25.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHSCookBookDishAd_DataModel,YHSCookBookDishUserInfoModel,YHSCookBookDishUserInfoFavoritelistModel,YHSCookBookDishRewardModel,YHSCookBookDishRecommendtopicModel,YHSCookBookDishStuffModel,YHSCookBookDishCommentlistModel,YHSCookBookDishLastdiggusersModel,YHSCookBookDishProductModel,YHSCookBookDishStepsModel,YHSCookBookDishTagsModel,YHSCookBookDishMainStuffModel,YHSCookBookDishOtherStuffModel,YHSCookBookDishAlbumModel;

@interface YHSCookBookDishModel : NSObject

@property (nonatomic, assign) BOOL isExpandedAllIntro; // 是否已展开全部介绍信息

@property (nonatomic, strong) NSArray<YHSCookBookDishRecommendtopicModel *> *RecommendTopic;

@property (nonatomic, copy) NSString *CommentCount;

@property (nonatomic, assign) NSInteger ProductCount;

@property (nonatomic, assign) NSInteger AlbumCount;

@property (nonatomic, copy) NSString *AlbumMoreUrl;

@property (nonatomic, copy) NSString *ReadyTime;

@property (nonatomic, assign) NSInteger PhotoCount;

@property (nonatomic, strong) NSArray<YHSCookBookDishMainStuffModel *> *MainStuff;

@property (nonatomic, strong) YHSCookBookDishUserInfoModel *UserInfo;

@property (nonatomic, strong) YHSCookBookDishRewardModel *Reward;

@property (nonatomic, copy) NSString *Intro;

@property (nonatomic, copy) NSString *Cover;

@property (nonatomic, assign) NSInteger DiggCount;

@property (nonatomic, strong) NSArray<YHSCookBookDishAlbumModel *> *Album;

@property (nonatomic, assign) NSInteger ViewCount;

@property (nonatomic, strong) NSArray<YHSCookBookDishProductModel *> *Product;

@property (nonatomic, strong) NSArray<YHSCookBookDishTagsModel *> *Tags;

@property (nonatomic, copy) NSString *TalkUrl;

@property (nonatomic, copy) NSString *MallUrl;

@property (nonatomic, copy) NSString *UserCount;

@property (nonatomic, strong) NSArray<NSString *> *PhotoList;

@property (nonatomic, strong) NSArray<YHSCookBookDishCommentlistModel *> *CommentList;

@property (nonatomic, copy) NSString *DiggUsersUrl;

@property (nonatomic, assign) NSInteger ad_flag;

@property (nonatomic, copy) NSString *Tips;

@property (nonatomic, assign) NSInteger RecipeId;

@property (nonatomic, assign) NSInteger Status;

@property (nonatomic, copy) NSString *Duration;

@property (nonatomic, assign) NSInteger Rate;

@property (nonatomic, strong) NSArray<YHSCookBookDishLastdiggusersModel *> *LastDiggUsers;

@property (nonatomic, assign) NSInteger IsDigg;

@property (nonatomic, copy) NSString *ReviewTime;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, strong) NSArray<YHSCookBookDishStuffModel *> *Stuff;

@property (nonatomic, copy) NSString *CookTime;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, assign) NSInteger LikeCount;

@property (nonatomic, copy) NSString *Collection;

@property (nonatomic, assign) NSInteger HasVideo;

@property (nonatomic, assign) NSInteger IsLike;

@property (nonatomic, copy) NSString *VideoCover;

@property (nonatomic, strong) YHSCookBookDishAd_DataModel *ad_data;

@property (nonatomic, strong) NSArray<YHSCookBookDishOtherStuffModel *> *OtherStuff;

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, assign) NSInteger Type;

@property (nonatomic, strong) NSArray<YHSCookBookDishStepsModel *> *Steps;

@end


@interface YHSCookBookDishAd_DataModel : NSObject

@end

@interface YHSCookBookDishUserInfoModel : NSObject

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, assign) NSInteger Gender;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, strong) NSArray<YHSCookBookDishUserInfoFavoritelistModel *> *FavoriteList;

@property (nonatomic, assign) NSInteger Relation;

@property (nonatomic, assign) NSInteger Vip;

@property (nonatomic, copy) NSString *OpenUrl;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *Intro;

@end

@interface YHSCookBookDishUserInfoFavoritelistModel : NSObject

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *Name;

@end

@interface YHSCookBookDishRewardModel : NSObject

@property (nonatomic, strong) NSArray<NSString *> *Words;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *UserListUrl;

@property (nonatomic, copy) NSString *UserListDesc;

@property (nonatomic, assign) NSInteger IsReward;

@property (nonatomic, assign) NSInteger Type;

@property (nonatomic, assign) NSInteger RewardCount;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Desc;

@property (nonatomic, assign) NSInteger RewardAble;

@end

@interface YHSCookBookDishRecommendtopicModel : NSObject

@property (nonatomic, copy) NSString *TopicId;

@property (nonatomic, copy) NSString *UserId;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, copy) NSString *LastPostTime;

@property (nonatomic, copy) NSString *Collection;

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *CommentCount;

@end

@interface YHSCookBookDishStuffModel : NSObject

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, assign) NSInteger cateid;

@property (nonatomic, assign) NSInteger food_flag;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *cate;

@property (nonatomic, copy) NSString *name;

@end

@interface YHSCookBookDishCommentlistModel : NSObject

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, assign) NSInteger Cid;

@property (nonatomic, copy) NSString *ImageSmallUrl;

@property (nonatomic, copy) NSString *AtImageSmallUrl;

@property (nonatomic, copy) NSString *AtContent;

@property (nonatomic, assign) NSInteger IsAuthor;

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *ImageUrl;

@property (nonatomic, assign) NSInteger AtUserId;

@property (nonatomic, assign) NSInteger IsVip;

@property (nonatomic, copy) NSString *AtImageUrl;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, assign) NSInteger Gender;

@property (nonatomic, copy) NSString *AtUserName;

@end

@interface YHSCookBookDishLastdiggusersModel : NSObject

@property (nonatomic, copy) NSString *OpenUrl;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, copy) NSString *UserId;

@end

@interface YHSCookBookDishProductModel : NSObject

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, assign) NSInteger IsDigg;

@property (nonatomic, assign) NSInteger DiggCount;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, assign) NSInteger Pid;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *OpenUrl;

@property (nonatomic, copy) NSString *Url;

@end

@interface YHSCookBookDishStepsModel : NSObject

@property (nonatomic, copy) NSString *num;

@property (nonatomic, copy) NSString *Intro;

@property (nonatomic, copy) NSString *StepPhoto;

@end

@interface YHSCookBookDishTagsModel : NSObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Name;

@end

@interface YHSCookBookDishMainStuffModel : NSObject

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, assign) NSInteger cateid;

@property (nonatomic, assign) NSInteger food_flag;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *cate;

@property (nonatomic, copy) NSString *name;

@end

@interface YHSCookBookDishOtherStuffModel : NSObject

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, assign) NSInteger cateid;

@property (nonatomic, assign) NSInteger food_flag;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *cate;

@property (nonatomic, copy) NSString *name;

@end

@interface YHSCookBookDishAlbumModel : NSObject

@property (nonatomic, copy) NSString *Cover;

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, assign) NSInteger Cid;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger RecipeCount;

@end

