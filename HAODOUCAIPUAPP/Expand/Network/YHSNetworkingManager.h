//
//  YHSNetworkingManager.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/16.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

// 网络状态
typedef NS_ENUM(NSInteger, YHSNetworkReachabilityStatus) {
    YHSNetworkReachabilityStatusUnknown          = -1,//未识别的网络
    YHSNetworkReachabilityStatusNotReachable     = 0,//不可达的网络(未连接)
    YHSNetworkReachabilityStatusReachableViaWWAN = 1,//2G,3G,4G...
    YHSNetworkReachabilityStatusReachableViaWiFi = 2,//wifi网络
};


@interface YHSNetworkingManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager; // 网络请求Session
@property (nonatomic, assign) YHSNetworkReachabilityStatus networkReachabilityStatus; // 当前网络状态

+ (instancetype)sharedYHSNetworkingManagerInstance;
@end
