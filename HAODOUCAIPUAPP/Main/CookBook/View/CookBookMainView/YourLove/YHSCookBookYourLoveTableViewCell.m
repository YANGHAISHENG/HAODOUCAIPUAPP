//
//  YHSCookBookYourLoveTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/12.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookYourLoveTableViewCell.h"
#import "YHSCookBookYourLoveModel.h"


NSString * const CELL_IDENTIFIER_YOUR_LOVE = @"YHSCookBookYourLoveTableViewCellID";

static CGFloat YOUR_LOVE_CAROUSEL_VIEW_HEIGHT = 160; // 动画视图高度
static CGFloat YOUR_LOVE_CAROUSEL_VIEW_MARGIN = 0; // 左右两边的距离
static CGFloat YOUR_LOVE_SCROLL_TABBAR_VIEW_HEIGHT = 30; // Tab标签栏

@interface YHSCookBookYourLoveTableViewCell () <iCarouselDataSource, iCarouselDelegate>

/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 炫酷动画组件
 */
@property (nonatomic, strong) iCarousel *carouselContainerView;

/**
 * Tab标签栏
 */
@property (nonatomic, assign) CGFloat tabMargin;
@property (nonatomic, strong) UIView *tabIndicator;
@property (nonatomic, strong) UIScrollView *scrollTabView;
@property (nonatomic, strong) UIView *scrollTabContentView;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *tabWidthArray;
@property (nonatomic, strong) NSMutableArray<UILabel *> *tabLabels;
@end


@implementation YHSCookBookYourLoveTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
        [self setViewAtuoLayout];
    }
    return self;
}

#pragma make 创建子控件
- (void) createView {
    
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    // 根容器组件
    self.rootContainerView = [[UIView alloc] init];
    [self.contentView addSubview:self.rootContainerView];
    
    // 公共容器组件
    self.publicContainerView =[[UIView alloc] init];
    [self.publicContainerView setTag:1000];
    [self.publicContainerView.layer setMasksToBounds:YES];
    [self.rootContainerView addSubview:self.publicContainerView];
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10.0;
    
    // 根容器组件
    [self.rootContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).with.offset(0);
    }];
    
    // 公共容器组件
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(weakSelf.rootContainerView.mas_left).offset(margin);
        make.right.equalTo(weakSelf.rootContainerView.mas_right).offset(-margin);
        make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(-margin);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookYourLoveModel *)model
{
    _model = model;

    WEAKSELF(weakSelf);
    
    // Cell复用机制会出现阴影
    for(UIView *view in self.publicContainerView.subviews) {
       [view removeFromSuperview];
    }

    // 炫酷动画组件
    {
        iCarousel *carouselContainerView = ({
            iCarousel *carousel = [[iCarousel alloc] init];
            [self.publicContainerView addSubview:carousel];
            carousel.delegate = self;
            carousel.dataSource = self;
            carousel.type = iCarouselTypeCoverFlow;
            carousel.decelerationRate = 0.0;
            carousel.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.30];
            
            [carousel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.publicContainerView.mas_top);
                make.left.equalTo(weakSelf.publicContainerView.mas_left);
                make.right.equalTo(weakSelf.publicContainerView.mas_right);
                make.height.equalTo(@(YOUR_LOVE_CAROUSEL_VIEW_HEIGHT));
            }];
            
            carousel;
        });
        self.carouselContainerView = carouselContainerView;
        
        // 公共容器组件
        [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(carouselContainerView.mas_bottom);
        }];
    }


    // 标签指示器
    {
        UIScrollView *scrollTabView = ({
            UIScrollView *scrollView = [[UIScrollView alloc] init];
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.bounces = NO;
            [self.publicContainerView addSubview:scrollView];
            
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.carouselContainerView.mas_bottom).offset(-YOUR_LOVE_SCROLL_TABBAR_VIEW_HEIGHT);
                make.left.equalTo(weakSelf.publicContainerView.mas_left);
                make.right.equalTo(weakSelf.publicContainerView.mas_right);
                make.height.equalTo(@(YOUR_LOVE_SCROLL_TABBAR_VIEW_HEIGHT));
            }];
            
            scrollView;
        });
        self.scrollTabView = scrollTabView;

        _tabMargin = 10;

        // contentSize
        _tabWidthArray = [[NSMutableArray alloc] initWithCapacity:model.tag.count];
        CGFloat width_min = 50; // 每个标签最小宽度
        CGFloat width = _tabMargin;
        for (int index = 0; index < model.tag.count; index ++) {
            
            YHSCookBookYourLoveElemModel *elem = model.tag[index];
            
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGSize size = [elem.CateName boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   attributes:attributes
                                                      context:nil].size;
            CGFloat temp = size.width + width_min;
            [_tabWidthArray addObject:[NSNumber numberWithFloat:temp]];
            
            width += temp + _tabMargin;
        }
        [self.scrollTabView setContentSize:CGSizeMake(MAX(width, self.publicContainerView.frame.size.width), YOUR_LOVE_SCROLL_TABBAR_VIEW_HEIGHT)];
        
        
        // widthDifference
        CGFloat widthDifference = MAX(0, self.publicContainerView.frame.size.width * 1.0f - width);
        
        
        // tabContentView
        UIView *contentView = [UIView new];
        [contentView setBackgroundColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.40]];
        [contentView setFrame:CGRectMake(0, 0, MAX(width, self.publicContainerView.frame.size.width), YOUR_LOVE_SCROLL_TABBAR_VIEW_HEIGHT)];
        [self.scrollTabView addSubview:contentView];
        self.scrollTabContentView = contentView;

        
        // 指示器
        UIView *tabIndicator = [UIView new];
        [tabIndicator.layer setMasksToBounds:YES];
        [tabIndicator.layer setCornerRadius:_tabMargin];
        [contentView addSubview:tabIndicator];
        [tabIndicator setBackgroundColor:[UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.70]];
        [tabIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(contentView.mas_top).offset(_tabMargin/2.0);
            make.bottom.equalTo(contentView.mas_bottom).offset(-_tabMargin/2.0);
            make.left.equalTo(contentView.mas_left).offset(_tabMargin/2.0);
            make.width.equalTo(@(_tabWidthArray[0].floatValue + _tabMargin));
        }];
        self.tabIndicator = tabIndicator;
        
        
        // tabLabels
        UIView *lastLabel = nil;
        _tabLabels = [[NSMutableArray alloc] initWithCapacity:model.tag.count];
        for (int index = 0; index < model.tag.count; index ++) {
            
            YHSCookBookYourLoveElemModel *elem = model.tag[index];
            
            UILabel *label = [UILabel new];
            label.text = elem.CateName;
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            [label.layer setMasksToBounds:YES];
            [label.layer setCornerRadius:_tabMargin];
            label.backgroundColor = [UIColor colorWithRed:1.00 green:1.00 blue:1.00 alpha:0.0];
            [contentView addSubview:label];
            
            [label setTag:index];
            [label setUserInteractionEnabled:YES];
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabTapHandler:)]];
            
            CGFloat tabWidth = _tabWidthArray[index].floatValue;
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(contentView.mas_top).offset(_tabMargin/2.0);
                make.bottom.equalTo(contentView.mas_bottom).offset(-_tabMargin/2.0);
                make.width.mas_equalTo(tabWidth);
                if (!lastLabel) {
                    make.left.equalTo(contentView.mas_left).offset(_tabMargin + widthDifference / 2);
                } else {
                    make.left.equalTo(lastLabel.mas_right).offset(_tabMargin);
                }
            }];
            
            lastLabel = label;
            [_tabLabels addObject:label];
        }
        
    }
 
}


#pragma mark - 触发操作事件
- (void)tabTapHandler:(UITapGestureRecognizer *)gestureRecognizer {
    NSInteger index = [[gestureRecognizer view] tag];
    
    [self.carouselContainerView scrollToItemAtIndex:index animated:YES];
    
    [self animateToTabAtIndex:index];
}

- (void)animateToTabAtIndex:(NSInteger)index {
    [self animateToTabAtIndex:index animated:YES];
}

- (void)animateToTabAtIndex:(NSInteger)index animated:(BOOL)animated {
    CGFloat animatedDuration = 0.4f;
    if (!animated) {
        animatedDuration = 0.0f;
    }
    
    CGFloat x = [[self tabLabels][0] frame].origin.x - _tabMargin / 2.0;
    
    for (int i = 0; i < index; i++) {
        x += [[self tabLabels][i] frame].size.width + _tabMargin;
    }
    
    CGFloat w = [[self tabLabels][index] frame].size.width + _tabMargin;
    
    [UIView animateWithDuration:animatedDuration animations:^ {
        CGFloat p = x - (self.frame.size.width - w) / 2;
        CGFloat min = 0;
        CGFloat max = MAX(0, self.scrollTabView.contentSize.width - self.scrollTabView.frame.size.width);
        [self.scrollTabView setContentOffset:CGPointMake(MAP(p, min, max), 0)];
        
        [self.tabIndicator mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(w);
            make.left.equalTo(self.scrollTabContentView.mas_left).offset(x);
        }];
        [self layoutIfNeeded];
    }];
}



#pragma mark - iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    if ([self.model.tag count] > 0) {
        return [self.model.tag count];
    }
    
    return 0;
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)reusingView
{
    YHSCookBookYourLoveElemModel *item = (self.model.tag)[(NSUInteger)index];

    if (reusingView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-YOUR_LOVE_CAROUSEL_VIEW_MARGIN, YOUR_LOVE_CAROUSEL_VIEW_HEIGHT)];
        [imageView.layer setMasksToBounds:YES];
        [imageView.layer setCornerRadius:0.0];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];

        reusingView = imageView;
    }
    
    [((UIImageView *)reusingView) sd_setImageWithURL:[NSURL URLWithString:item.Cover] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
 
    return reusingView;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    return 0;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)reusingView
{
    if (reusingView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-YOUR_LOVE_CAROUSEL_VIEW_MARGIN, YOUR_LOVE_CAROUSEL_VIEW_HEIGHT)];
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
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carouselContainerView.itemWidth);
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
            if (self.carouselContainerView.type == iCarouselTypeCustom)
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
    YHSCookBookYourLoveElemModel *model = (self.model.tag)[(NSUInteger)index];
    YHSLogLight(@"Tapped View number: %@, %ld", model.CateName, model.CateId);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithYourLoveModel:)]) {
        [self.delegate didClickElementOfCellWithYourLoveModel:model];
    }

}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    YHSLogLight(@"%s, Index: %@", __FUNCTION__, @(self.carouselContainerView.currentItemIndex));
    [self animateToTabAtIndex:self.carouselContainerView.currentItemIndex];
}


- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    [self animateToTabAtIndex:self.carouselContainerView.currentItemIndex];
}


- (void)dealloc
{
    _carouselContainerView.delegate = nil;
    _carouselContainerView.dataSource = nil;
}


@end





