//
//  YHSIntroView.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/15.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHSRestrictedScrollView.h"
#import "YHSIntroPage.h"

#define YHS_EMPTY_PROPERTY 9999.f

enum EAIntroViewTags {
    kTitleLabelTag = 1,
    kDescLabelTag,
    kTitleImageViewTag
};

typedef NS_ENUM(NSUInteger, EAViewAlignment) {
    EAViewAlignmentLeft,
    EAViewAlignmentCenter,
    EAViewAlignmentRight,
};

@class YHSIntroView;

@protocol YHSIntroDelegate<NSObject>
@optional
- (void)introDidFinish:(YHSIntroView *)introView;
- (void)intro:(YHSIntroView *)introView pageAppeared:(YHSIntroPage *)page withIndex:(NSUInteger)pageIndex;
- (void)intro:(YHSIntroView *)introView pageStartScrolling:(YHSIntroPage *)page withIndex:(NSUInteger)pageIndex;
- (void)intro:(YHSIntroView *)introView pageEndScrolling:(YHSIntroPage *)page withIndex:(NSUInteger)pageIndex;
@end


@interface YHSIntroView : UIView  <UIScrollViewDelegate>

@property (nonatomic, weak) id<YHSIntroDelegate> delegate;

@property (nonatomic, assign) BOOL swipeToExit;
@property (nonatomic, assign) BOOL tapToNext;
@property (nonatomic, assign) BOOL hideOffscreenPages;
@property (nonatomic, assign) BOOL easeOutCrossDisolves;
@property (nonatomic, assign) BOOL useMotionEffects;
@property (nonatomic, assign) CGFloat motionEffectsRelativeValue;

// Title View (Y position - from top of the screen)
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, assign) CGFloat titleViewY;

// Background image
@property (nonatomic, strong) UIImage *bgImage;
@property (nonatomic, assign) UIViewContentMode bgViewContentMode;

// Page Control (Y position - from bottom of the screen)
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat pageControlY;
@property (nonatomic, assign) NSUInteger currentPageIndex;
@property (nonatomic, assign, readonly) NSUInteger visiblePageIndex;

// Skip button (Y position - from bottom of the screen)
@property (nonatomic, strong) UIButton *skipButton;
@property (nonatomic, assign) CGFloat skipButtonY;
@property (nonatomic, assign) CGFloat skipButtonSideMargin;
@property (nonatomic, assign) EAViewAlignment skipButtonAlignment;
@property (nonatomic, assign) BOOL showSkipButtonOnlyOnLastPage;

@property (nonatomic, strong) YHSRestrictedScrollView *scrollView;
@property (nonatomic, assign) BOOL scrollingEnabled;
@property (nonatomic, strong) NSArray *pages;

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray;

- (void)showFullscreen;
- (void)showFullscreenWithAnimateDuration:(CGFloat)duration;
- (void)showFullscreenWithAnimateDuration:(CGFloat)duration andInitialPageIndex:(NSUInteger)initialPageIndex;
- (void)showInView:(UIView *)view;
- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration;
- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration withInitialPageIndex:(NSUInteger)initialPageIndex;

- (void)hideWithFadeOutDuration:(CGFloat)duration;

- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex;
- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex animated:(BOOL)animated;

- (void)limitScrollingToPage:(NSUInteger)lastPageIndex;

@end
