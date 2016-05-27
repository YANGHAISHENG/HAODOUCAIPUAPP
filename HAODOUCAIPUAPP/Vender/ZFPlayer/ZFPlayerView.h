

#import <UIKit/UIKit.h>
// 返回按钮的block
typedef void(^ZFPlayerGoBackBlock)(void);
// playerLayer的填充模式（默认：等比例填充，直到一个维度到达区域边界）
typedef NS_ENUM(NSInteger, ZFPlayerLayerGravity) {
     ZFPlayerLayerGravityResize,           // 非均匀模式。两个维度完全填充至整个视图区域
     ZFPlayerLayerGravityResizeAspect,     // 等比例填充，直到一个维度到达区域边界
     ZFPlayerLayerGravityResizeAspectFill  // 等比例填充，直到填充满整个视图区域，其中一个维度的部分区域会被裁剪
};


@protocol ZFPlayerViewDelegate <NSObject>
@optional
/** 监听播放进度
 * float value 进度条的值
 * NSInteger currMin 当前播放时间：分
 * NSInteger currSec 当前播放时间：秒
 * NSInteger durMin 总的播放时间：分
 * NSInteger durSec 总的播放时间：秒
 **/
- (void)videoSliderValueChange:(float)value currMin:(NSInteger)currMin currSec:(NSInteger)currSec durMin:(NSInteger)durMin durSec:(NSInteger)durSec;

/**
 * 重播按钮
 */
- (void)repeatPlayAction;

@end


@interface ZFPlayerView : UIView

/** 视频URL */
@property (nonatomic, strong) NSURL                *videoURL;
/** 视频URL的数组 */
@property (nonatomic, strong) NSArray              *videoURLArray;
/** 返回按钮Block */
@property (nonatomic, copy  ) ZFPlayerGoBackBlock  goBackBlock;
/** 设置playerLayer的填充模式 */
@property (nonatomic, assign) ZFPlayerLayerGravity playerLayerGravity;
/** 是否有下载功能(默认是关闭) */
@property (nonatomic, assign) BOOL                 hasDownload;
/** 是否有返回按钮(默认是显示) */
@property (nonatomic, assign) BOOL                 hasBackBtn;
/** 是否有重播按钮(默认是显示) */
@property (nonatomic, assign) BOOL                 hasRepeatBtn;
/** 是否有有进度提示信息(默认是显示) */
@property (nonatomic, assign) BOOL                 hasHorizontalLabel;
/** 切换分辨率传的字典(key:分辨率名称，value：分辨率url) */
@property (nonatomic, strong) NSDictionary         *resolutionDic;
/** 播放开始之前（加载中）设置占位图 **/
@property (nonatomic, strong) UIImage              *loadingBgImage;
/** 从xx秒开始播放视频跳转 */
@property (nonatomic, assign) NSInteger            seekTime;
/** 代理 **/
@property (nonatomic, strong) id<ZFPlayerViewDelegate> delegate;


/**
 *  取消延时隐藏controlView的方法,在ViewController的delloc方法中调用
 *  用于解决：刚打开视频播放器，就关闭该页面，maskView的延时隐藏还未执行。
 */
- (void)cancelAutoFadeOutControlBar;

/**
 *  单例，用于列表cell上多个视频
 *
 *  @return ZFPlayer
 */
+ (instancetype)sharedPlayerView;

/**
 *  player添加到cell上
 *
 *  @param cell 添加player的cellImageView
 */
- (void)addPlayerToCellImageView:(UIImageView *)imageView;

/**
 *  重置player
 */
- (void)resetPlayer;

/**
 *  在当前页面，设置新的Player的URL调用此方法
 */
- (void)resetToPlayNewURL;

/** 
 *  播放
 */
- (void)play;

/** 
  * 暂停 
 */
- (void)pause;

/**
 *  用于cell上播放player
 *
 *  @param videoURL  视频的URL
 *  @param tableView tableView
 *  @param indexPath indexPath 
 *  @param ImageViewTag ImageViewTag
 */
- (void)setVideoURL:(NSURL *)videoURL
      withTableView:(UITableView *)tableView
        AtIndexPath:(NSIndexPath *)indexPath
   withImageViewTag:(NSInteger)tag;

/**
 *  从xx秒开始播放视频跳转
 *
 *  @param dragedSeconds 视频跳转的秒数
 */
- (void)seekToTime:(NSInteger)dragedSeconds completionHandler:(void (^)(BOOL finished))completionHandler;

@end
