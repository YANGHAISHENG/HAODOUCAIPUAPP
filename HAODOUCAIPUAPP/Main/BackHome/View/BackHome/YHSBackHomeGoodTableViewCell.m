

#import "YHSBackHomeGoodTableViewCell.h"
#import "YHSBackHomeGoodsModel.h"


NSString * const CELL_IDENTIFIER_BACKHOME_GOODS = @"YHSBackHomeGoodTableViewCellID";

@interface YHSBackHomeGoodTableViewCell ()
/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonnull, nonatomic, strong) UIView *publicContainerView;

/**
 * 上部组件
 */
@property (nonnull, nonatomic, strong) UIView *upContainerView;
@property (nonnull, nonatomic, strong) UIImageView *storeLogoImageView; // 头像
@property (nonnull, nonatomic, strong) UILabel *storeTitleLabel; //
@property (nonnull, nonatomic, strong) UILabel *userNameLabel; // 用户名
@property (nonnull, nonatomic, strong) UILabel *stockLabel; // 剩余数量

/**
 * 图片
 */
@property (nonnull, nonatomic, strong) UIImageView *coverImageView;
@property (nonnull, nonatomic, strong) UIView *aplhaView; // 透明层
@property (nonnull, nonatomic, strong) UILabel *titleLabel; // 标题
@property (nonnull, nonatomic, strong) UILabel *subTitleLabel; // 副标题

/**
 * 下部组件
 */
@property (nonnull, nonatomic, strong) UIView *downContainerView;
@property (nonnull, nonatomic, strong) UILabel *deailPriceLabel; // 现价
@property (nonnull, nonatomic, strong) UILabel *priceLabel; // 原价
@property (nonnull, nonatomic, strong) UILabel *buyLabel; // 立即购买
@property (nonnull, nonatomic, strong) UIView *labelsContainerView; // 标签组件容器

/**
 * 分割线
 */
@property (nonnull, nonatomic, strong) UIView *separatorLineView;

@end




@implementation YHSBackHomeGoodTableViewCell

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
    
    // 上部组件部分
    {
        // 容器
        self.upContainerView =[[UIView alloc] init];
        [self.publicContainerView addSubview:self.upContainerView];
        
        // 头像
        self.storeLogoImageView = [UIImageView new];
        [self.storeLogoImageView.layer setMasksToBounds:YES];
        [self.storeLogoImageView setUserInteractionEnabled:YES];
        [self.upContainerView addSubview:self.storeLogoImageView];
        
        // 名称
        self.storeTitleLabel = [UILabel new];
        [self.storeTitleLabel setTextColor:[UIColor blackColor]];
        [self.storeTitleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [self.storeTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.storeTitleLabel setUserInteractionEnabled:YES];
        [self.upContainerView addSubview:self.storeTitleLabel];
        
        // 用户名
        self.userNameLabel = [UILabel new];
        [self.userNameLabel setTextColor:[UIColor lightGrayColor]];
        [self.userNameLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self.userNameLabel setTextAlignment:NSTextAlignmentLeft];
        [self.userNameLabel setUserInteractionEnabled:YES];
        [self.upContainerView addSubview:self.userNameLabel];
        
        // 剩余数量
        self.stockLabel = [UILabel new];
        [self.stockLabel setTextColor:[UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00]];
        [self.stockLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self.stockLabel setTextAlignment:NSTextAlignmentRight];
        [self.stockLabel setUserInteractionEnabled:YES];
        [self.upContainerView addSubview:self.stockLabel];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressUserInfoViewArea:)];
        tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
        tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
        [self.upContainerView addGestureRecognizer:tapGesture];
    }
    
    // 中部图片
    {
        // 图片
        self.coverImageView = [UIImageView new];
        [self.coverImageView.layer setMasksToBounds:YES];
        [self.coverImageView setUserInteractionEnabled:YES];
        [self.publicContainerView addSubview:self.coverImageView];

        // 透明层
        {
            self.aplhaView = [UIView new];
            [self.aplhaView.layer setMasksToBounds:YES];
            [self.aplhaView setBackgroundColor:[UIColor colorWithRed:0.14 green:0.14 blue:0.14 alpha:0.30]];
            [self.coverImageView addSubview:self.aplhaView];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressGoodInfoViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [self.coverImageView addGestureRecognizer:tapGesture];
        }
        
        // 标题
        self.titleLabel = [UILabel new];
        [self.titleLabel setTextColor:[UIColor whiteColor]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.titleLabel setUserInteractionEnabled:YES];
        [self.aplhaView addSubview:self.titleLabel];
        
        // 副标题
        self.subTitleLabel = [UILabel new];
        [self.subTitleLabel setTextColor:[UIColor whiteColor]];
        [self.subTitleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.subTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.subTitleLabel setUserInteractionEnabled:YES];
        [self.aplhaView addSubview:self.subTitleLabel];
    }
    
    
    // 下部组件
    {
        // 容器
        self.downContainerView =[[UIView alloc] init];
        [self.publicContainerView addSubview:self.downContainerView];
        
        // 现价
        self.deailPriceLabel = [UILabel new];
        [self.deailPriceLabel setTextColor:[UIColor redColor]];
        [self.deailPriceLabel setFont:[UIFont systemFontOfSize:18.0]];
        [self.deailPriceLabel setTextAlignment:NSTextAlignmentLeft];
        [self.downContainerView addSubview:self.deailPriceLabel];
        
        // 原价
        self.priceLabel = [UILabel new];
        [self.priceLabel setTextColor:[UIColor lightGrayColor]];
        [self.priceLabel setFont:[UIFont systemFontOfSize:12.0]];
        [self.priceLabel setTextAlignment:NSTextAlignmentLeft];
        [self.downContainerView addSubview:self.priceLabel];
        
        // 标签容器
        self.labelsContainerView =[[UIView alloc] init];
        [self.downContainerView addSubview:self.labelsContainerView];
        
        // 立即购买
        {
            self.buyLabel = [UILabel new];
            [self.buyLabel setTextColor:[UIColor whiteColor]];
            [self.buyLabel setBackgroundColor:[UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00]];
            [self.buyLabel.layer setCornerRadius:5.0];
            [self.buyLabel.layer setMasksToBounds:YES];
            [self.buyLabel setFont:[UIFont systemFontOfSize:14.0]];
            [self.buyLabel setTextAlignment:NSTextAlignmentCenter];
            [self.buyLabel setUserInteractionEnabled:YES];
            [self.downContainerView addSubview:self.buyLabel];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressBuyViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [self.buyLabel addGestureRecognizer:tapGesture];
        }

    }
    
    // 分割线
    self.separatorLineView =[[UIView alloc] init];
    [self.separatorLineView setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00]];
    [self.publicContainerView addSubview:self.separatorLineView];
    
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
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
    }];
    
    
    // 上部组件
    {
        CGFloat storeLogoImageSize = 50.0;
        
        // 主容器
        [self.upContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.left.equalTo(@(0));
            make.right.equalTo(@(0));
        }];
        
        // 头像
        [self.storeLogoImageView.layer setCornerRadius:storeLogoImageSize/2.0];
        [self.storeLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(margin));
            make.left.equalTo(@(margin));
            make.width.equalTo(@(storeLogoImageSize));
            make.height.equalTo(@(storeLogoImageSize));
        }];
        
        // 名称
        [self.storeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.storeLogoImageView.mas_top);
            make.left.equalTo(weakSelf.storeLogoImageView.mas_right).offset(margin);
            make.right.equalTo(weakSelf.upContainerView.mas_right).offset(-margin);
            make.height.equalTo(weakSelf.storeLogoImageView.mas_height).multipliedBy(1.0/2.0);
        }];
        
        // 剩余数量
        [self.stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.storeTitleLabel.mas_bottom);
            make.right.equalTo(weakSelf.upContainerView.mas_right).offset(-margin);
            make.bottom.equalTo(weakSelf.storeLogoImageView.mas_bottom);
        }];
        
        // 用户名
        [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.storeTitleLabel.mas_bottom);
            make.left.equalTo(weakSelf.storeLogoImageView.mas_right).offset(margin);
            make.right.equalTo(weakSelf.stockLabel.mas_left).offset(-margin);
            make.bottom.equalTo(weakSelf.storeLogoImageView.mas_bottom);
        }];
        
        [self.upContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.userNameLabel.mas_bottom);
        }];
        
    }
    
    // 中部组件
    {
        CGFloat coverImageHeight = 200.0;
        
        // 图片
        [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.upContainerView.mas_bottom).offset(margin);
            make.left.equalTo(@(margin));
            make.right.equalTo(@(-margin));
            make.height.equalTo(@(coverImageHeight));
        }];
        
        // 透明层
        [self.aplhaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.coverImageView);
        }];
        
        // 标题
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.aplhaView.mas_bottom).offset(-50);
            make.left.equalTo(weakSelf.aplhaView.mas_left).offset(margin);
            make.right.equalTo(weakSelf.aplhaView.mas_right).offset(-margin);
        }];
        
        // 副标题
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(0.0);
            make.left.equalTo(weakSelf.aplhaView.mas_left).offset(margin);
            make.right.equalTo(weakSelf.aplhaView.mas_right).offset(-margin);
        }];
        
    }
    
    // 下部组件
    {
        CGFloat downHeight = 30.0;
        // 主容器
        [self.downContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.coverImageView.mas_bottom).offset(margin);
            make.left.equalTo(@(0));
            make.right.equalTo(@(0));
            make.height.equalTo(@(downHeight));
        }];
        
        // 现格
        [self.deailPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.left.equalTo(@(margin));
            make.bottom.equalTo(@(0));
        }];
        
        // 立即购买
        [self.buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(margin/3.0));
            make.right.equalTo(weakSelf.downContainerView.mas_right).offset(-margin);
            make.bottom.equalTo(@(-margin/3.0));
            make.width.equalTo(@(80));
        }];
        
        // 原价
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.deailPriceLabel.mas_right).offset(0.0);
            make.centerY.equalTo(weakSelf.downContainerView.mas_centerY).offset(0.0);
        }];
        
        // 标签容器
        [self.labelsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(0));
            make.left.equalTo(weakSelf.priceLabel.mas_right).offset(0.0);
            make.right.equalTo(weakSelf.buyLabel.mas_left).offset(0.0);
            make.bottom.equalTo(@(0));
        }];

    }
    
    // 分割线
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.downContainerView.mas_bottom).offset(margin);
        make.left.equalTo(weakSelf.publicContainerView.mas_left).offset(0.0);
        make.right.equalTo(weakSelf.publicContainerView.mas_right).offset(0.0);
        make.height.equalTo(@(margin/2.0));
    }];
    
    // 约束的完整性
    [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.separatorLineView.mas_bottom).offset(0.0);
    }];

}


/**
 *  设置控件属性
 */
- (void)setModel:(YHSBackHomeGoodsModel *)model {
    
    _model = model;
    
    if (!model) {
        return;
    }
    
    // 上部组件
    {
        // 图片
        [_storeLogoImageView sd_setImageWithURL:[NSURL URLWithString:_model.StoreLogoUrl] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        
        // 名称
        [_storeTitleLabel setText:_model.StoreTitle];
        
        // 用户名
        [_userNameLabel setText:_model.UserName];

        // 剩余数量
        [_stockLabel setText:[NSString stringWithFormat:@"剩余%ld份", _model.Stock]];
        
    }
    
    // 中部组件
    {
        [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.CoverUrl] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        
        [_titleLabel setText:_model.Title];
        
        [_subTitleLabel setText:_model.SubTitle];
        
    }
    
    // 下部组件
    {
        // 实价
        {
            CGFloat margin = 10.0;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18]};
            CGSize size = [_model.DealPrice boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:attributes
                                                         context:nil].size;
            [self.deailPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(size.width+margin);
            }];
            [self.deailPriceLabel setText:_model.DealPrice];
        }
        
        // 原价
        if (_model.Price.length > 0) {
            NSAttributedString *attrStr =
            [[NSAttributedString alloc]initWithString:_model.Price
                                           attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f],
                                                        NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                                        NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
                                                        NSStrikethroughColorAttributeName:[UIColor colorWithRed:0.55 green:0.13 blue:0.82 alpha:1.00]}];
            [self.priceLabel setAttributedText:attrStr];
        } else {
            [self.priceLabel setText:@""];
        }
        
        // 购买标签
        [_buyLabel setText:@"立即购买"];
        
        // 动态标签
        {
            // 注意Cell的利用机制
            for (UIView *view in self.labelsContainerView.subviews) {
                [view removeFromSuperview];
            }
            
            // 重新创建Labels
            if(self.model.Labels.count > 0) {
                
                WEAKSELF(weakSelf);
                
                CGFloat margin = 10.0;
                
                UILabel *lastLabel = nil;
                
                for (int i = 0; i < self.model.Labels.count; i ++) {
                    
                    UILabel *subLabel = ({
                        UILabel *label = [[UILabel alloc] init];
                        [label setText:self.model.Labels[i]];
                        [label setTextColor:[UIColor whiteColor]];
                        [label setFont:[UIFont systemFontOfSize:12.0]];
                        [label setTextAlignment:NSTextAlignmentCenter];
                        [label setBackgroundColor:[UIColor colorWithRed:0.91 green:0.16 blue:0.00 alpha:1.00]];
                        [label.layer setCornerRadius:3.0];
                        [label.layer setMasksToBounds:YES];
                        [self.labelsContainerView addSubview:label];
          
                        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0]};
                        CGSize size = [self.model.Labels[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                      attributes:attributes
                                                                         context:nil].size;
                        
                        [label mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.centerY.equalTo(weakSelf.labelsContainerView.mas_centerY).offset(0.0);
                            make.height.equalTo(weakSelf.labelsContainerView.mas_height).multipliedBy(5.0/10.0);
                            
                            make.width.mas_equalTo(size.width+margin/2.0);
                            
                            if (lastLabel) {
                                make.left.equalTo(lastLabel.mas_right).offset(margin/2.0);
                            } else {
                                make.left.equalTo(weakSelf.labelsContainerView.mas_left).offset(margin);
                            }
                        }];
                        
                        label;
                    });
                    
                    lastLabel = subLabel;
                }
                
            } // if(self.model.Labels.count > 0)
            
        }

    }
    
}

// 点击用户详情按钮事件
- (void)pressUserInfoViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithUserDetailInfoAction:)]) {
        [self.delegate didClickElementOfCellWithUserDetailInfoAction:self.model];
    }
    
}

// 点击商品详情按钮事件
- (void)pressGoodInfoViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithGoodDetailInfoInfoAction:)]) {
        [self.delegate didClickElementOfCellWithGoodDetailInfoInfoAction:self.model];
    }
    
}

// 点击立即购买按钮事件
- (void)pressBuyViewArea:(UITapGestureRecognizer *)gesture
{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithBuyAction:)]) {
        [self.delegate didClickElementOfCellWithBuyAction:self.model];
    }
    
}





@end
