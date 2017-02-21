//
//  YHSTopicGroupHotTitleModel.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHSTopicGroupHotTitleModel : NSObject

@property (nonatomic, copy) NSString *Url;

@property (nonatomic, assign) NSInteger DigCount;

@property (nonatomic, copy) NSString *Img;

@property (nonatomic, copy) NSString *Avatar;

@property (nonatomic, copy) NSString *UserName;

@property (nonatomic, assign) NSInteger UserId;

@property (nonatomic, assign) NSInteger TagId;

@property (nonatomic, copy) NSString *PreviewContent;

@property (nonatomic, assign) NSInteger TopicId;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, copy) NSString *TagName;

@property (nonatomic, assign) NSInteger Vip;

@property (nonatomic, assign) NSInteger CommentCount;

@end
