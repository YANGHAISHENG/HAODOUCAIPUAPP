//
//  YHSCookBookRecommedModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHSCookBookRecommedElemModel, YHSCookBookRecommedADModel;


@interface YHSCookBookRecommedModel : NSObject

@property (nonatomic, strong) NSArray<YHSCookBookRecommedElemModel *> *recommedElemList;

@property (nonatomic, strong) YHSCookBookRecommedADModel *recommedAD;

@end


@interface YHSCookBookRecommedADModel : NSObject

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, copy) NSString *Url;

@end


@interface YHSCookBookRecommedElemModel : NSObject

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, copy) NSString *Intro;

@end

