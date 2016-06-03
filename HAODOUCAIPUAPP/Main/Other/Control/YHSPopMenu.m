
#import "YHSPopMenu.h"

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@end

@implementation UIView (Extension)
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x {
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y {
    return self.frame.origin.y;
}
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGPoint)origin {
    return self.frame.origin;
}

@end


@implementation YHSPopMenu

static UIButton *_cover;
static UIView *_rootContainer;
static void(^_dismiss)(NSInteger selected);
static UIViewController *_contentViewController;
static NSInteger _selected;
static CGFloat _menuItemHeight;

+ (void)popFromView:(UIView *)view contentViewController:(UIViewController *)contentViewController dismiss:(void(^)(NSInteger selected))dismiss {    _contentViewController = contentViewController;
    
    [self popFromView:view content:contentViewController.view dismiss:dismiss];
}

+ (void)popFromView:(UIView *)view content:(UIView *)content dismiss:(void(^)(NSInteger selected))dismiss {
    [self popFromRect:view.bounds inView:view content:content dismiss:dismiss];
}

+ (void)popFromRect:(CGRect)rect inView:(UIView *)view contentViewController:(UIViewController *)contentViewController dismiss:(void(^)(NSInteger selected))dismiss {
    _contentViewController = contentViewController;
    
    [self popFromRect:rect inView:view content:contentViewController.view dismiss:dismiss];
}

+ (void)popFromRect:(CGRect)rect inView:(UIView *)view content:(UIView *)content dismiss:(void(^)(NSInteger selected))dismiss {
    // block的copy作用：将block的内存从桟空间移动到堆空间
    _dismiss = [dismiss copy];
    
    // 返回当前程序的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window setWindowLevel:UIWindowLevelStatusBar];
    
    // 背景关闭事件
    UIButton *cover = [[UIButton alloc] init];
    [cover setFrame:[UIScreen mainScreen].bounds];
    [cover setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchDown];
    [window addSubview:cover];
    _cover = cover;
    
    // 容器
    UIView *rootContainer = [[UIView alloc] init];
    [window addSubview:rootContainer];
    _rootContainer = rootContainer;
    
    // 添加内容到容器中
    content.x = 0;
    content.y = 0;
    [rootContainer addSubview:content];
    
    // 计算容器的尺寸
    rootContainer.width = CGRectGetMaxX(content.frame) + content.x;
    rootContainer.height = CGRectGetMaxY(content.frame) + content.x;
    rootContainer.centerX = CGRectGetMidX(rect);
    rootContainer.y = CGRectGetMaxY(rect);
    
    // 转换位置
    rootContainer.center = [view convertPoint:rootContainer.center toView:window];
}

/**
 *  点击遮盖
 */
+ (void)coverClick {
    [UIView animateWithDuration:0.2 animations:^{
        _cover.alpha = 0.0;
        _rootContainer.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [_rootContainer removeFromSuperview];
        _cover = nil;
        _rootContainer = nil;
        _contentViewController = nil;
        if (_dismiss) {
            _dismiss(_selected); // 调用nil的block,直接报内存错误
            _dismiss = nil;
        }
    }];
}


/**
 *  自定义弹出菜单
 */
+ (void)popFromView:(UIView *)view rect:(CGRect)contentRect itemTitles:(NSArray *)itemTitles selectedIndex:(NSInteger)selectedIndex dismiss:(void(^)(NSInteger selected))dismiss {
    _selected = selectedIndex;
    [self popFromRect:view.bounds inView:view rect:contentRect itemTitles:itemTitles dismiss:dismiss];
}

+ (void)popFromRect:(CGRect)rect inView:(UIView *)view rect:(CGRect)contentRect itemTitles:(NSArray *)itemTitles dismiss:(void(^)(NSInteger selected))dismiss {
    // block的copy作用：将block的内存从桟空间移动到堆空间
    _dismiss = [dismiss copy];
    
    // 返回当前程序的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window setWindowLevel:UIWindowLevelStatusBar];
    
    // 背景关闭事件
    UIButton *cover = [[UIButton alloc] init];
    [cover setFrame:[UIScreen mainScreen].bounds];
    [cover setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchDown];
    [window addSubview:cover];
    _cover = cover;
    
    // 根容器
    UIView *rootContainer = [[UIView alloc] init];
    [window addSubview:rootContainer];
    _rootContainer = rootContainer;
    
    // 添加内容到容器中
    UIView *content = [[UIView alloc] initWithFrame:contentRect];
    content.x = 0;
    content.y = 0;
    [rootContainer addSubview:content];
    [content setBackgroundColor:[UIColor whiteColor]];
    
    // 添加菜单
    _menuItemHeight = contentRect.size.height / itemTitles.count; // 菜单高度
    content.height = itemTitles.count > 10 ? 10*_menuItemHeight : itemTitles.count*_menuItemHeight;
    [self addMenuItemsWithTitles:itemTitles onContent:content];
    
    // 计算容器的尺寸
    rootContainer.width = CGRectGetMaxX(content.frame) + content.x;
    rootContainer.height = CGRectGetMaxY(content.frame) + content.y;
    rootContainer.centerX = CGRectGetMidX(rect);
    rootContainer.y = CGRectGetMaxY(rect);
    
    // 转换位置
    rootContainer.center = [view convertPoint:rootContainer.center toView:window];
}


+ (void)addMenuItemsWithTitles:(NSArray *)itemTitles onContent:(UIView *)content
{
    
    if (!itemTitles || 0 == itemTitles.count) {
        return;
    }
    
    UIScrollView *scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [scrollView setShowsVerticalScrollIndicator:NO];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [content addSubview:scrollView];
        
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(content);
        }];
        scrollView;
    });
    
    UIView *container = ({
        UIView *container = [[UIView alloc] init];
        [scrollView addSubview:container];
        
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollView);
            make.width.equalTo(scrollView);
        }];
        container;
    });
    
    UIView *lastView = nil;
    for (int i = 0; i < itemTitles.count; i ++) {
        
        // 菜单项
        UIView *subView = ({
            UIView *view = [[UIView alloc] init];
            [view setTag:i+1000];
            [container addSubview:view];
            
            // 点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressItemContainerArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [view addGestureRecognizer:tapGesture];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(container);
                make.right.equalTo(container);
                make.height.equalTo(@(_menuItemHeight));
                
                if (lastView) {
                    make.top.equalTo(lastView.mas_bottom);
                } else {
                    make.top.equalTo(container.mas_top);
                }
            }];
            
            view;
        });
        
        lastView = subView;
        
        // 菜单标题
        {
            UILabel *label = [[UILabel alloc] init];
            [label setText:itemTitles[i]];
            [label setFont:[UIFont systemFontOfSize:16.0]];
            [label setTextAlignment:NSTextAlignmentCenter];
            [label setUserInteractionEnabled:YES];
            [label setTextColor: _selected == i ? COLOR_NAVIGATION_BAR_TITLE_YELLOW : COLOR_NAVIGATION_BAR_TITLE];
            [subView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(subView.mas_top).offset(0.0);
                make.left.equalTo(subView.mas_left).offset(0.0);
                make.right.equalTo(subView.mas_right).offset(0.0);
                make.bottom.equalTo(subView.mas_bottom).offset(-1.0);
            }];
        }

        // 分割线
        {
            UIView *separatorLineView =[[UIView alloc] init];
            [separatorLineView setBackgroundColor:[UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.00]];
            [subView addSubview:separatorLineView];
            
            [separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(subView.mas_bottom).offset(-1.0);
                make.left.equalTo(subView.mas_left).offset(0.0);
                make.right.equalTo(subView.mas_right).offset(0.0);
                make.bottom.equalTo(subView.mas_bottom).offset(0.0);
            }];
        }

    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.mas_bottom);
    }];

    
}

// 点击按钮事件
+ (void)pressItemContainerArea:(UITapGestureRecognizer *)gesture
{
    
    UIView *view = (UIView *)[gesture view];
    _selected = view.tag-1000;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        _cover.alpha = 0.0;
        _rootContainer.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [_rootContainer removeFromSuperview];
        _cover = nil;
        _rootContainer = nil;
        _contentViewController = nil;
        if (_dismiss) {
            _dismiss(_selected); // 调用nil的block,直接报内存错误
            _dismiss = nil;
        }
    }];
    
}


@end
