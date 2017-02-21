

#import <UIKit/UIKit.h>

@class YHSCookBookDishModel, YHSCookBookVideoModel, YHSCookBookVideoStepModel, ZFPlayerView;

@protocol YHSCookBookDishVideoStepInfoViewControllerDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithDishVideofModel:(YHSCookBookVideoStepModel *)model;
@end


@interface YHSCookBookDishVideoStepInfoViewController : UIViewController <ZFPlayerViewDelegate>

@property (nonatomic, weak) ZFPlayerView *videoZFPlayerView; // 视屏播放控件

@property (nonatomic, strong) YHSCookBookDishModel *infoModel;

@property (nonatomic, strong) YHSCookBookVideoModel *videoStepModel;

@property (nonatomic, strong) id<YHSCookBookDishVideoStepInfoViewControllerDelegate> delegate;

@end
