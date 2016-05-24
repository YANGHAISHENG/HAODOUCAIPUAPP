//
//  YHSCookBookHotsAlbumTabViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/21.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicNetworkReachabilityViewController.h"

@interface YHSCookBookHotsAlbumTabViewController : YHSBasicNetworkReachabilityViewController

@property (nonatomic, strong) NSString *appqs; // haodourecipe://haodou.com/collect/list/
@property (nonatomic, strong) NSString *type; // 0/1
@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, strong) NSString *request_id; // 0ba5cb08e3d53747acfc081eb1afd5c2
@property (nonatomic, strong) NSString *uuid;

@end
