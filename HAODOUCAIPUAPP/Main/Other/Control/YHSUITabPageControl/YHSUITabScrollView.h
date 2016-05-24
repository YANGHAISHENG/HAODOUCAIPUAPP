

#import <UIKit/UIKit.h>

@protocol YHSUITabScrollDelegate;

@interface YHSUITabScrollView : UIScrollView
@property (nonatomic, weak) id<YHSUITabScrollDelegate> tabScrollDelegate;

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor;
- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabColor:(UIColor *)color backgroundColor:(UIColor *)backgroundColor selectedTabIndex:(NSInteger)index;

- (void)animateToTabAtIndex:(NSInteger)index;
- (void)animateToTabAtIndex:(NSInteger)index animated:(BOOL)animated;
@end

@protocol YHSUITabScrollDelegate <NSObject>
- (void)tabScrollView:(YHSUITabScrollView *)tabScrollView didSelectTabAtIndex:(NSInteger)index;
@end
