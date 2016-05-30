//
//  YHSCookBookKitchenModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSCookBookKitchenModel : NSObject

@property (nonatomic, assign) NSInteger ItemId;

@property (nonatomic, copy) NSString *Collection;

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, assign) NSInteger Type;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *Image;

@property (nonatomic, copy) NSString *Content;

@property (nonatomic, copy) NSString *OpenUrl;

@end
