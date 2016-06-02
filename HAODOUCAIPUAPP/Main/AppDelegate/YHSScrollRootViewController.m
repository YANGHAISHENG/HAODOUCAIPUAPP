//
//  YHSScrollRootViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/1.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSScrollRootViewController.h"
#import "YHSBasicNavigationController.h"
#import "YHSCookBookMainViewController.h"
#import "YHSBackHomeMainViewController.h"
#import "YHSSquareMainViewController.h"
#import "YHSMineMainViewController.h"

#import "ZFPlayer.h"
#import "YHSCookBookDishVideoViewController.h"

@interface YHSScrollRootViewController ()

@end

@implementation YHSScrollRootViewController

#pragma mark 添加子控制器
- (void)addChildControllers
{
    // 菜谱
    [self addChildNavigationController:[YHSBasicNavigationController class]
                    rootViewController:[YHSCookBookMainViewController class]
                                 title:@"菜谱"
                       tabBarImageName:@"collect_normal"
                 tabBarSelectImageName:@"collect_pressed"];
    
    // 到家
    [self addChildNavigationController:[YHSBasicNavigationController class]
                    rootViewController:[YHSBackHomeMainViewController class]
                                 title:@"到家"
                       tabBarImageName:@"find_normal"
                 tabBarSelectImageName:@"find_pressed"];
    
    // 广场
    [self addChildNavigationController:[YHSBasicNavigationController class]
                    rootViewController:[YHSSquareMainViewController class]
                                 title:@"广场"
                       tabBarImageName:@"group_normal"
                 tabBarSelectImageName:@"group_pressed"];
    
    // 我的
    [self addChildNavigationController:[YHSBasicNavigationController class]
                    rootViewController:[YHSSquareMainViewController class]
                                 title:@"我的"
                       tabBarImageName:@"mine_normal"
                 tabBarSelectImageName:@"mine_pressed"];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 哪些页面支持自动转屏
- (BOOL)shouldAutorotate
{
    if (self.viewControllers.count > self.selectedIndex) {
        
        UINavigationController *nav = self.viewControllers[self.selectedIndex];
        
        // YHSCookBookDishVideoViewController 控制器支持自动转屏
        if ([nav.topViewController isKindOfClass:[YHSCookBookDishVideoViewController class]]) {
            // 调用ZFPlayerSingleton单例记录播放状态是否锁定屏幕方向
            return !ZFPlayerShared.isLockScreen;
        }
        
    }
    
    return NO;
}

// ViewController支持哪些转屏方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if (self.viewControllers.count > self.selectedIndex) {
        
        UINavigationController *nav = self.viewControllers[self.selectedIndex];
        if ([nav.topViewController isKindOfClass:[YHSCookBookDishVideoViewController class]]) {
            // YHSCookBookDishVideoViewController 这个页面支持转屏方向
            if (ZFPlayerShared.isAllowLandscape) {
                return UIInterfaceOrientationMaskAllButUpsideDown;
            } else {
                return UIInterfaceOrientationMaskPortrait;
            }
        } else if ([nav.topViewController isKindOfClass:[YHSCookBookDishVideoViewController class]]) {
            // YHSCookBookDishVideoViewController这个页面支持转屏方向
            return UIInterfaceOrientationMaskAllButUpsideDown;
        }
        
    }
    
    // 其他页面
    return UIInterfaceOrientationMaskPortrait;
}



@end
