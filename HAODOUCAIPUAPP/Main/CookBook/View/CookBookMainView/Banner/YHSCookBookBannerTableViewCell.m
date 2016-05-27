//
//  YHSCookBookBannerTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/16.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookBannerTableViewCell.h"
#import "YHSCookBookBannerModel.h"


CGFloat const SCROLL_BANNER_HEIGHT = 220.0;

NSString * const CELL_IDENTIFIER_BANNER = @"YHSCookBookBannerTableViewCellID";

@interface YHSCookBookBannerTableViewCell () <SDCycleScrollViewDelegate>
/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 广告栏
 */
@property (nonatomic, strong) SDCycleScrollView *cycleBannerView;
@property (nonatomic, strong) UILabel *cycleBannerTitleLabel;
@property (nonatomic, strong) NSMutableArray<NSString *> *cycleBannerTitleArray;

@end



@implementation YHSCookBookBannerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
        [self setViewAtuoLayout];
    }
    return self;
}

#pragma make 创建子控件
- (void) createView {
    
    // 根容器组件
    self.rootContainerView = [[UIView alloc] init];
    [self.contentView addSubview:self.rootContainerView];
    
    // 公共容器组件
    self.publicContainerView =[[UIView alloc] init];
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
- (void)setModel:(NSMutableArray<YHSCookBookBannerModel *> *)model {
    
    _model = model;
    
    if (!model || model.count == 0) {
        return;
    }

    // Cell复用机制会出现阴影
    for(UIView *view in self.publicContainerView.subviews) {
        [view removeFromSuperview];
    }
    
    
    WEAKSELF(weakSelf);
    
    // 广告数据信息
    NSMutableArray<NSString *> *titleArray = [NSMutableArray array];
    NSMutableArray<NSString *> *imageUrlArray = [NSMutableArray array];
    [_model enumerateObjectsUsingBlock:^(YHSCookBookBannerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleArray addObject:obj.Title];
        [imageUrlArray addObject:obj.Img];
    }];
    [self setCycleBannerTitleArray:titleArray];
    
    // 滚动广告栏
    SDCycleScrollView *cycleBannerView = [[SDCycleScrollView alloc] init];
    [cycleBannerView setDelegate:self];
    [cycleBannerView setAutoScrollTimeInterval:6.0];
    [cycleBannerView setPageControlStyle:SDCycleScrollViewPageContolStyleClassic];
    [cycleBannerView setPageDotColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00]];
    [cycleBannerView setCurrentPageDotColor:[UIColor colorWithRed:0.49 green:0.71 blue:0.27 alpha:1.00]];
    [cycleBannerView setImageURLStringsGroup:imageUrlArray];
    [self.publicContainerView addSubview:cycleBannerView];
    [cycleBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@(SCROLL_BANNER_HEIGHT));
    }];
    self.cycleBannerView = cycleBannerView;
    
    // 公共容器组件
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.cycleBannerView.mas_bottom);
    }];
    
    // 透明标题
    UILabel *cycleBannerTitleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        [cycleBannerView addSubview:label];
        [label setText:titleArray[0]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label.layer setCornerRadius:8.0];
        [label.layer setMasksToBounds:YES];
        [label setBackgroundColor:[UIColor colorWithRed:0.96 green:0.04 blue:0.02 alpha:0.70]];
        
        // 计算文字宽高
        CGFloat titleWidth = 25;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGSize size = [titleArray[0] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:attributes
                                                  context:nil].size;
        titleWidth += size.width;
        
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cycleBannerView.mas_bottom).offset(-45);
            make.centerX.equalTo(cycleBannerView.mas_centerX).offset(0);
            make.bottom.equalTo(cycleBannerView.mas_bottom).offset(-25);
            make.width.greaterThanOrEqualTo(@(titleWidth));
        }];
        
        label;
    });
    self.cycleBannerTitleLabel = cycleBannerTitleLabel;
    
}


#pragma mark - 触发操作事件
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithBannerModel:)]) {
        [self.delegate didClickElementOfCellWithBannerModel:self.model[index]];
    }
}


/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
    // 广告栏透明标题
    if (self.cycleBannerTitleArray.count >= index) {
        
        self.cycleBannerTitleLabel.text = self.cycleBannerTitleArray[index];
        
        // 计算文字宽高
        CGFloat titleWidth = 15;
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]};
        CGSize size = [self.cycleBannerTitleArray[index] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                   attributes:attributes
                                                                      context:nil].size;
        titleWidth += size.width;
        
        
        [self.cycleBannerTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.greaterThanOrEqualTo(@(titleWidth));
        }];
        
    }
    
}


@end





