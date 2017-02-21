//
//  YHSCookBookDishVedioViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithCollectShareBarItemViewController.h"
#import "DLCustomSlideView.h"

@class ZFPlayerView;

@interface YHSCookBookDishVideoViewController : YHSBasicWithCollectShareBarItemViewController

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *return_request_id;
@property (nonatomic, strong) NSString *rid; // 变动的值 recipeId


@property (strong, nonatomic) DLCustomSlideView *slideView; // 下方的滑动控件
@property (nonatomic, strong) ZFPlayerView *videoZFPlayerView; // 视屏播放控件

@end
