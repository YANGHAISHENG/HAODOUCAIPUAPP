//
//  YHSBackHomeGoodsModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/3.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSBackHomeGoodsModel : NSObject

@property (nonatomic, assign) NSInteger StoreId;

@property (nonatomic, copy) NSString *ShippingInfo;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *StoreTitle;

@property (nonatomic, copy) NSString *StoreLogoUrl;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, assign) NSInteger Stock;

@property (nonatomic, assign) NSInteger IsShippingFree;

@property (nonatomic, copy) NSString *SubTitle;

@property (nonatomic, copy) NSString *DealPrice;

@property (nonatomic, copy) NSString *CoverUrl;

@property (nonatomic, assign) NSInteger CartNum;

@property (nonatomic, assign) NSInteger LikeCount;

@property (nonatomic, assign) NSInteger IsLike;

@property (nonatomic, copy) NSString *UserId;

@property (nonatomic, copy) NSString *OpenUrl;

@property (nonatomic, assign) NSInteger GoodsId;

@property (nonatomic, strong) NSArray<NSString *> *Labels;

@property (nonatomic, copy) NSString *Weight;

@property (nonatomic, copy) NSString *Price;

@end
