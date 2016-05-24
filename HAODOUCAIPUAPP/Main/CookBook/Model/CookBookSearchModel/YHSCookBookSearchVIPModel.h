//
//  YHSCookBookSearchVIPModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSCookBookSearchVIPModel : NSObject

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, assign) NSInteger Vip;

@property (nonatomic, assign) NSInteger Relation;

@property (nonatomic, copy) NSString *LastAct;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, assign) NSInteger RecipeCnt;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, assign) NSInteger PhotoCnt;

@end
