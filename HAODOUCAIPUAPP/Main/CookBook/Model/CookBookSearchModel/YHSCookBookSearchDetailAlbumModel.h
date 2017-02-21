//
//  YHSCookBookSearchDetailAlbumModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/20.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSCookBookSearchDetailAlbumModel : NSObject

@property (nonatomic, copy) NSString *Cover;

@property (nonatomic, assign) NSInteger ViewCount;

@property (nonatomic, assign) NSInteger LikeCount;

@property (nonatomic, copy) NSString *Id;

@property (nonatomic, copy) NSString *Collection;

@property (nonatomic, assign) NSInteger RecipeCount;

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *AlbumId;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *Intro;

@end
