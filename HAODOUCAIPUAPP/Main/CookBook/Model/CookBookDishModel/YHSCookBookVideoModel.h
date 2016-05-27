//
//  YHSCookBookVideoModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/26.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHSCookBookVideoStepModel;

@interface YHSCookBookVideoModel : NSObject

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, assign) NSInteger Duration;

@property (nonatomic, assign) NSInteger Size;

@property (nonatomic, strong) NSArray<YHSCookBookVideoStepModel *> *Steps;

@end


@interface YHSCookBookVideoStepModel : NSObject

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, strong) NSString *num;

@property (nonatomic, assign) NSInteger Point;

@property (nonatomic, assign) NSInteger Stepid;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, assign) NSInteger StepDuration;

@property (nonatomic, copy) NSString *Image;

@end

