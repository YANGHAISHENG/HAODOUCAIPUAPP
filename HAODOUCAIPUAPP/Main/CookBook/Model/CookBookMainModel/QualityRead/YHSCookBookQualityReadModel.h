//
//  YHSCookBookQualityReadModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHSCookBookQualityReadElemModel;

@interface YHSCookBookQualityReadModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger Count;

@property (nonatomic, strong) NSArray<YHSCookBookQualityReadElemModel *> *readList;

@end


@interface YHSCookBookQualityReadElemModel : NSObject

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, copy) NSString *Intro;

@end

