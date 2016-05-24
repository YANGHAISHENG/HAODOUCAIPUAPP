//
//  YHSCookBookHotsAlbumDetailElemModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 元素模型
@interface YHSCookBookHotsAlbumDetailElemModel : NSObject

@property (nonatomic, copy) NSString *Collection;

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *Intro;

@property (nonatomic, assign) NSInteger RecipeId;

@property (nonatomic, copy) NSString *Stuff;

@property (nonatomic, assign) NSInteger HasVideo;

@property (nonatomic, copy) NSString *Duration;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger LikeCount;

@property (nonatomic, assign) NSInteger IsLike;

@property (nonatomic, copy) NSString *Cover;

@property (nonatomic, assign) NSInteger ViewCount;

@end







