//
//  YHSScrollAnimationTitleBar.h
//  YHSDEVKIT
//
//  Created by YANGHAISHENG on 16/4/26.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YHSScrollAnimationTitleBar;

@protocol YHSScrollAnimationTitleBarDelegate <NSObject>
@required
- (void)scrollTitleBar:(YHSScrollAnimationTitleBar *)scrollTitleBar scrollToIndex:(NSInteger)tagIndex title:(NSString *)title;
@end


@interface YHSScrollAnimationTitleBar : UIView
@property (nonatomic, strong) NSArray *itemTitles;                      // 标题数组
@property (nonatomic, strong) NSArray *itemImagesNormal;                // 正常图片数组
@property (nonatomic, strong) NSArray *itemImagesSelected;              // 选中图片数组
@property (nonatomic, strong) UIFont  *itemTitlesFont;                  // 标题的字号
@property (nonatomic, strong) UIColor *itemTitlesCustomeColor;          // 标题的常规颜色
@property (nonatomic, strong) UIColor *itemTitlesHeightLightColor;      // 标题高亮颜色
@property (nonatomic, strong) UIColor *backgroundHeightLightColor;  // 高亮时的颜色
@property (nonatomic, assign) CGFloat duration;                     // 运动时间
@property (nonatomic, weak) id<YHSScrollAnimationTitleBarDelegate> delegate;
- (void)wanerSelected:(NSInteger)tagIndex;
@end