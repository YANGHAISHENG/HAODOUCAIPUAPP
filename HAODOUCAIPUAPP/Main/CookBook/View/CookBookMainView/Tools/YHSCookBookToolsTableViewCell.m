//
//  YHSCookBookToolsTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/13.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookToolsTableViewCell.h"
#import "YHSCookBookToolsModel.h"
#import "Masonry.h"
#import "UIView+MasonryAutoLayout.h"
#import "UIImageView+WebCache.h"
#import "YHSSysConst.h"
#import "YHSSysMacro.h"

NSString * const CELL_IDENTIFIER_TOOLS = @"YHSCookBookToolsTableViewCellID";

@interface YHSCookBookToolsTableViewCell ()
/**
 * 根容器组件
 */
@property (nonnull, nonatomic, strong) UIView *rootContainerView;
/**
 * 分类工具组件
 */
@property (nonnull, nonatomic, strong) UIView *toolContainerView;
@property (nonnull, nonatomic, strong) NSMutableArray<UIView *> *toolViews;
@property (nonnull, nonatomic, strong) NSMutableArray<UIImageView *> *toolImageView;
@property (nonnull, nonatomic, strong) NSMutableArray<UILabel *> *toolLabels;

@end


@implementation YHSCookBookToolsTableViewCell


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
    
    // 分类工具组件
    self.toolContainerView =[[UIView alloc] init];
    [self.rootContainerView addSubview:self.toolContainerView];
    
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
    
    // 分类工具组件
    {
        CGFloat toolViewHeight = 60.0f;
        CGFloat toolViewWidth = SCREEN_WIDTH / 5.0;
        
        [self.toolContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.rootContainerView.mas_top).with.offset(0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@(toolViewHeight));
            make.bottom.equalTo(weakSelf.rootContainerView.mas_bottom).offset(0);
        }];
        
        _toolViews = [NSMutableArray arrayWithCapacity:5];
        _toolImageView = [NSMutableArray arrayWithCapacity:5];
        _toolLabels = [NSMutableArray arrayWithCapacity:5];
        NSArray<NSNumber *> *toolViewTags = @[@501, @502, @503, @504, @505];
        for (int index = 0; index < toolViewTags.count; index ++) {
            // 容器
            UIView *toolView = [[UIView alloc] init];
            [self.toolContainerView addSubview:toolView];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressToolViewArea:)];
            tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
            tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
            [toolView addGestureRecognizer:tapGesture];
            [toolView setTag:toolViewTags[index].intValue];
            
            // 图片
            UIImageView *imageView = ({
                UIImageView *imageView = [[UIImageView alloc] init];
                [toolView addSubview:imageView];
                [imageView.layer setMasksToBounds:YES];
                
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(toolView.mas_top).offset(5);
                    make.centerX.equalTo(toolView.mas_centerX).offset(0);
                    make.height.equalTo(toolView.mas_height).multipliedBy(3.0/6.0);
                    make.width.equalTo(toolView.mas_height).multipliedBy(3.0/6.0);
                }];
                
                imageView;
            });
            
            // 标题
            UILabel *label = ({
                UILabel *label = [[UILabel alloc] init];
                [toolView addSubview:label];
                [label setTextColor:[UIColor blackColor]];
                [label setFont:[UIFont systemFontOfSize:12]];
                [label setTextAlignment:NSTextAlignmentCenter];
                
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(imageView.mas_bottom).offset(0);
                    make.left.equalTo(toolView.mas_left).offset(0);
                    make.bottom.equalTo(toolView.mas_bottom).offset(0);
                    make.right.equalTo(toolView.mas_right).offset(0);
                }];
                
                label;
            });
            
            // 存储
            [_toolViews addObject:toolView];
            [_toolImageView addObject:imageView];
            [_toolLabels addObject:label];
        }
        
        // 水平布局toolViews容器
        [self.toolViews[0] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.toolContainerView.mas_top).offset(0);
            make.centerY.equalTo(@[weakSelf.toolViews[1], weakSelf.toolViews[2], weakSelf.toolViews[3], weakSelf.toolViews[4]]);
            make.size.equalTo(@[weakSelf.toolViews[1], weakSelf.toolViews[2], weakSelf.toolViews[3], weakSelf.toolViews[4]]);
            make.size.mas_equalTo(CGSizeMake(toolViewWidth, toolViewHeight));
        }];
        [self.toolContainerView distributeSpacingHorizontallyWith:weakSelf.toolViews];
        
    }
    
}

/**
 *  设置控件属性
 */
- (void)setModel:(NSMutableArray<YHSCookBookToolsModel *> *)model
{
    _model = model;
    
    // 分类工具组件
    [_model enumerateObjectsUsingBlock:^(YHSCookBookToolsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_toolImageView[idx] sd_setImageWithURL:[NSURL URLWithString:obj.Img] placeholderImage:[UIImage imageNamed:PICTURE_PLACEHOLDER]];
        [_toolLabels[idx] setText:obj.Title];
    }];
    
}


#pragma mark - 触发操作事件
/** 点击分类操作 */
- (void)pressToolViewArea:(UITapGestureRecognizer *)gesture
{
    UIView *view = (UIView*)gesture.view;
    NSUInteger index = view.tag - 501;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithToolModel:)]) {
        [self.delegate didClickElementOfCellWithToolModel:self.model[index]];
    }
    
}



@end
