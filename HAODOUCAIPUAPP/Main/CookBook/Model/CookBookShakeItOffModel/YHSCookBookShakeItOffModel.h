//
//  YHSCookBookShakeItOffModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSCookBookShakeItOffModel : NSObject

@property (nonatomic, copy) NSString *Cover;

@property (nonatomic, assign) NSInteger RecipeId;

@property (nonatomic, assign) NSInteger ViewCount;

@property (nonatomic, assign) NSInteger LikeCount;

@property (nonatomic, copy) NSString *Stuff;

@property (nonatomic, copy) NSString *Duration;

@property (nonatomic, assign) NSInteger FavoriteCount;

@property (nonatomic, copy) NSString *Collection;

@property (nonatomic, assign) NSInteger HasVideo;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *CateName;

@end
