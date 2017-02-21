//
//  YHSCookBookDishVideoPictureView.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/25.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSCookBookDishModel;

@protocol YHSCookBookDishVideoPictureViewDelegate <NSObject>
@optional
- (void)didClickDishVideoStartWithInfoModel:(YHSCookBookDishModel *)model;
- (void)didClickDishLikeCountWithInfoModel:(YHSCookBookDishModel *)model;
@end


@interface YHSCookBookDishVideoPictureView : UIView

@property (nonatomic, strong) YHSCookBookDishModel *infoModel;

- (instancetype)initWithFrame:(CGRect)frame andInfoModel:(YHSCookBookDishModel *)infoModel;

@property (nonatomic, strong) id<YHSCookBookDishVideoPictureViewDelegate> delegate;

@end
