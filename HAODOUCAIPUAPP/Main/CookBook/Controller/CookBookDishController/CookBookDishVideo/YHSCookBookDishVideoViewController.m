//
//  YHSCookBookDishVedioViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "Masonry.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "AFNetworking.h"

#import "DLScrollTabbarView.h"
#import "DLLRUCache.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Masonry/Masonry.h>
#import "ZFPlayer.h"

#import "YHSCookBookDishVideoViewController.h"
#import "YHSCookBookDishVideoDetailInfoViewController.h"
#import "YHSCookBookDishVideoStepInfoViewController.h"
#import "YHSCookBookDishVideoCommentInfoViewController.h"
#import "YHSHandWritingLoadingView.h"
#import "YHSCookBookDataUtil.h"
#import "YHSSysMacro.h"

#import "YHSCookBookDishModel.h"
#import "YHSCookBookDishVideoPictureView.h"
#import "YHSCookBookVideoModel.h"


@interface YHSCookBookDishVideoViewController () <DLCustomSlideViewDelegate, YHSCookBookDishVideoPictureViewDelegate, YHSCookBookDishVideoStepInfoViewControllerDelegate>

@property (nonatomic, strong) YHSCookBookDishModel *infoModel;

@property (nonatomic, strong) YHSCookBookDishVideoPictureView *videoPictureView; //视屏封面

@property (nonatomic, strong) YHSCookBookDishVideoStepInfoViewController *videoViewSetpController; // 视屏步骤详解

@end


@implementation YHSCookBookDishVideoViewController

#pragma mark -监听网络变化后执行
- (void)viewDidLoadWithNetworkingStatus
{
    WEAKSELF(weakSelf);
    
    // 请求网络数据（如果没有请求过数据，则进行数据加载）
    [self loadDataThen:^(BOOL success, NSUInteger count){
        
        // 配置TableView界面
        [weakSelf createMainUI];
        
    } andWritingLoading:YES];
 
}

// 创建主界面区域
- (void)createMainUI
{
    WEAKSELF(weakSelf);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 视屏或照片区域
    {
        self.videoPictureView = [[YHSCookBookDishVideoPictureView alloc] initWithFrame:CGRectZero andInfoModel:self.infoModel];
        self.videoPictureView.delegate = self;
        [self.view addSubview:self.videoPictureView];
        [self.videoPictureView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(0.0);
            make.left.right.equalTo(weakSelf.view).offset(0.0);
            // 注意此处，宽高比16：9优先级比1000低就行，在因为iPhone 4S宽高比不是16：9
            make.height.equalTo(self.videoPictureView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
        }];
    }
    
    // 滑动视图区域
    {
        CGFloat tabbarItemWidth = SCREEN_WIDTH/3.0;
        CGFloat sliderViewY = HEIGHT_NAVIGATION_STATUS+HEIGHT_NAVIGATION_BAR + HEADER_VIDEO_PICTURE_HEIGHT;
        
        self.slideView = [[DLCustomSlideView alloc] initWithFrame:CGRectMake(0, sliderViewY, SCREEN_WIDTH, SCREEN_HEIGHT-sliderViewY)];
        self.slideView.delegate = self;
        [self.view addSubview:self.slideView];
        
        DLScrollTabbarView *tabbar = [[DLScrollTabbarView alloc] initWithFrame:CGRectMake(0, 0, self.slideView.frame.size.width, HEIGHT_NAVIGATION_BAR)];
        tabbar.backgroundColor = [UIColor whiteColor];
        tabbar.tabItemNormalFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
        tabbar.trackColor = [UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00];
        tabbar.tabItemNormalColor = [UIColor blackColor];
        tabbar.tabItemSelectedColor = [UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00];
        tabbar.tabbarItems = @[ [DLScrollTabbarItem itemWithTitle:@"详情" width:tabbarItemWidth],
                                [DLScrollTabbarItem itemWithTitle:@"步骤" width:tabbarItemWidth],
                                [DLScrollTabbarItem itemWithTitle:@"评论" width:tabbarItemWidth]];
        self.slideView.tabbar = tabbar;
        self.slideView.tabbarBottomSpacing = 0;
        self.slideView.baseViewController = self;
        self.slideView.cache = [[DLLRUCache alloc] initWithCount:3];
        [self.slideView setup];
        
        self.slideView.selectedIndex = 0;
    }
}

// 创建视屏播放控件
- (void)createVideoZFPlayerView:(void(^)(void))then
{
    WEAKSELF(weakSelf);
    
    // 移除封面图片
    [self.videoPictureView removeFromSuperview];
    
    // 创建视屏控件
    self.videoZFPlayerView = [ZFPlayerView sharedPlayerView];
    self.videoZFPlayerView.delegate = self.videoViewSetpController;
    [self.view addSubview:self.videoZFPlayerView];
    [self.videoZFPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(HEIGHT_NAVIGATION_STATUS+HEIGHT_NAVIGATION_BAR);
        make.left.right.equalTo(weakSelf.view).offset(0.0);
        // 注意此处，宽高比16：9优先级比1000低就行，在因为iPhone 4S宽高比不是16：9
        make.height.equalTo(self.videoZFPlayerView.mas_width).multipliedBy(9.0f/16.0f).with.priority(750);
    }];

    // 设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    self.videoZFPlayerView.hasBackBtn = NO;
    self.videoZFPlayerView.hasDownload = NO;
    self.videoZFPlayerView.hasHorizontalLabel = YES;
    self.videoZFPlayerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    self.videoZFPlayerView.loadingBgImage = [UIImage imageNamed:@"loading_bgView.jpg"];
    self.videoZFPlayerView.goBackBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    // 创建完成后，处理
    if (then) {
        then();
    }
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.videoZFPlayerView resetPlayer];
    [self.videoZFPlayerView removeFromSuperview];
    self.videoZFPlayerView = nil;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    WEAKSELF(weakSelf);
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [self.videoZFPlayerView setHasBackBtn:NO];
        [self.navigationController setNavigationBarHidden:NO];
        [self.videoZFPlayerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(HEIGHT_NAVIGATION_BAR+HEIGHT_NAVIGATION_STATUS);
        }];
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        [self.videoZFPlayerView setHasBackBtn:YES];
        [self.navigationController setNavigationBarHidden:YES];
        [self.videoZFPlayerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.view).offset(0);
        }];
    }
}


- (void)dealloc
{
    YHSLogLight(@"%s", __FUNCTION__);
    [self.videoZFPlayerView cancelAutoFadeOutControlBar];
}


#pragma mark - DLTabedSlideViewDelegate

- (NSInteger)numberOfTabsInDLCustomSlideView:(DLCustomSlideView *)sender
{
    return 3;
}

- (UIViewController *)DLCustomSlideView:(DLCustomSlideView *)sender controllerAt:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            YHSCookBookDishVideoDetailInfoViewController *viewController = [[YHSCookBookDishVideoDetailInfoViewController alloc] init];
            viewController.infoModel = self.infoModel;
            return viewController;
        }
        case 1:
        {
            if (!_videoViewSetpController) {
                _videoViewSetpController = [[YHSCookBookDishVideoStepInfoViewController alloc] init];
                _videoViewSetpController.delegate = self;
                _videoViewSetpController.infoModel = self.infoModel;
                _videoViewSetpController.videoZFPlayerView = self.videoZFPlayerView;
                //
                self.videoZFPlayerView.delegate = self.videoViewSetpController;
            }
            return _videoViewSetpController;
        }
        case 2:
        {
            YHSCookBookDishVideoCommentInfoViewController *viewController = [[YHSCookBookDishVideoCommentInfoViewController alloc] init];
            viewController.infoModel = self.infoModel;
            return viewController;
        }
            
        default:
            return nil;
    }
}


#pragma mark - 请求网络数据
- (void)loadDataThen:(void (^)(BOOL success, NSUInteger count))then andWritingLoading:(BOOL)showWritingLoading {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 手写Loading加载动画
    UIView *loadingContainerView = nil;
    __block YHSHandWritingLoadingView *writingLoadingVeiw = nil;
    if (showWritingLoading) {
        // 加载动画根容器
        loadingContainerView = [[YHSHandWritingLoadingView alloc] initWithFrame:CGRectMake(0, HEIGHT_NAVIGATION_STATUS, self.view.frame.size.width, self.view.frame.size.height-HEIGHT_NAVIGATION_STATUS-49)];
        [self.view addSubview:loadingContainerView];
        // 手势Loading动画
        writingLoadingVeiw = [[YHSHandWritingLoadingView alloc] initWithView:loadingContainerView];
        loadingContainerView.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
        [loadingContainerView addSubview:writingLoadingVeiw];
        // 手写Loading加载动画
        [writingLoadingVeiw show];
    }
    
    // 在默认优先级的 Global Dispatch Queue 中执行块(Block)，并行处理
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 请求数据是否成功
        __block BOOL isSuccess = NO;
        __block NSUInteger listCount = 0; // 请求到的数据数量
        
        // 请求地址与参数
        NSString *url = [self getCookBookDishVedioRequestURLString];
        NSMutableDictionary *params = [self getCookBookDishVedioRequestParams];
        
        // 初始化Manager
        AFHTTPSessionManager *manager = [YHSNetworkingManager sharedYHSNetworkingManagerInstance].manager;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 设置请求的数据格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 设置返回的数据格式
        
        // 请求网络数据前，先取消之前的请求，再发网络请求
        [manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
        
        // 请求网络数据
        [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 请求成功，解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSDictionary *data = dict[@"result"];
            NSDictionary *info = data[@"info"];
            
            // 数据转换
            YHSCookBookDishModel *infoModel = [YHSCookBookDishModel mj_objectWithKeyValues:info];
            weakSelf.infoModel = infoModel;
            
            // 请求数据成功
            isSuccess = YES;
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 删除手写Loading加载动画
                if (showWritingLoading) {
#ifdef DEBUG
                    sleep(LOADING_SLEEP_TIME); // 测试用延迟看效果
#endif
                    [writingLoadingVeiw dismiss];
                    [loadingContainerView removeFromSuperview];
                }
                
                // 刷新界面
                !then ?: then(isSuccess, listCount);
                
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            YHSLogRed(@"请求数据异常：%@", error);
            
            // 请求数据失败
            isSuccess = NO;
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 删除手写Loading加载动画
                if (showWritingLoading) {
#ifdef DEBUG
                    sleep(LOADING_SLEEP_TIME); // 测试用延迟看效果
#endif
                    [writingLoadingVeiw dismiss];
                    [loadingContainerView removeFromSuperview];
                }
                
                // 刷新界面
                !then ?: then(isSuccess, listCount);
                
            });
            
        }];
        
    }); // dispatch_async
    
}

- (NSString *)getCookBookDishVedioRequestURLString
{
    // 默认主页面内容，子类必须继承
    return [YHSCookBookDataUtil getCookBookDishVideoRequestURLString];
}

- (NSMutableDictionary *)getCookBookDishVedioRequestParams
{
    // 默认主页面内容，子类必须继承
    NSMutableDictionary *params = [YHSCookBookDataUtil getCookBookDishVideoRequestParams];
    [params setObject:self.return_request_id forKey:@"return_request_id"];
    [params setObject:self.rid forKey:@"rid"];  // 必须有
    return params;
}

#pragma mark - 触发操作事件

- (void)didClickDishVideoStartWithInfoModel:(YHSCookBookDishModel *)model
{
    // 创建视屏播放控件
    [self createVideoZFPlayerView:^{
        
        // 如果步骤页面已经创建，则直接请求视屏资源
        if (_videoViewSetpController) {
            _videoViewSetpController.videoZFPlayerView = self.videoZFPlayerView;
            self.videoZFPlayerView.videoURL = [NSURL URLWithString:_videoViewSetpController.videoStepModel.Url];
        }
        
        // 选中步骤页面
        [self.slideView setSelectedIndex:1];

    }];
    
}

- (void)didClickDishLikeCountWithInfoModel:(YHSCookBookDishModel *)model
{
    [self alertPromptMessage:@""];
}


#pragma mark - 如果视屏播放控件不存在，则创建后跳转到指定XX秒
- (void)didClickElementOfCellWithDishVideofModel:(YHSCookBookVideoStepModel *)model
{
    // 创建头部视屏控件
    [self didClickDishVideoStartWithInfoModel:self.infoModel];
    
    // 跳转到指定XX秒
    NSInteger seekTime = model.Point/1000.0;
    [_videoZFPlayerView setSeekTime:seekTime];
    [_videoZFPlayerView setHasRepeatBtn:NO];
}

@end




