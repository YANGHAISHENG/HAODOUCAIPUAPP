//
//  YHSCookBookDishDetailTableSectionHeaderFooterView.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDishDetailTableSectionHeaderFooterView.h"

@interface YHSCookBookDishDetailTableSectionHeaderFooterView ()

// 根容器组件
@property (nonnull, nonatomic, strong) UIView *rootContainerView;

// 标题
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) UIFont *font;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UILabel *contentLabel;

// 第N个Section
@property (nonatomic, assign) NSInteger tableSection;
@property (nonatomic, assign) CGFloat sectionHeight;

// 右边按钮区域
@property (nonatomic, strong) UIView *rightBtnView;
@property (nonatomic, strong) UIImageView *btnImageView;
@property (nonatomic, strong) UILabel *btnTitleLabel;

// 显示右边按钮
@property (nonatomic, assign) BOOL showBuyeListBtn;

@end


@implementation YHSCookBookDishDetailTableSectionHeaderFooterView


- (instancetype)initWithFrame:(CGRect)frame content:(NSString *)content color:(UIColor *)color font:(UIFont *)font tableSecion:(NSInteger)tableSection tagHeight:(CGFloat)sectionHeight showBuyeListBtn:(BOOL)showBuyeListBtn
{
    self = [super init];
    if (self) {
        _color = color;
        _font = font;
        _content = content;
        _tableSection = tableSection;
        _sectionHeight = sectionHeight;
        _showBuyeListBtn = showBuyeListBtn;
        [self createUI];
        [self setViewAtuoLayout];
    }
    return self;
}

- (void)createUI {
    
    // 根容器组件
    self.rootContainerView = [[UIView alloc] init];
    [self addSubview:self.rootContainerView];
    
    // 标题
    self.contentLabel = [[UILabel alloc] init];
    NSString *contentText = _content;
    NSDictionary *contentTextDict = @{NSFontAttributeName:self.font, NSForegroundColorAttributeName:self.color};
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:contentText attributes:contentTextDict];
    self.contentLabel.attributedText = attributedTitle;
    self.contentLabel.userInteractionEnabled = YES;
    self.contentLabel.backgroundColor = [UIColor whiteColor];
    [self.rootContainerView addSubview:self.contentLabel];

}

- (void)setViewAtuoLayout {
    
    // 弱引用self
    WEAKSELF(weakSelf);
    
    // 间距
    CGFloat margin = 10.0;
    
    // 根容器组件
    [self.rootContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
    }];
    
    // 标题
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(0.0);
        make.left.equalTo(weakSelf.mas_left).with.offset(margin);
        make.height.equalTo(@(_sectionHeight));
    }];
    
    // 约束完整性
    [self.rootContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentLabel.mas_bottom).offset(0.0);
    }];
    
    // 右边按钮
    if (self.showBuyeListBtn) { // 食材
        
        // 主容器
        UIView *btnView = ({
            UIView *view = [[UIView alloc] init];
            [view.layer setCornerRadius:5.0];
            [view.layer setBorderWidth:1.0];
            [view.layer setBorderColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.00].CGColor];
            [self addSubview:view];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressBtnViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [view addGestureRecognizer:tapGesture];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf.mas_centerY);
                make.right.equalTo(weakSelf.mas_right).offset(-margin);
                make.size.mas_equalTo(CGSizeMake(70.0, 25.0));
            }];
            
            view;
        });
        self.rightBtnView = btnView;
        
        // 标题
        UILabel *titleLable = ({
            UILabel *label = [[UILabel alloc] init];
            [label setText:@"采购清单"];
            [label setFont:[UIFont boldSystemFontOfSize:12.0]];
            [label setTextAlignment:NSTextAlignmentRight];
            [label setTextColor:[UIColor colorWithRed:0.95 green:0.63 blue:0.15 alpha:1.00]];
            [btnView addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btnView.mas_centerY).offset(0.0);
                make.right.equalTo(btnView.mas_right).offset(-5.0);
            }];
            
            label;
        });
        self.btnTitleLabel = titleLable;
        
        // 图标
        UIImageView *btnImageView = ({
            UIImageView *imageView = [UIImageView new];
            [imageView setImage:[UIImage imageNamed:@"btn_auxiliary_add"]];
            [btnView addSubview:imageView];
            
            CGFloat size = 12.0;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(btnView.mas_centerY).offset(0.0);
                make.right.equalTo(titleLable.mas_left).offset(0.0);
                make.size.mas_equalTo(CGSizeMake(size, size));
            }];
            
            imageView;
        });
        self.btnImageView = btnImageView;
        
    }
    

    
}



#pragma mark - 触发操作事件

- (void)pressBtnViewArea:(UITapGestureRecognizer *)gesture
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickTableSectionHeader:)]) {
        [self.delegate didClickTableSectionHeader:self.tableSection];
    }
}





@end
