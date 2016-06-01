//
//  YHSCookBookCommentModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSCookBookCommentModel : NSObject

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, assign) NSInteger Cid;

@property (nonatomic, copy) NSString *PhotoId;

@property (nonatomic, copy) NSString *ImageSmallUrl;

@property (nonatomic, copy) NSString *AtContent;

@property (nonatomic, assign) NSInteger IsAuthor;

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *ImageUrl;

@property (nonatomic, assign) NSInteger AtUserId;

@property (nonatomic, assign) NSInteger IsVip;

@property (nonatomic, copy) NSString *PhotoUrl;

@property (nonatomic, copy) NSString *AtImageUrl;

@property (nonatomic, copy) NSString *CreateTime;

@property (nonatomic, assign) NSInteger Gender;

@property (nonatomic, copy) NSString *AtImageSmallUrl;

@property (nonatomic, assign) NSInteger PhotoFlag;

@property (nonatomic, copy) NSString *AtUserName;

@end
