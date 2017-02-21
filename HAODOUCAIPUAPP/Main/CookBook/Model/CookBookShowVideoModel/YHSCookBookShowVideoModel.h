//
//  YHSCookBookShowVideoModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSCookBookShowVideoModel : NSObject

@property (nonatomic, assign) NSInteger PlayCount;

@property (nonatomic, copy) NSString *Cover;

@property (nonatomic, assign) NSInteger IsDigg;

@property (nonatomic, copy) NSString *VideoUrl;

@property (nonatomic, copy) NSString *CommentUrl;

@property (nonatomic, assign) NSInteger Type;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, assign) NSInteger DiggCount;

@property (nonatomic, copy) NSString *VideoId;

@property (nonatomic, assign) NSInteger CommentCount;

@end
