//
//  YHSDynamicGroupModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/7.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHSDynamicGroupUserInfoModel, YHSDynamicGroupDataModel, YHSDynamicGroupCommentElemModel;

@interface YHSDynamicGroupModel : NSObject

@property (nonatomic, strong) YHSDynamicGroupUserInfoModel *userInfo;

@property (nonatomic, strong) YHSDynamicGroupDataModel *data;

@end


@interface YHSDynamicGroupUserInfoModel : NSObject

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, assign) NSInteger Gender;

@property (nonatomic, assign) NSInteger Vip;

@property (nonatomic, assign) NSInteger Relation;

@property (nonatomic, copy) NSString *OpenUrl;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *Intro;

@end


@interface YHSDynamicGroupDataModel : NSObject

@property (nonatomic, copy) NSString *FormatTime;

@property (nonatomic, copy) NSString *TagName;

@property (nonatomic, assign) NSInteger FeedId;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger DiggType;

@property (nonatomic, assign) NSInteger IsDigg;

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, assign) NSInteger EntityType;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, assign) NSInteger DiggCnt;

@property (nonatomic, copy) NSString *CommentUrl;

@property (nonatomic, assign) NSInteger CommentCnt;

@property (nonatomic, copy) NSString *Address;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, assign) NSInteger DiggId;

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, assign) NSInteger ActionType;

@property (nonatomic, copy) NSString *TagUrl;

@property (nonatomic, copy) NSString *CmtContent;

@property (nonatomic, strong) NSArray<YHSDynamicGroupCommentElemModel *> *CommentList;

@property (nonatomic, assign) NSInteger HasVideo;

@property (nonatomic, assign) NSInteger TagId;

@end


@interface YHSDynamicGroupCommentElemModel : NSObject

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, assign) NSInteger Cid;

@property (nonatomic, assign) NSInteger IsAuthor;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *OpenUrl;

@property (nonatomic, assign) NSInteger IsVip;

@end

