//
//  YHSCookBookHotsAlbumDetailInfoModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 头部模型
@interface YHSCookBookHotsAlbumDetailInfoModel : NSObject

@property (nonatomic, copy) NSString *AlbumContent;

@property (nonatomic, copy) NSString *AlbumTitle;

@property (nonatomic, copy) NSString *CommentCount;

@property (nonatomic, assign) NSInteger AlbumIsLike;

@property (nonatomic, copy) NSString *AlbumAvatarUrl;

@property (nonatomic, assign) NSInteger AlbumUserId;

@property (nonatomic, copy) NSString *AlbumUserName;

@property (nonatomic, copy) NSString *AlbumCover;

@end
