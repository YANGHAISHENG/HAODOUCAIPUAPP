//
//  YHSCookBookDishPictureViewController.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/23.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSBasicWithCollectShareBarItemViewController.h"


typedef NS_ENUM(NSInteger, YHSCookBookDishPictureDetailInfoTableSection) {
    YHSCookBookDishPictureDetailInfoTableSectionCoverPhoto,   // 头部图片
    YHSCookBookDishPictureDetailInfoTableSectionHead,         // 详情头部
    YHSCookBookDishPictureDetailInfoTableSectionFoodMaterial, // 食材详情
    YHSCookBookDishPictureDetailInfoTableSectionStep,         // 制作步骤
    YHSCookBookDishPictureDetailInfoTableSectionTips,         // 注意提示
    YHSCookBookDishPictureDetailInfoTableSectionPhotoShow,    // 作品展示
    YHSCookBookDishPictureDetailInfoTableSectionRelatedTag,   // 相关标签
};


@interface YHSCookBookDishPictureViewController : YHSBasicWithCollectShareBarItemViewController

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *return_request_id;
@property (nonatomic, strong) NSString *rid; // 变动的值 recipeId

@end
