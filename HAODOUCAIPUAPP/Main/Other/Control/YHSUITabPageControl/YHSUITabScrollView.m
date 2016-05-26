
#import "Masonry.h"
#import "YHSUITabScrollView.h"

#define MAP(a, b, c) MIN(MAX(a, b), c)

@interface YHSUITabScrollView ()
- (void)_initTabbatAtIndex:(NSInteger)index;

@property (nonatomic, strong) NSArray *tabViews;
@property (nonatomic, strong) UIView *tabIndicator;
@property (nonatomic, strong) UIView *tabContentView;
@property (nonatomic, assign) CGFloat tabMargin;
@property (nonatomic, assign) CGFloat widthDifference;
@end

@implementation YHSUITabScrollView

#pragma mark - Initialize Methods

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabColor:(UIColor *)color bottomLineHeight:(CGFloat)bottomLineHeight bottomLineColor:(UIColor *)bottomLinecolor backgroundColor:(UIColor *)backgroundColor selectedTabIndex:(NSInteger)index {
    self = [self initWithFrame:frame tabViews:tabViews tabBarHeight:height tabColor:color bottomLineHeight:bottomLineHeight bottomLineColor:bottomLinecolor backgroundColor:backgroundColor];
    if (self) {
        NSInteger tabIndex = 0;
        if (index) {
            tabIndex = index;
        }
        [self _initTabbatAtIndex:index];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame tabViews:(NSArray *)tabViews tabBarHeight:(CGFloat)height tabColor:(UIColor *)color bottomLineHeight:(CGFloat)bottomLineHeight bottomLineColor:(UIColor *)bottomLinecolor backgroundColor:(UIColor *)backgroundColor {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBounces:NO];
        [self setShowsHorizontalScrollIndicator:NO];
        
        // margin
        _tabMargin = 10.0;
        
        // contentSize
        CGFloat width = _tabMargin;
        for (UIView *view in tabViews) {
            width += view.frame.size.width + _tabMargin;
        }
        [self setContentSize:CGSizeMake(MAX(width, self.frame.size.width), height)];
    
        // widthDifference
        _widthDifference = MAX(0, self.frame.size.width * 1.0f - width);
        
        // tabContentView
        UIView *contentView = [UIView new];
        [contentView setBackgroundColor:backgroundColor];
        [contentView setFrame:CGRectMake(0, 0, MAX(width, self.frame.size.width), height)];
        [self addSubview:contentView];
        self.tabContentView = contentView;
        
        // tabView
        UIView *lastView = nil;
        [self setTabViews:tabViews];
        for (int index = 0; index < tabViews.count; index ++) {
            UIView *tabView = tabViews[index];
            [contentView addSubview:tabView];
            
            [tabView setTag:index];
            [tabView setUserInteractionEnabled:YES];
            [tabView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabTapHandler:)]];
            
            CGFloat tabWidth = tabView.frame.size.width;
            [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(contentView.mas_top);
                make.bottom.equalTo(contentView.mas_bottom).offset(-2);
                make.width.mas_equalTo(tabWidth);
                if (!lastView) {
                    make.left.equalTo(contentView.mas_left).offset(_tabMargin + _widthDifference / 2);
                } else {
                    make.left.equalTo(lastView.mas_right).offset(_tabMargin);
                }
            }];
            
            lastView = tabView;
        }

        // 底部横线
        UIView *bottomLine = [[UIView alloc] init];
        [bottomLine setBackgroundColor:bottomLinecolor];
        [contentView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView.mas_left);
            make.right.equalTo(contentView.mas_right);
            make.top.equalTo(contentView.mas_top).offset(height-bottomLineHeight);
            make.bottom.equalTo(contentView.mas_bottom);
        }];
        
        // 指示器
        CGFloat tabIndicatorHeight = 3.0f; // 指示器高度为3
        UIView *tabIndicator = [UIView new];
        [contentView addSubview:tabIndicator];
        [tabIndicator setBackgroundColor:color];
        [tabIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top).offset(height-(bottomLineHeight+tabIndicatorHeight));
            make.bottom.equalTo(contentView.mas_bottom).offset(-bottomLineHeight);
            make.left.equalTo(contentView.mas_left).offset(_tabMargin/2.0);
            make.width.equalTo(@([tabViews[0] frame].size.width + _tabMargin));
        }];
        self.tabIndicator = tabIndicator;
  }
  
  return self;
}

#pragma mark - Public Methods

- (void)animateToTabAtIndex:(NSInteger)index {
    [self animateToTabAtIndex:index animated:YES];
}

- (void)animateToTabAtIndex:(NSInteger)index animated:(BOOL)animated {
    CGFloat animatedDuration = 0.4f;
    if (!animated) {
        animatedDuration = 0.0f;
    }
    
    CGFloat x = [[self tabViews][0] frame].origin.x - _tabMargin / 2.0;
    
    for (int i = 0; i < index; i++) {
        x += [[self tabViews][i] frame].size.width + _tabMargin;
    }
    
    CGFloat w = [[self tabViews][index] frame].size.width + _tabMargin;
    
    [UIView animateWithDuration:animatedDuration animations:^ {
        CGFloat p = x - (self.frame.size.width - w) / 2;
        CGFloat min = 0;
        CGFloat max = MAX(0, self.contentSize.width - self.frame.size.width);
        [self setContentOffset:CGPointMake(MAP(p, min, max), 0)];
    
        [self.tabIndicator mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(w);
            make.left.equalTo(self.tabContentView.mas_left).offset(x);
        }];
        [self layoutIfNeeded];
    }];
}

- (void)tabTapHandler:(UITapGestureRecognizer *)gestureRecognizer {
    if ([[self tabScrollDelegate] respondsToSelector:@selector(tabScrollView:didSelectTabAtIndex:)]) {
        NSInteger index = [[gestureRecognizer view] tag];
        [[self tabScrollDelegate] tabScrollView:self didSelectTabAtIndex:index];
        [self animateToTabAtIndex:index];
    }
}

#pragma mark - Private Methods

- (void)_initTabbatAtIndex:(NSInteger)index {
    
    CGFloat x = [[self tabViews][0] frame].origin.x - _tabMargin / 2.0;
    
    for (int i = 0; i < index; i++) {
        x += [[self tabViews][i] frame].size.width + _tabMargin;
    }
    
    CGFloat w = [[self tabViews][index] frame].size.width + _tabMargin;
    
    CGFloat p = x - (self.frame.size.width - w) / 2;
    CGFloat min = 0;
    CGFloat max = MAX(0, self.contentSize.width - self.frame.size.width);
    
    [self setContentOffset:CGPointMake(MAP(p, min, max), 0)];
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeLeft ||
        orientation == UIDeviceOrientationLandscapeRight) {
        x = x + (w/2);
    }
    
    [self.tabIndicator mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(w);
        make.left.equalTo(self.tabContentView.mas_left).offset(_tabMargin + _widthDifference / 2 + x);
    }];
    [self layoutIfNeeded];
}


@end
