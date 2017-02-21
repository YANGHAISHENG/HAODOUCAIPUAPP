//
//  YHSCookBookShowProductCateModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/30.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHSCookBookShowProductCateItemModel;

@interface YHSCookBookShowProductCateModel : NSObject

@property (nonatomic, assign) NSInteger index; // 行下标，确定Cell的样式

@property (nonatomic, copy) NSString *OpenUrl;

@property (nonatomic, strong) NSArray<YHSCookBookShowProductCateItemModel *> *List;

@property (nonatomic, copy) NSString *TopicName;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *ItemType;

@property (nonatomic, assign) NSInteger TopicId;

@end


@interface YHSCookBookShowProductCateItemModel : NSObject

@property (nonatomic, copy) NSString *Cover;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, copy) NSString *OpenUrl;

@property (nonatomic, copy) NSString *Count;

@property (nonatomic, assign) NSInteger Id;

@end

