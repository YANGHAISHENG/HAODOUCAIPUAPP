
//
//  YHSCookBookDishDetailProductTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDishDetailProductTableViewCell.h"
#import "YHSCookBookDishModel.h"

NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_PRODUCT = @"YHSCookBookDishDetailProductTableViewCellID";

static CGFloat PRODUCT_CAROUSEL_VIEW_HEIGHT = 110; // 动画视图高度

@interface YHSCookBookDishDetailProductTableViewCell () <iCarouselDataSource, iCarouselDelegate>

/**
 * 根容器组件
 */
@property (nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonatomic, strong) UIView *publicContainerView;

/**
 * 作品展示组件
 */
@property (nonatomic, strong) iCarousel *productiCarouselView;
@property (nonatomic, strong) NSArray<YHSCookBookDishProductModel *> *iCarouselData;

/**
 * 查看全部作品
 */
@property (nonatomic, strong) UILabel *allProductLabel;

@end


@implementation YHSCookBookDishDetailProductTableViewCell

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
    [self.publicContainerView.layer setMasksToBounds:YES];
    [self.publicContainerView.layer setMasksToBounds:YES];
    [self.rootContainerView addSubview:self.publicContainerView];

}


#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);
    
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
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
    }];

}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookDishModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 作品数据源
    self.iCarouselData = [NSArray arrayWithArray:_model.Product];
    
    WEAKSELF(weakSelf);
    
    CGFloat margin = 10.0;
    
    if (self.iCarouselData.count <= 0) {
        
        // 提示信息
        UILabel *tipInfoLabel = ({
            UILabel *label = [[UILabel alloc] init];
            [self.publicContainerView addSubview:label];
            [label setText:@"没有作品"];
            [label setUserInteractionEnabled:YES];
            [label setTextColor:[UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [label setFont:[UIFont boldSystemFontOfSize:13.0]];

            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(margin);
                make.centerX.equalTo(weakSelf.publicContainerView.mas_centerX);
            }];
            
            label;
        });
        
        // 公共容器组件
        [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(tipInfoLabel.mas_bottom);
        }];
        
    } else {

        if (!self.productiCarouselView) {
            
            // 作品展示组件
            iCarousel *productiCarouselView = ({
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
                    make.height.equalTo(@(PRODUCT_CAROUSEL_VIEW_HEIGHT));
                }];
                
                carousel;
            });
            self.productiCarouselView = productiCarouselView;
            
            
            // 查看全部作品
            UILabel *allProductLabel = ({
                UILabel *label = [[UILabel alloc] init];
                [self.publicContainerView addSubview:label];
                [label setText:[NSString stringWithFormat:@"查看全部%ld个作品", self.model.ProductCount]];
                [label setUserInteractionEnabled:YES];
                [label setTextColor:[UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setFont:[UIFont boldSystemFontOfSize:13.0]];
                
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressAllProductViewArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [label addGestureRecognizer:tapGesture];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(weakSelf.productiCarouselView.mas_bottom).offset(margin);
                    make.centerX.equalTo(weakSelf.publicContainerView.mas_centerX);
                }];
                
                label;
            });
            
            
            // 公共容器组件
            [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(allProductLabel.mas_bottom);
            }];
            
        } // if (!self.productiCarouselView)

    }
  
}

#pragma mark - iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    if ([self.iCarouselData count] > 0) {
        return [self.iCarouselData count];
    }
    
    return 0;
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)reusingView
{
    YHSCookBookDishProductModel *item = self.iCarouselData[(NSUInteger)index];
    
    if (reusingView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, PRODUCT_CAROUSEL_VIEW_HEIGHT+60, PRODUCT_CAROUSEL_VIEW_HEIGHT)];
        [imageView.layer setMasksToBounds:YES];
        [imageView.layer setCornerRadius:5.0];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        reusingView = imageView;
    }
    
    [((UIImageView *)reusingView) sd_setImageWithURL:[NSURL URLWithString:item.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
    
    return reusingView;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    return 0;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)reusingView
{
    if (reusingView == nil) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, PRODUCT_CAROUSEL_VIEW_HEIGHT+60, PRODUCT_CAROUSEL_VIEW_HEIGHT)];
        [imageView.layer setMasksToBounds:YES];
        [imageView.layer setCornerRadius:5.0];
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
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.productiCarouselView.itemWidth);
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
            return YES ;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.productiCarouselView.type == iCarouselTypeCustom)
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
    YHSCookBookDishProductModel *model = (self.iCarouselData)[(NSUInteger)index];
    YHSLogLight(@"Tapped View number: %@, %ld", model.UserName, model.UserId);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithDishDetailProductModel:)]) {
        [self.delegate didClickElementOfCellWithDishDetailProductModel:model];
    }
    
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{

}


- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{

}


- (void)dealloc
{
    _productiCarouselView.delegate = nil;
    _productiCarouselView.dataSource = nil;
}



#pragma mark - 触发操作事件

- (void)pressAllProductViewArea:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithAllProductModel:)]) {
        [self.delegate didClickElementOfCellWithAllProductModel:self.model];
    }
}


@end
