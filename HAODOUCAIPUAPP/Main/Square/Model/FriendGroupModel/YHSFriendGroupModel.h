//
//  YHSFriendGroupModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHSFriendGroupCommonElemModel, YHSFriendGroupFavoriteElemModel;

@interface YHSFriendGroupModel : NSObject

@property (nonatomic, copy) NSString *SameFeature;

@property (nonatomic, assign) NSInteger entityType;

@property (nonatomic, strong) NSArray<YHSFriendGroupFavoriteElemModel *> *FavoriteList;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, copy) NSString *Intro;

@property (nonatomic, assign) NSInteger Relation;

@property (nonatomic, copy) NSString *ListUrl;

@property (nonatomic, strong) YHSFriendGroupCommonElemModel *CommonInfo;

@property (nonatomic, copy) NSString *Address;

@property (nonatomic, assign) NSInteger Gender;

@property (nonatomic, assign) NSInteger Vip;

@property (nonatomic, copy) NSString *OpenUrl;

@property (nonatomic, assign) NSInteger StyleType;

@end


@interface YHSFriendGroupCommonElemModel : NSObject

@property (nonatomic, assign) NSInteger TagId;

@property (nonatomic, copy) NSString *TagUrl;

@property (nonatomic, assign) NSInteger CommonId;

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Desc;

@property (nonatomic, copy) NSString *TagName;

@end


@interface YHSFriendGroupFavoriteElemModel : NSObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Name;

@end

