//
//  YHSCookBookYourLoveMoreModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/19.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHSCookBookYourLoveMoreTagModel;

@interface YHSCookBookYourLoveMoreModel : NSObject

@property (nonatomic, assign) NSInteger LikeCount;

@property (nonatomic, assign) NSInteger IsLike;

@property (nonatomic, copy) NSString *Cover;

@property (nonatomic, assign) NSInteger RecipeId;

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, assign) NSInteger HasVideo;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, strong) NSArray<YHSCookBookYourLoveMoreTagModel *> *Tags;

@property (nonatomic, copy) NSString *CreateTime;

@end


@interface YHSCookBookYourLoveMoreTagModel : NSObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Name;

@end

