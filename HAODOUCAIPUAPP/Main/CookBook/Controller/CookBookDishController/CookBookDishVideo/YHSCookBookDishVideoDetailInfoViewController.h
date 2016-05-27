

#import <UIKit/UIKit.h>

@class YHSCookBookDishModel;

typedef NS_ENUM(NSInteger, YHSCookBookDishVideoDetailInfoTableSection) {
    YHSCookBookDishVideoDetailInfoTableSectionHead,         // 详情头部
    YHSCookBookDishVideoDetailInfoTableSectionFoodMaterial, // 食材详情
    YHSCookBookDishVideoDetailInfoTableSectionTips,         // 注意提示
    YHSCookBookDishVideoDetailInfoTableSectionPhotoShow,    // 作品展示
    YHSCookBookDishVideoDetailInfoTableSectionLikeUser,     // 点赞列表
    YHSCookBookDishVideoDetailInfoTableSectionPlayTour,     // 打赏列表
    YHSCookBookDishVideoDetailInfoTableSectionRelatedTag,   // 相关标签
};

@interface YHSCookBookDishVideoDetailInfoViewController : UIViewController

@property (nonatomic, strong) YHSCookBookDishModel *infoModel;

@end
