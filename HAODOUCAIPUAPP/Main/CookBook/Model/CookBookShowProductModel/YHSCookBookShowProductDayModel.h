//
//  YHSCookBookShowProductDayModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHSCookBookShowProductDayItemModel;

@interface YHSCookBookShowProductDayModel : NSObject

@property (nonatomic, copy) NSString *ItemType;

@property (nonatomic, strong) NSArray<YHSCookBookShowProductDayItemModel *> *List;

@end


@interface YHSCookBookShowProductDayItemModel : NSObject

@property (nonatomic, copy) NSString *ThemeTitle;

@property (nonatomic, assign) NSInteger Pid;

@property (nonatomic, copy) NSString *OpenUrl;

@property (nonatomic, copy) NSString *ThemeCover;

@property (nonatomic, assign) NSInteger PhotoCount;

@property (nonatomic, assign) NSInteger TopicId;

@end

