//
//  YHSCookBookDishDetailFoodMaterialTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/27.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDishDetailFoodMaterialTableViewCell.h"
#import "YHSCookBookDishFoodMaterialModel.h"

NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_FOOD_MATERIAL = @"YHSCookBookDishDetailFoodMaterialTableViewCellID";


@interface YHSCookBookDishDetailFoodMaterialTableViewCell ()

/**
 * 根容器组件
 */
@property (nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonatomic, strong) UIView *publicContainerView;

/**
 * 左容器组件
 */
@property (nonatomic, strong) UIView *leftContainerView;
@property (nonatomic, strong) UILabel *nameLabel;

/**
 * 右容器组件
 */
@property (nonatomic, strong) UIView *rightContainerView;
@property (nonatomic, strong) UILabel *weightLabel;

/**
 * 分割线
 */
@property (nonnull, nonatomic, strong) UIView *separatorLineView;


@end


@implementation YHSCookBookDishDetailFoodMaterialTableViewCell


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
    [self.rootContainerView addSubview:self.publicContainerView];
    
    // 左部容器组件
    {
        // 容器
        self.leftContainerView =[[UIView alloc] init];
        [self.leftContainerView.layer setMasksToBounds:YES];
        [self.publicContainerView addSubview:self.leftContainerView];
        
        // 食材
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        self.nameLabel.font = [UIFont systemFontOfSize:15.0];
        [self.leftContainerView addSubview:self.nameLabel];
    }
    
    // 右部容器组件
    {
        // 容器
        self.rightContainerView =[[UIView alloc] init];
        [self.rightContainerView.layer setMasksToBounds:YES];
        [self.publicContainerView addSubview:self.rightContainerView];
        
        // 用量
        self.weightLabel = [[UILabel alloc] init];
        self.weightLabel.textAlignment = NSTextAlignmentLeft;
        self.weightLabel.font = [UIFont systemFontOfSize:15.0];
        [self.rightContainerView addSubview:self.weightLabel];
    }
    
    // 分割线
    {
        self.separatorLineView =[[UIView alloc] init];
        [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
        [self.publicContainerView addSubview:self.separatorLineView];
    } 
    
}

#pragma mark - 在这里用Masonry进行约束
- (void)setViewAtuoLayout{
    
    WEAKSELF(weakSelf);

    CGFloat margin = 10.0;
    CGFloat height = 40.0;
    
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
    
    
    // 左部容器组件
    {
        [self.leftContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@0);
            make.width.equalTo(weakSelf.rightContainerView);
            make.height.greaterThanOrEqualTo(@(height));
        }];
        
        // 食材名称
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(@(margin));
            make.bottom.equalTo(@0);
        }];
    }

    
    // 右部容器组件
    {
        [self.rightContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(weakSelf.leftContainerView.mas_right);
            make.right.equalTo(@0);
            make.height.greaterThanOrEqualTo(@(height));
        }];
        
        // 食材用量
        [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.rightContainerView);
        }];
    }

    
    // 分割线
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.leftContainerView.mas_bottom);
        make.left.equalTo(@(margin));
        make.right.equalTo(@(-margin));
        make.height.equalTo(@1.5);
    }];
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.separatorLineView.mas_bottom).offset(0.0);
    }];
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(YHSCookBookDishFoodMaterialModel *)model
{
    _model = model;
    
    if (!_model) {
        return;
    }
    
    // 食材名称
    self.nameLabel.text = _model.name;
    
    // 食材用量
    self.weightLabel.text = _model.weight;
    
    // 主食材
    if (model.isMainMaterial) {
        self.nameLabel.textColor = [UIColor blackColor];
        self.weightLabel.textColor = [UIColor blackColor];
    } else {
        self.nameLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00];
        self.weightLabel.textColor = [UIColor colorWithRed:0.35 green:0.35 blue:0.36 alpha:1.00];
    }
    
    // 食材详情
    for (UIView *subView in self.leftContainerView.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }
    if (_model.food_flag) {
        
        WEAKSELF(weakSelf);
        
        UIImageView *foodFlagImageView = [[UIImageView alloc] init];
        [foodFlagImageView setUserInteractionEnabled:YES];
        [foodFlagImageView setImage:[UIImage imageNamed:@"stuff_in"]];
        [self.leftContainerView addSubview:foodFlagImageView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressMainFoodMaterialViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [foodFlagImageView addGestureRecognizer:tapGesture];
        
        CGFloat flagSize = 15.0;
        [foodFlagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.nameLabel.mas_centerY);
            make.left.equalTo(weakSelf.nameLabel.mas_right).offset(5.0);
            make.size.mas_equalTo(CGSizeMake(flagSize, flagSize));
        }];
    }
    
}


#pragma mark - 触发操作事件

- (void)pressMainFoodMaterialViewArea:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithCookBookDishDetailFoodMaterialModel:)]) {
        [self.delegate didClickElementOfCellWithCookBookDishDetailFoodMaterialModel:self.model];
    }
}


@end
