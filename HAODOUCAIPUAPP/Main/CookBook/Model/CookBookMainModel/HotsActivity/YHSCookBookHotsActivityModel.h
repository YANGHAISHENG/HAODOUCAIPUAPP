//
//  YHSCookBookHotsActivityModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHSCookBookHotsActivityElemModel;


@interface YHSCookBookHotsActivityModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) NSArray<YHSCookBookHotsActivityElemModel *> *activityList;

@end


@interface YHSCookBookHotsActivityElemModel : NSObject

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, copy) NSString *Intro;

@end

