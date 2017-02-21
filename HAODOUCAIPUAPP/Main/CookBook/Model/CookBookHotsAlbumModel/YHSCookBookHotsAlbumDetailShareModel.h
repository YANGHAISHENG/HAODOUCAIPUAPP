//
//  YHSCookBookHotsAlbumDetailShareModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/22.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 头部说明
@interface YHSCookBookHotsAlbumDetailShareModel : NSObject

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *Desc;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, assign) BOOL isExpanded; // 是否已经展开

@end
