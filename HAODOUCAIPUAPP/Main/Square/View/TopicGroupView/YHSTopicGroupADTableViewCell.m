//
//  YHSTopicGroupADTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSTopicGroupADTableViewCell.h"
#import "YHSTopicGroupADModel.h"

CGFloat const TOPICGROUP_SCROLL_AD_HEIGHT = 150.0;

NSString * const CELL_IDENTIFIER_TOPIC_GROUP_AD = @"YHSTopicGroupADTableViewCellID";

@interface YHSTopicGroupADTableViewCell () <SDCycleScrollViewDelegate>
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

@end


@implementation YHSTopicGroupADTableViewCell

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
- (void)setModel:(NSMutableArray<YHSTopicGroupADModel *> *)model {
    
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
    NSMutableArray<NSString *> *imageUrlArray = [NSMutableArray array];
    [_model enumerateObjectsUsingBlock:^(YHSTopicGroupADModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [imageUrlArray addObject:obj.Img];
    }];
    
    // 滚动广告栏
    CGFloat margin = 10.0;
    SDCycleScrollView *cycleBannerView = [[SDCycleScrollView alloc] init];
    [cycleBannerView setDelegate:self];
    [cycleBannerView setAutoScrollTimeInterval:6.0];
    [cycleBannerView setPageControlStyle:SDCycleScrollViewPageContolStyleClassic];
    [cycleBannerView setPageDotColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00]];
    [cycleBannerView setCurrentPageDotColor:[UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00]];
    [cycleBannerView setImageURLStringsGroup:imageUrlArray];
    [self.publicContainerView addSubview:cycleBannerView];
    [cycleBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0.0));
        make.left.equalTo(@(0.0));
        make.right.equalTo(@(0.0));
        make.height.equalTo(@(TOPICGROUP_SCROLL_AD_HEIGHT));
    }];
    self.cycleBannerView = cycleBannerView;
    
    // 公共容器组件
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.cycleBannerView.mas_bottom).offset(margin/2.0);
    }];
    
}


#pragma mark - 触发操作事件
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithTopicGroupADModel:)]) {
        [self.delegate didClickElementOfCellWithTopicGroupADModel:self.model[index]];
    }
}


/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
    
}



@end
