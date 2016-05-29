

#import <UIKit/UIKit.h>

@class YHSCookBookDishModel;

typedef NS_ENUM(NSInteger, YHSCookBookDishVideoDetailInfoTableSection) {
    YHSCookBookDishVideoDetailInfoTableSectionHead,         // 详情头部
    YHSCookBookDishVideoDetailInfoTableSectionFoodMaterial, // 食材详情
    YHSCookBookDishVideoDetailInfoTableSectionTips,         // 注意提示
    YHSCookBookDishVideoDetailInfoTableSectionPhotoShow,    // 作品展示
    YHSCookBookDishVideoDetailInfoTableSectionRelatedTag,   // 相关标签
};

@interface YHSCookBookDishVideoDetailInfoViewController : UIViewController

@property (nonatomic, strong) YHSCookBookDishModel *infoModel;

@end
