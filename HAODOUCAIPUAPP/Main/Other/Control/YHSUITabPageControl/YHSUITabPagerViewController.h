

#import "YHSBasicViewController.h"

@protocol YHSUITabPagerDataSource;
@protocol YHSUITabPagerDelegate;

@interface YHSUITabPagerViewController : YHSBasicViewController
@property (weak, nonatomic) id<YHSUITabPagerDelegate> delegate;
@property (weak, nonatomic) id<YHSUITabPagerDataSource> dataSource;

- (void)reloadData;
- (NSInteger)selectedIndex;

- (void)selectTabbarIndex:(NSInteger)index;
- (void)selectTabbarIndex:(NSInteger)index animation:(BOOL)animation;
@end

@protocol YHSUITabPagerDataSource <NSObject>
@required
- (NSInteger)numberOfViewControllers;
- (UIViewController *)viewControllerForIndex:(NSInteger)index;

@optional
- (UIView *)viewForTabAtIndex:(NSInteger)index;
- (NSString *)titleForTabAtIndex:(NSInteger)index;
- (CGFloat)tabHeight;
- (UIColor *)tabColor;
- (UIColor *)tabBackgroundColor;
- (UIFont *)titleFont;
- (UIColor *)titleColor;
@end

@protocol YHSUITabPagerDelegate <NSObject>
@optional
- (void)tabPager:(YHSUITabPagerViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index;
- (void)tabPager:(YHSUITabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index;
@end