//
//  YHSNetworkingManager.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/16.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSNetworkingManager.h"
#import "YHSSysMacro.h"
#import "YHSSysConst.h"


@implementation YHSNetworkingManager

+ (instancetype)sharedYHSNetworkingManagerInstance
{
    static YHSNetworkingManager *_singetonInstance = nil; // 必须声明为静态变量
    static dispatch_once_t onceToken; // dispatch_once保证了blocks只能执行一次
    dispatch_once(&onceToken,^{
        if (nil == _singetonInstance) {
            // 这里不是使用alloc，而是调用[[super allocWithZone:NULL] init]，为什么是super而不是self呢？
            // 这是因为调用alloc方法时，OC内部会调用allocWithZone:这个方法来申请内存，然而已经在self中覆写了
            // 基本对象的分配方法，所以需要借用父类的（NSobject）的功能帮助处理底层内存分配的杂务。
            _singetonInstance = [[super allocWithZone:NULL] init];

            
            // 1.网络请求Session
            _singetonInstance.manager = [AFHTTPSessionManager manager];

            
            // 2.监听网络状态
            AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];// 创建网络监听管理者
            [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) { // 设置网络变化的回调
                static NSString *KEY = @"NetworkReachabilityStatus";
                switch (status) {
                    case AFNetworkReachabilityStatusUnknown: {
                        YHSLogLight(@"未识别的网络");
                        _singetonInstance.networkReachabilityStatus = YHSNetworkReachabilityStatusUnknown;
                        
                        // 发送广播
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter]; // 通知中心
                        [notificationCenter postNotificationName:NOTIFICATION_NETWORKING_STATUS_FREQUENCY  // 广播的频段
                                                          object:self  // 从哪里（对象）发送过来
                                                        userInfo:@{KEY:@(YHSNetworkReachabilityStatusUnknown)}  // 广播内容
                         ];
                        break;
                    }
                    case AFNetworkReachabilityStatusNotReachable: {
                        YHSLogLight(@"不可达的网络(未连接)");
                        _singetonInstance.networkReachabilityStatus = YHSNetworkReachabilityStatusNotReachable;
                        
                        // 发送广播
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter]; // 通知中心
                        [notificationCenter postNotificationName:NOTIFICATION_NETWORKING_STATUS_FREQUENCY  // 广播的频段
                                                          object:self  // 从哪里（对象）发送过来
                                                        userInfo:@{KEY:@(YHSNetworkReachabilityStatusNotReachable)}  // 广播内容
                         ];
                        break;
                    }
                    case AFNetworkReachabilityStatusReachableViaWWAN: {
                        YHSLogLight(@"2G,3G,4G...的网络");
                        _singetonInstance.networkReachabilityStatus = YHSNetworkReachabilityStatusReachableViaWWAN;
                        
                        // 发送广播
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter]; // 通知中心
                        [notificationCenter postNotificationName:NOTIFICATION_NETWORKING_STATUS_FREQUENCY  // 广播的频段
                                                          object:self  // 从哪里（对象）发送过来
                                                        userInfo:@{KEY:@(YHSNetworkReachabilityStatusReachableViaWWAN)}  // 广播内容
                         ];
                        break;
                    }
                    case AFNetworkReachabilityStatusReachableViaWiFi: {
                        YHSLogLight(@"wifi的网络");
                        _singetonInstance.networkReachabilityStatus = YHSNetworkReachabilityStatusReachableViaWiFi;
                        
                        // 发送广播
                        NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter]; // 通知中心
                        [notificationCenter postNotificationName:NOTIFICATION_NETWORKING_STATUS_FREQUENCY  // 广播的频段
                                                          object:self  // 从哪里（对象）发送过来
                                                        userInfo:@{KEY:@(YHSNetworkReachabilityStatusReachableViaWiFi)}  // 广播内容
                         ];
                        break;
                    }
                    default: {
                        break;
                    }
                }
            }];
            [manager startMonitoring]; // 开始监听


            // 3
            
            
        }
    });
    return _singetonInstance;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedYHSNetworkingManagerInstance];
}


- (id)copyWithZone:(struct _NSZone *)zone
{
    return [[self class] sharedYHSNetworkingManagerInstance];
}




@end






