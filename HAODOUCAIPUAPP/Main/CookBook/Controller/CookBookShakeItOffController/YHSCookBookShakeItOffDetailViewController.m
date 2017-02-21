//
//  YHSCookBookShakeItOffDetailViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookShakeItOffDetailViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation YHSCookBookShakeItOffDetailViewController

// 监听网络变化后执行
- (void)viewDidLoadWithNetworkingStatus
{
    WEAKSELF(weakSelf);
    
    // 请求网络数据（如果没有请求过数据，则进行数据加载）
    [self loadDataThen:^(BOOL success, NSUInteger count){
        
        // 配置TableView界面
        [weakSelf createUITable];

        // 加载成功
        if (success && count) {
            
            // 刷新表格
            [weakSelf.tableView reloadData];
            
            // 增加偏移量
            self.offset += self.limit;
            YHSLogBlue(@"加载后偏移量 ：%ld", self.offset);
        }
        
    } andWritingLoading:(self.tableData.count == 0 ? YES : NO)];
    
}

// 摇一摇开始摇动
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    YHSLogOrange(@"开始摇动");
    
    // 加载数据
    [self loadData];
    
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    return;
}




@end
