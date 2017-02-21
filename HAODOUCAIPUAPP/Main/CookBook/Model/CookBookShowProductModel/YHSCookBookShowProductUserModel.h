//
//  YHSCookBookShowProductUserModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHSCookBookShowProductUserItemModel;


@interface YHSCookBookShowProductUserModel : NSObject
@property (nonatomic, copy) NSString *ItemType;
@property (nonatomic, strong) NSArray<YHSCookBookShowProductUserItemModel *> *List;
@end


@interface YHSCookBookShowProductUserItemModel : NSObject

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, copy) NSString *OpenUrl;

@end

