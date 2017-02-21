//
//  YHSCookBookGoodsModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHSCookBookGoodsElemModel;


@interface YHSCookBookGoodsModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<YHSCookBookGoodsElemModel *> *goodElemList;

@end


@interface YHSCookBookGoodsElemModel : NSObject

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, copy) NSString *SubTitle;

@end

