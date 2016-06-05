//
//  YHSButtonWithIcon.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/5.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHSButtonWithIcon : UIButton {
    UIColor *down_normal_color;
    UIColor *down_highlight_color;
    
    NSString *image_normal;
    NSString *image_highlight;
    
    UIColor *icon_bg_normal_color;
    UIColor *icon_bg_highlight_color;
    
    UIColor *icon_label_normal_color;
    UIColor *icon_label_highlight_color;
}
@property (nonatomic, strong) UILabel *downlabel;
@property (nonatomic, strong) UIImageView *baseimage;
@property (nonatomic, strong) UILabel *iconlabel;

//haveLabel==NO,则只有图片和角标，无文字
//如果haveLabel==YES,则图片一定是正方形
- (id)initWithFrame:(CGRect)frame haveLabel:(BOOL)haveLabel;//默认isCircularBtn==YES，YES时角标会全部在图片范围内，NO时角标会有1/4在图片范围内
- (id)initWithFrame:(CGRect)frame haveLabel:(BOOL)haveLabel mode:(BOOL)isCircularBtn;
//以下方法一定有文字
//一定会有label的情况下，可以定义image的大小
- (id)initWithFrame:(CGRect)frame imageSize:(CGSize)size;//默认isCircularBtn==YES
- (id)initWithFrame:(CGRect)frame imageSize:(CGSize)size mode:(BOOL)isCircularBtn;

- (void)showIconLabelWithoutText;//显示一个点角标
- (void)setIconLabelText:(NSString*)str;//显示有文字的角标

- (void)setBaseImage:(NSString*)image highlightImage:(NSString*)highlightImage;//设置图片,highlight可为空，为空无点击效果
- (void)setDownLabelColor:(UIColor*)color highlightColor:(UIColor*)highlightColor;//设置文字颜色,highlight可为空，为空无点击效果
- (void)setIconBgColor:(UIColor*)color highlightColor:(UIColor*)highlightColor;//设置角标背景颜色,highlight可为空，为空无点击效果
- (void)setIconLabelColor:(UIColor*)color highlightColor:(UIColor*)highlightColor;//设置角标文字颜色,highlight可为空，为空无点击效果

@end

