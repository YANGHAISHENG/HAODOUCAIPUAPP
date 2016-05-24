//
//  YHSCategoryModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/17.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHSCategoryElemModel;


@interface YHSCategoryModel : NSObject

@property (nonatomic, copy) NSString *Cate;

@property (nonatomic, copy) NSString *ImgUrl;

@property (nonatomic, strong) NSArray<YHSCategoryElemModel *> *Tags;

@end


@interface YHSCategoryElemModel : NSObject

@property (nonatomic, assign) NSInteger Id;

@property (nonatomic, copy) NSString *Name;

@end

