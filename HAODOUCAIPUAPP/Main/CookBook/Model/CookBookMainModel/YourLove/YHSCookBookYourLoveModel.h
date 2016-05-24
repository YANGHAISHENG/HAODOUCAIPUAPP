//
//  YHSCookBookYourLoveModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/12.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHSCookBookYourLoveElemModel;

@interface YHSCookBookYourLoveModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray<YHSCookBookYourLoveElemModel *> *tag;
@end

@interface YHSCookBookYourLoveElemModel : NSObject
@property (nonatomic, assign) NSInteger CateId;
@property (nonatomic, copy) NSString *CateName;
@property (nonatomic, copy) NSString *Url;
@property (nonatomic, copy) NSString *Cover;
@property (nonatomic, assign) NSInteger HasVideo;
@property (nonatomic, copy) NSString *OpenUrl;
@end