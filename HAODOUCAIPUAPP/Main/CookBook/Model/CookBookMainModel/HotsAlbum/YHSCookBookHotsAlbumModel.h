//
//  YHSCookBookHotsAlbumModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/12.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHSCookBookAlbumElemModel,YHSCookBookAlbumSmallModel;

@interface YHSCookBookHotsAlbumModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, strong) NSArray<YHSCookBookAlbumElemModel *> *albumElemModelList;
@end


@interface YHSCookBookAlbumElemModel : NSObject
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Img;
@property (nonatomic, copy) NSString *Url;
@property (nonatomic, copy) NSString *Recipe;
@property (nonatomic, strong) NSArray<YHSCookBookAlbumSmallModel *> *albumSmallModelList;
@end

@interface YHSCookBookAlbumSmallModel : NSObject
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Cover;
@end

