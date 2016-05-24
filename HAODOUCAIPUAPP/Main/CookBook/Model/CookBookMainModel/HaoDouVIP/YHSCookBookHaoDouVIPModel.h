//
//  YHSCookBookHaoDouVIPModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/14.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHSCookBookHaoDouVIPElemModel;
@interface YHSCookBookHaoDouVIPModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, strong) NSArray<YHSCookBookHaoDouVIPElemModel *> *vipList;

@end


@interface YHSCookBookHaoDouVIPElemModel : NSObject

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, copy) NSString *Url;

@end

