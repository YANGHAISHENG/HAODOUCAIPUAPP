/**
 *  弹窗菜单工具
 */
#import <UIKit/UIKit.h>

@interface YHSPopMenu : NSObject
/**
 *  弹出一个菜单
 *
 *  @param view    菜单的箭头指向谁
 *  @param content 菜单里面的内容
 *  @param dismiss 菜单销毁的时候想做的事情
 */
+ (void)popFromView:(UIView *)view
            content:(UIView *)content
            dismiss:(void(^)(NSInteger selected))dismiss;

/**
 *  弹出一个菜单
 *
 *  @param view    参照系
 *  @param rect    菜单的箭头指向的矩形框
 *  @param content 菜单里面的内容
 *  @param dismiss 菜单销毁的时候想做的事情
 */
+ (void)popFromRect:(CGRect)rect
             inView:(UIView *)view
            content:(UIView *)content
            dismiss:(void(^)(NSInteger selected))dismiss;


/**
 *  弹出一个菜单
 *
 *  @param view    菜单的箭头指向谁
 *  @param contentViewController 菜单里面的内容
 *  @param dismiss 菜单销毁的时候想做的事情
 */
+ (void)popFromView:(UIView *)view contentViewController:(UIViewController *)contentViewController
            dismiss:(void(^)(NSInteger selected))dismiss;

/**
 *  弹出一个菜单
 *
 *  @param rect    菜单的箭头指向的矩形框
 *  @param view    参照系
 *  @param contentViewController 菜单里面的内容
 *  @param dismiss 菜单销毁的时候想做的事情
 */
+ (void)popFromRect:(CGRect)rect
             inView:(UIView *)view contentViewController:(UIViewController *)contentViewController
            dismiss:(void(^)(NSInteger selected))dismiss;

/**
 *  点击遮盖移除菜单
 */
+ (void)coverClick;




+ (void)popFromView:(UIView *)view rect:(CGRect)contentRect itemTitles:(NSArray *)itemTitles selectedIndex:(NSInteger)selectedIndex dismiss:(void(^)(NSInteger selected))dismiss;

+ (void)popFromRect:(CGRect)rect inView:(UIView *)view rect:(CGRect)contentRect itemTitles:(NSArray *)itemTitles dismiss:(void(^)(NSInteger selected))dismiss;



@end
