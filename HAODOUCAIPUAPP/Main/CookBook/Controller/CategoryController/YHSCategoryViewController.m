
//
//  YHSCategoryViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/17.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCategoryViewController.h"
#import "YHSCategoryModel.h"

#import "YHSCategorySearchResultViewController.h"
#import "YHSCookBookSearchViewController.h"

static CGFloat CATEGORY_TAB_VIEW_WIDTH = 85.0; // 分类标签视图宽度
#define CATEGORY_TAB_VIEW_HEIGHT SCREEN_HEIGHT-HEIGHT_NAVIGATION_STATUS-HEIGHT_NAVIGATION_BAR

@interface YHSCategoryViewController () <iCarouselDataSource, iCarouselDelegate>

/**
 * 分类数据
 */
@property (nonatomic, strong) NSMutableArray<YHSCategoryModel *> *categoryModels; // 分类数据

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 分类标签组件
 */
@property (nonatomic, assign) CGFloat tagViewHeight;
@property (nonatomic, strong) UIScrollView *categoryTabView;
@property (nonatomic, strong) UIView *categoryTabContainerView;

@property (nonatomic, strong) UIView *tabIndicator;
@property (nonatomic, assign) NSInteger previousSelectedTabIndex; // 前一次选中的Tab的下标值Index
@property (nonatomic, strong) NSMutableArray<UILabel *> *categoryTabLabels;

/**
 * 分类详情组件
 */
@property (nonatomic, strong) iCarousel *categoryDetailView;


@end


@implementation YHSCategoryViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navBarHairlineImageView setHidden:NO];
    
    if (self.categoryModels.count == 0) {
        [self viewDidLoadWithNetworkingStatus];
    }
}

// 监听网络变化后执行
- (void)viewDidLoadWithNetworkingStatus
{
    WEAKSELF(weakSelf);
    
    // 请求网络数据（如果没有请求过数据，则进行数据加载）
    if (!self.categoryModels || self.categoryModels.count == 0) {
        [self loadDataThen:^(BOOL success) {
            // 加载成功
            if (success) {
                
                // 配置UI界面
                [weakSelf createUI];
                
            }
        } andWritingLoading:(self.categoryModels.count == 0 ? YES : NO)];
    }
    
}


#pragma make 创建子控件
- (void) createUI {
    
    if (!self.categoryModels || self.categoryModels.count == 0 || self.rootContainerView) {
        return;
    }
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    
    WEAKSELF(weakSelf);

    // 根容器组件
    UIView *rootContainerView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_NAVIGATION_STATUS + HEIGHT_NAVIGATION_BAR, SCREEN_WIDTH, SCREEN_HEIGHT - HEIGHT_NAVIGATION_STATUS - HEIGHT_NAVIGATION_BAR)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:view];
        
        /* 如果使用Masonry，显示页面时有跳动现象
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.mas_topLayoutGuide).offset(0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(weakSelf.mas_bottomLayoutGuide).offset(0);
        }];
         */
        
        view;
    });
    self.rootContainerView = rootContainerView;
    
    
    // 分类标签组件
    {
        
        // 分类标签调蓄
        _tagViewHeight = 52.0;
        
        // 分类标签根容器
        UIScrollView *categoryTabView = ({
            UIScrollView *scrollView = [[UIScrollView alloc] init];
            [self.rootContainerView addSubview:scrollView];
            [scrollView setBounces:NO];
            [scrollView setShowsVerticalScrollIndicator:NO];
            
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.rootContainerView.mas_top).offset(0);
                make.left.equalTo(weakSelf.rootContainerView.mas_left).offset(0);
                make.width.equalTo(@(CATEGORY_TAB_VIEW_WIDTH));
                make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
            }];
            
            scrollView;
        });
        self.categoryTabView = categoryTabView;

        
        // 分类标签详情主容器
        UIView *container = ({
            UIView *container = [[UIView alloc] init];
            [container setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
            [categoryTabView addSubview:container];
            
            [container mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(categoryTabView);
                make.width.equalTo(categoryTabView);
            }];
            container;
        });
        self.categoryTabContainerView = container;
        
        
        // 标签分类高度之和与ContentSize高度的差异
        CGFloat height = _tagViewHeight * self.categoryModels.count;
        CGFloat heightDifference = MAX(0, CATEGORY_TAB_VIEW_HEIGHT * 1.0f - height);
        
        
        // 指示器
        UIView *tabIndicator = [UIView new];
        [tabIndicator.layer setMasksToBounds:YES];
        [container addSubview:tabIndicator];
        [tabIndicator setBackgroundColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00]];
        [tabIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(container.mas_top).offset(heightDifference/2.0);
            make.left.equalTo(container.mas_left).offset(0.0);
           make.right.equalTo(container);
            make.height.equalTo(@(_tagViewHeight));
        }];
        self.tabIndicator = tabIndicator;
        

        // 创建分类标签
        UILabel *lastCategoryTag = nil;
        _categoryTabLabels = [NSMutableArray arrayWithCapacity:self.categoryModels.count];
        for (int index = 0; index < self.categoryModels.count; index ++) {
            
            YHSCategoryModel *categoryItem = (self.categoryModels)[index];
            
            UILabel *categoryTag = ({
                UILabel *label = [[UILabel alloc] init];
                [container addSubview:label];
                [label setText:categoryItem.Cate];
                [label setTag:(1000 + index)];
                [label setUserInteractionEnabled:YES];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setFont:[UIFont boldSystemFontOfSize:16.0]];
                [label.layer setBorderWidth:0.4];
                [label.layer setBorderColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00].CGColor];
                
                // 点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressCategoryTag:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [label addGestureRecognizer:tapGesture];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(container);
                    make.right.equalTo(container);
                    make.height.mas_equalTo(@(_tagViewHeight));
                    
                    if (lastCategoryTag) {
                        make.top.equalTo(lastCategoryTag.mas_bottom);
                    } else {
                        make.top.equalTo(container.mas_top).offset(heightDifference/2.0);
                    }
                }];
                
                label;
            });
            
            lastCategoryTag = categoryTag;
            [_categoryTabLabels addObject:categoryTag];
        }
        
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastCategoryTag.mas_bottom);
        }];
        
 
        // 默认选中第一个
        [self selectedTabAtIndex:0 previousIndex:0];
    }


    // 分类详情组件
    iCarousel *categoryDetailView = ({
        iCarousel *carousel = [[iCarousel alloc] init];
        [self.rootContainerView addSubview:carousel];
        carousel.delegate = self;
        carousel.dataSource = self;
        carousel.vertical = YES;
        carousel.bounces = YES;
        carousel.decelerationRate = 0.0;
        carousel.scrollEnabled = NO;
        carousel.type = iCarouselTypeLinear;
        [carousel.layer setMasksToBounds:YES];
        carousel.backgroundColor = [UIColor whiteColor];
        
        [carousel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.rootContainerView.mas_top).offset(0);
            make.left.equalTo(weakSelf.categoryTabView.mas_right).offset(0);
            make.right.equalTo(weakSelf.rootContainerView.mas_right).offset(0);
            make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
        }];
        
        carousel;
    });
    self.categoryDetailView = categoryDetailView;
    
}

- (void)loadDataThen:(void (^)(BOOL success))then andWritingLoading:(BOOL)showWritingLoading {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 手写Loading加载动画
    __block UIView *loadingContainerView = nil;
    __block YHSHandWritingLoadingView *writingLoadingVeiw = nil;
    if (showWritingLoading) {
        // 加载动画根容器
        loadingContainerView = [[YHSHandWritingLoadingView alloc] initWithFrame:CGRectMake(0, HEIGHT_NAVIGATION_STATUS, self.view.frame.size.width, self.view.frame.size.height-HEIGHT_NAVIGATION_STATUS-49)];
        [self.view addSubview:loadingContainerView];
        // 手势Loading动画
        writingLoadingVeiw = [[YHSHandWritingLoadingView alloc] initWithView:loadingContainerView];
        loadingContainerView.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:1.00];
        [loadingContainerView addSubview:writingLoadingVeiw];
        // 手写Loading加载动画
        [writingLoadingVeiw show];
    }
    
    // 在默认优先级的 Global Dispatch Queue 中执行块(Block)，并行处理
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 请求数据是否成功
        __block BOOL isSuccess = NO;
        
        // 请求地址与参数
        NSString *url = [YHSCookBookDataUtil getCategoryRequestURLString];
        NSMutableDictionary *params = [YHSCookBookDataUtil getCategoryRequestParams];
        
        // 初始化Manager
        AFHTTPSessionManager *manager = [YHSNetworkingManager sharedYHSNetworkingManagerInstance].manager;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 设置请求的数据格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 设置返回的数据格式
        
        // 请求网络数据前，先取消之前的请求，再发网络请求
        [manager.tasks makeObjectsPerformSelector:@selector(cancel)]; // 取消之前的所有请求
        
        // 请求网络数据
        [manager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            // 拼接data到请求体，这个block的参数是遵守AFMultipartFormData协议的。
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            // 请求成功，解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            NSDictionary *data = dict[@"result"];
            
            // 分类数据
            NSMutableArray<YHSCategoryModel *> *categoryModels = [NSMutableArray array];
            [data[@"list"] enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
                YHSCategoryModel *model = [YHSCategoryModel mj_objectWithKeyValues:dict];
                [categoryModels addObject:model];
            }];
            weakSelf.categoryModels = categoryModels.mutableCopy;
            
            
            // 请求数据成功
            isSuccess = YES;
            YHSLogRed(@"请求数据成功");
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 删除手写Loading加载动画
                if (showWritingLoading) {
#ifdef DEBUG
                    sleep(LOADING_SLEEP_TIME); // 测试用延迟看效果
#endif
                    [writingLoadingVeiw dismiss];
                    [loadingContainerView removeFromSuperview];
                }
                
                // 刷新界面
                !then ?: then(isSuccess);
                
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            YHSLogRed(@"请求数据异常：%@", error);
            
            // 请求数据失败
            isSuccess = NO;
            
            // 在 Main Dispatch Queue 中执行块(Block)，串行处理
            dispatch_async(dispatch_get_main_queue(), ^{
                
                // 删除手写Loading加载动画
                if (showWritingLoading) {
#ifdef DEBUG
                    sleep(LOADING_SLEEP_TIME); // 测试用延迟看效果
#endif
                    [writingLoadingVeiw dismiss];
                    [loadingContainerView removeFromSuperview];
                }
                
                // 刷新界面
                !then ?: then(isSuccess);
                
            });
            
        }];
  
    }); // dispatch_async
    
}


#pragma mark - 触发分类标签事件
- (void)pressCategoryTag:(UITapGestureRecognizer *)gesture
{
    UILabel *label = (UILabel*)gesture.view;
    
    NSUInteger index = label.tag - 1000;
    
    [self.categoryDetailView scrollToItemAtIndex:index animated:NO];
    
    YHSLogRed(@"%@", self.categoryModels[index].Tags[0].Name);
    
    [self selectedTabAtIndex:index previousIndex:_previousSelectedTabIndex];
    
    YHSLogLight(@"%ld %@", index, [label text]);
    
}

- (void)selectedTabAtIndex:(NSInteger)selectedIndex previousIndex:(NSInteger)previousIndex
{
    [self animateToTabAtIndex:selectedIndex];
    
    // 记录当前选中的
    _previousSelectedTabIndex = selectedIndex;
    
    // 上次选中的Tag
    UILabel *previousLabel = self.categoryTabLabels[previousIndex];
    [previousLabel.layer setBorderWidth:0.4];
    [previousLabel setTextColor:[UIColor blackColor]];
    
    // 当前选中的Tag
    UILabel *selectedLabel = self.categoryTabLabels[selectedIndex];
    [selectedLabel.layer setBorderWidth:0.0];
    [selectedLabel setTextColor:[UIColor colorWithRed:1.00 green:0.77 blue:0.18 alpha:1.00]];

}


- (void)animateToTabAtIndex:(NSInteger)index
{
    [self animateToTabAtIndex:index animated:YES];
}

- (void)animateToTabAtIndex:(NSInteger)index animated:(BOOL)animated
{
    CGFloat animatedDuration = 0.01f;
    
    if (!animated) {
        animatedDuration = 0.0f;
    }
    
    CGFloat y = [[self categoryTabLabels][0] frame].origin.y + _tagViewHeight * index;
    
    CGFloat h = [[self categoryTabLabels][index] frame].size.height;
    
    // 指示标签位置
    CGRect frame = self.tabIndicator.frame;
    frame.origin.y = y;
    
    [UIView animateWithDuration:animatedDuration animations:^ {
        
        // 调整指示标签的位置
        self.tabIndicator.frame = frame;
        
        // 调整滚动分类标签UIScrollView的显示内容偏移量
        
        CGFloat p = y - (CATEGORY_TAB_VIEW_HEIGHT*1.0 - h) / 2;
        
        CGFloat min = 0;
        
        CGFloat max = MAX(0, self.categoryTabView.contentSize.height - self.categoryTabView.frame.size.height);
        
        [self.categoryTabView setContentOffset:CGPointMake(0, MAP(p, min, max))];

    }];
    
}



#pragma mark - 触发分类标签详情事件
- (void)pressCategoryMark:(UITapGestureRecognizer *)gesture
{
    UILabel *label = (UILabel*)gesture.view;
    NSInteger tagId = label.tag - 1000;
    NSString *tagName = label.text;
    
    YHSCategorySearchResultViewController *searchResultController = [YHSCategorySearchResultViewController new];
    [searchResultController setTagId:[NSString stringWithFormat:@"%ld", tagId]];
    [searchResultController setTagName:tagName];
    [searchResultController setTitle:tagName];
    [searchResultController setScene:@"t1"];
    [searchResultController setUuid:@"72b9cf70da593de0478cbb90f6025bf7"];
    [self.navigationController pushViewController:searchResultController animated:YES];
}


#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    if ([self.categoryModels count] > 0) {
        return [self.categoryModels count];
    }
    
    return 0;
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)reusingView
{
    // 先删除复用视图上的所有内容，再创建添加新对象
    for (UIView *view in reusingView.subviews) {
        [view removeFromSuperview];
    }
    
    // 根容器
    UIScrollView *scrollRootView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-CATEGORY_TAB_VIEW_WIDTH, SCREEN_HEIGHT-HEIGHT_NAVIGATION_STATUS-HEIGHT_NAVIGATION_BAR)];
    scrollRootView.bounces = YES;
    [self.categoryDetailView addSubview:scrollRootView];
    
    // 复用视图
    reusingView = scrollRootView;
    
    // 主容器
    UIView *mainContainerView = ({
        UIView *container = [[UIView alloc] init];
        [container setBackgroundColor:[UIColor whiteColor]];
        [scrollRootView addSubview:container];
        
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(scrollRootView);
            make.width.equalTo(scrollRootView);
            make.height.greaterThanOrEqualTo(@(SCREEN_HEIGHT)); // 高度大于其父视图UIScrollView的高度，实现弹性效果
        }];
        
        container;
    });
    mainContainerView = mainContainerView;
    
    
    // 分类详情
    CGFloat margin = 20.0;
    __block CGFloat lineMarkWidth = 0.0; // 记录一行标签宽度和
    UILabel *lastCategoryMark = nil;
    YHSCategoryModel *categoryItem = (self.categoryModels)[(NSUInteger)index];
    for (int index = 0; index < categoryItem.Tags.count; index ++) {
        
        UILabel *categoryMark = ({
            UILabel *mark = [[UILabel alloc] init];
            [mark setTag:categoryItem.Tags[index].Id+1000];
            [mark setText:categoryItem.Tags[index].Name];
            [mark.layer setCornerRadius:5.0];
            [mark.layer setMasksToBounds:YES];
            [mark setUserInteractionEnabled:YES];
            [mark setTextAlignment:NSTextAlignmentCenter];
            [mark setFont:[UIFont systemFontOfSize:14.0]];
            [mark setBackgroundColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00]];
            [mainContainerView addSubview:mark];
            
            // 点击手势
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressCategoryMark:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [mark addGestureRecognizer:tapGesture];
            
            // 标签宽度
            CGFloat markWidth = 30.0;
            CGFloat markHeight = 28.0;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]};
            CGSize size = [categoryItem.Tags[index].Name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                   attributes:attributes
                                                                      context:nil].size;
            markWidth += size.width;
            
            // 计算一行标签宽度和
            lineMarkWidth += markWidth + margin;
            
            // 标签位置
            [mark mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(markWidth));
                make.height.equalTo(@(markHeight));
                
                if (lineMarkWidth < SCREEN_WIDTH - CATEGORY_TAB_VIEW_WIDTH - margin) {
                    
                    if (lastCategoryMark) {
                        make.top.equalTo(lastCategoryMark.mas_top).offset(0.0);
                        make.left.equalTo(lastCategoryMark.mas_right).offset(margin);
                    } else {
                        make.top.equalTo(mainContainerView.mas_top).offset(margin);
                        make.left.equalTo(mainContainerView).offset(margin);
                    }
                    
                } else {
                    
                    lineMarkWidth = markWidth + margin; // 重围行标签宽度之和
                    
                    if (lastCategoryMark) {
                        make.top.equalTo(lastCategoryMark.mas_bottom).offset(margin);
                        make.left.equalTo(mainContainerView).offset(margin);
                    } else {
                        make.top.equalTo(mainContainerView.mas_top).offset(margin);
                        make.left.equalTo(mainContainerView).offset(margin);
                    }
                    
                }
                
            }];
            
            mark;
        });
        
        // 记录上一个分类标签
        lastCategoryMark = categoryMark;
    }
    
    // 约束完整性
    [mainContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(lastCategoryMark.mas_bottom).offset(margin);
    }];
    
    return reusingView;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    return 0;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)reusingView
{
    if (reusingView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, SCREEN_HEIGHT)];
        [imageView.layer setMasksToBounds:YES];
        [imageView.layer setCornerRadius:0.0];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        
        reusingView = imageView;
    }
    
    return reusingView;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.categoryDetailView.itemWidth);
}


#pragma mark - iCarouselDelegate
- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            // 是否循环显示
            return NO ;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.categoryDetailView.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    YHSCategoryModel *item = (self.categoryModels)[(NSUInteger)index];
    YHSLogLight(@"Tapped View number: %@", item.Cate);
    
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    YHSLogLight(@"%s, Index: %@", __FUNCTION__, @(self.categoryDetailView.currentItemIndex));
    
    [self selectedTabAtIndex:self.categoryDetailView.currentItemIndex previousIndex:_previousSelectedTabIndex];
}


- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    [self selectedTabAtIndex:self.categoryDetailView.currentItemIndex previousIndex:_previousSelectedTabIndex];
}

- (void)dealloc
{
    _categoryDetailView.delegate = nil;
    _categoryDetailView.dataSource = nil;
}


@end












