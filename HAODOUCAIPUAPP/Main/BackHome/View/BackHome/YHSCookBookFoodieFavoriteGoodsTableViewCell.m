

#import "YHSCookBookFoodieFavoriteGoodsTableViewCell.h"
#import "YHSBackHomeFoodieFavoriteGoodsModel.h"


NSString * const CELL_IDENTIFIER_BACKHOME_FOODIEFAVORITE_GOODS = @"YHSCookBookFoodieFavoriteGoodsTableViewCellID";

@interface YHSCookBookFoodieFavoriteGoodsTableViewCell () <SDCycleScrollViewDelegate>
/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;


/**
 * 商品项目列表控件
 */
@property (nonnull, nonatomic, strong) NSMutableArray<UIImageView *> *itemImageViews;
@property (nonnull, nonatomic, strong) NSMutableArray<UILabel *> *itemTitles;
@property (nonnull, nonatomic, strong) NSMutableArray<UILabel *> *itemPrices;

@end


@implementation YHSCookBookFoodieFavoriteGoodsTableViewCell

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
    
    CGFloat margin = 10.0;
    CGFloat itemViewHeight = 120.0;
    CGFloat itemMidDownHeight = 120;
    
    _itemImageViews = [NSMutableArray array]; // 图像
    _itemTitles = [NSMutableArray array]; // 名称
    _itemPrices = [NSMutableArray array]; // 价格
    
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
    
    // 第一行图片
    UIView *upContainerView = ({
        UIView *view = [UIView new];
        [view setTag:1000];
        [view.layer setMasksToBounds:YES];
        [self.publicContainerView addSubview:view];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressItemViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [view addGestureRecognizer:tapGesture];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(margin));
            make.left.equalTo(@(margin));
            make.right.equalTo(@(-margin));
            make.height.equalTo(@(itemViewHeight));
        }];
        
        view;
    });
    {
        // 图片
        UIImageView *imageView0 = ({
            UIImageView *imageView = [UIImageView new];
            [imageView.layer setMasksToBounds:YES];
            [imageView setUserInteractionEnabled:YES];
            [upContainerView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(upContainerView);
            }];
            
            imageView;
        });
        [_itemImageViews addObject:imageView0];
        
        // 透明层
        UIView *aplhaView = ({
            UIView *view = [UIView new];
            [view.layer setMasksToBounds:YES];
            [view setBackgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:0.30]];
            [imageView0 addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(imageView0);
            }];
            
            view;
        });

        // 标题
        CGFloat temp = 25.0;
        UILabel *itemTitleLabel0 = ({
            UILabel *label = [UILabel new];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:14.0]];
            [label setTextAlignment:NSTextAlignmentLeft];
            [aplhaView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(aplhaView.mas_bottom).offset(-temp);
                make.left.equalTo(@(2*margin));
                make.width.equalTo(aplhaView.mas_width).multipliedBy(1.0/2.0);
            }];
            
            label;
        });
        [self.itemTitles addObject:itemTitleLabel0];

        // 价格
        UILabel *itemPriceLabel0 = ({
            UILabel *label = [UILabel new];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:14.0]];
            [label setTextAlignment:NSTextAlignmentRight];
            [aplhaView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(aplhaView.mas_bottom).offset(-temp);
                make.right.equalTo(@(-2*margin));
                make.width.equalTo(aplhaView.mas_width).multipliedBy(1.0/2.0);
            }];
            
            label;
        });
        [self.itemPrices addObject:itemPriceLabel0];
    
    }
    

    // 第二行图片
    UIView *midContainerView = ({
        UIView *view = [UIView new];
        [view.layer setMasksToBounds:YES];
        [self.publicContainerView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(upContainerView.mas_bottom);
            make.left.equalTo(weakSelf.publicContainerView.mas_left);
            make.right.equalTo(weakSelf.publicContainerView.mas_right);
            make.height.equalTo(@(itemMidDownHeight));
        }];
        
        view;
    });
    {
        int count = 4;
        NSMutableArray<UIView *> *itemViews = [NSMutableArray array];
        for (int index = 1; index <= count; index ++) {
            // 项容器
            UIView *itemView = ({
                UIView *view = [UIView new];
                [view setTag:(index+1000)];
                [view.layer setMasksToBounds:YES];
                [midContainerView addSubview:view];
                
                // 点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressItemViewArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [view addGestureRecognizer:tapGesture];
                
                view;
            });
            [itemViews addObject:itemView];
            
            // 标题
            CGFloat titleBottom = -35.0;
            UILabel *itemTitleLabel0 = ({
                UILabel *label = [UILabel new];
                [label setTextColor:[UIColor blackColor]];
                [label setFont:[UIFont systemFontOfSize:14.0]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00]];
                [itemView addSubview:label];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(itemView.mas_bottom).offset(titleBottom);
                    make.left.equalTo(@(0));
                    make.right.equalTo(@(0));
                }];
                
                label;
            });
            [self.itemTitles addObject:itemTitleLabel0];
            
            // 价格
            UILabel *itemPriceLabel0 = ({
                UILabel *label = [UILabel new];
                [label setTextColor:[UIColor redColor]];
                [label setFont:[UIFont systemFontOfSize:12.0]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00]];
                [itemView addSubview:label];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(itemTitleLabel0.mas_bottom);
                    make.left.equalTo(@(0));
                    make.right.equalTo(@(0));
                    make.bottom.equalTo(@(0));
                }];
                
                label;
            });
            [self.itemPrices addObject:itemPriceLabel0];
            
            // 图片
            UIImageView *imageView = ({
                UIImageView *imageView = [UIImageView new];
                [imageView.layer setMasksToBounds:YES];
                [imageView setUserInteractionEnabled:YES];
                [itemView addSubview:imageView];
                
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(itemView.mas_top);
                    make.left.equalTo(itemView.mas_left);
                    make.right.equalTo(itemView.mas_right);
                    make.bottom.equalTo(itemTitleLabel0.mas_top);
                }];
                
                imageView;
            });
            [_itemImageViews addObject:imageView];
            
        }
        [itemViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:margin/2.0 leadSpacing:margin tailSpacing:margin];
        [itemViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(midContainerView.mas_centerY);
            make.height.equalTo(@(itemMidDownHeight));
        }];
    }
    
    
    // 第三行图片
    UIView *downContainerView = ({
        UIView *view = [UIView new];
        [view.layer setMasksToBounds:YES];
        [self.publicContainerView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(midContainerView.mas_bottom);
            make.left.equalTo(weakSelf.publicContainerView.mas_left);
            make.right.equalTo(weakSelf.publicContainerView.mas_right);
            make.height.equalTo(@(itemMidDownHeight));
        }];
        
        view;
    });
    {
        int count = 8;
        NSMutableArray<UIView *> *itemViews = [NSMutableArray array];
        for (int index = 5; index <= count; index ++) {
            UIView *itemView = ({
                UIView *view = [UIView new];
                [view setTag:(index+1000)];
                [view.layer setMasksToBounds:YES];
                [downContainerView addSubview:view];
                
                // 点击手势
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressItemViewArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [view addGestureRecognizer:tapGesture];
                
                view;
            });
            [itemViews addObject:itemView];
            
            // 标题
            CGFloat titleBottom = -35.0;
            UILabel *itemTitleLabel0 = ({
                UILabel *label = [UILabel new];
                [label setTextColor:[UIColor blackColor]];
                [label setFont:[UIFont systemFontOfSize:14.0]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00]];
                [itemView addSubview:label];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(itemView.mas_bottom).offset(titleBottom);
                    make.left.equalTo(@(0));
                    make.right.equalTo(@(0));
                }];
                
                label;
            });
            [self.itemTitles addObject:itemTitleLabel0];
            
            // 价格
            UILabel *itemPriceLabel0 = ({
                UILabel *label = [UILabel new];
                [label setTextColor:[UIColor redColor]];
                [label setFont:[UIFont systemFontOfSize:12.0]];
                [label setTextAlignment:NSTextAlignmentCenter];
                [label setBackgroundColor:[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.00]];
                [itemView addSubview:label];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(itemTitleLabel0.mas_bottom);
                    make.left.equalTo(@(0));
                    make.right.equalTo(@(0));
                    make.bottom.equalTo(@(0));
                }];
                
                label;
            });
            [self.itemPrices addObject:itemPriceLabel0];
            
            // 图片
            UIImageView *imageView = ({
                UIImageView *imageView = [UIImageView new];
                [imageView.layer setMasksToBounds:YES];
                [imageView setUserInteractionEnabled:YES];
                [itemView addSubview:imageView];
                
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(itemView.mas_top);
                    make.left.equalTo(itemView.mas_left);
                    make.right.equalTo(itemView.mas_right);
                    make.bottom.equalTo(itemTitleLabel0.mas_top);
                }];
                
                imageView;
            });
            [_itemImageViews addObject:imageView];
            
        }
        [itemViews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:margin/2.0 leadSpacing:margin tailSpacing:margin];
        [itemViews mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(downContainerView.mas_centerY);
            make.height.equalTo(@(itemMidDownHeight));
        }];
    }
    
    
    // 公共容器组件
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(downContainerView.mas_bottom).offset(margin);
    }];

}

/**
 *  设置控件属性
 */
- (void)setModel:(NSMutableArray<YHSBackHomeFoodieFavoriteGoodsModel *> *)model {
    
    _model = model;
    
    if (!model || model.count == 0) {
        return;
    }
    
    for (int index = 0; index < _itemImageViews.count; index ++) {
        
        // 图片
        [_itemImageViews[index] sd_setImageWithURL:[NSURL URLWithString:_model[index].CoverUrl] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        
        // 标题
        [_itemTitles[index] setText:_model[index].Title];
        
        // 价格
        [_itemPrices[index] setText:_model[index].Price];
    }
    
    
}

// 点击分类按钮事件
- (void)pressItemViewArea:(UITapGestureRecognizer *)gesture
{
    
    UIView *view = (UIView *)[gesture view];
    NSInteger index = view.tag-1000;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithBackHomeFoodieFavoriteGoods:)]) {
        [self.delegate didClickElementOfCellWithBackHomeFoodieFavoriteGoods:self.model[index]];
    }
    
}

@end
