//
//  YHSCookBookDishFoodMaterialModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/27.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSCookBookDishFoodMaterialModel : NSObject

@property (nonatomic, assign) BOOL isMainMaterial;

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, assign) NSInteger cateid;

@property (nonatomic, assign) NSInteger food_flag;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *cate;

@property (nonatomic, copy) NSString *name;


@end
