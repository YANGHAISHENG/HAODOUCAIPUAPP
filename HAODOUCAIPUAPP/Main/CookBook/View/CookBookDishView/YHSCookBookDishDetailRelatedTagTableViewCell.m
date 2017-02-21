//
//  YHSCookBookDishDetailRelatedTagTableViewCell.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/29.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookDishDetailRelatedTagTableViewCell.h"
#import "YHSCookBookDishModel.h"


NSString * const CELL_IDENTIFIER_COOKBOOK_DISH_DETAIL_RELATED_TAG = @"YHSCookBookDishDetailRelatedTagTableViewCellID";


@interface YHSCookBookDishDetailRelatedTagTableViewCell ()

/**
 * 根容器组件
 */
@property (nonatomic, strong) UIView *rootContainerView;

/**
 * 公共容器组件
 */
@property (nonatomic, strong) UIView *publicContainerView;


@end



@implementation YHSCookBookDishDetailRelatedTagTableViewCell

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

    // 复用前先删除标签
    for (UIView *view in self.publicContainerView.subviews) {
        [view removeFromSuperview];
    }
    
    // 标签主容器
    CGFloat margin = 10.0;
    if (self.model.Tags.count > 0) {
        
        WEAKSELF(weakSelf);
        
        __block CGFloat lineMarkWidth = 0.0; // 记录一行标签宽度和
        UILabel *lastTagView = nil;
        for (int index = 0; index < self.model.Tags.count ; index ++) {
            
            YHSCookBookDishTagsModel *tagModel = self.model.Tags[index];
            
            // 标签背景图片
            UIView *tagView = ({
                UIView *view = [UIView new];
                [view.layer setCornerRadius:margin/2.0];
                [view.layer setMasksToBounds:YES];
                [view.layer setBackgroundColor:[UIColor colorWithRed:0.96 green:0.94 blue:0.97 alpha:1.00].CGColor];
                [self.publicContainerView addSubview:view];
                
                view;
            });
            
            // 标签文字
            UILabel *tagMark = ({
                UILabel *mark = [[UILabel alloc] init];
                [mark setTag:(index+1000)];
                [mark setText:tagModel.Name];
                [mark setUserInteractionEnabled:YES];
                [mark setTextAlignment:NSTextAlignmentCenter];
                [mark setFont:[UIFont systemFontOfSize:14.0]];
                [tagView addSubview:mark];
                
                UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressRelatedTagViewArea:)];
                tapGesture.numberOfTapsRequired = 1; // 设置点按次数，默认为1
                tapGesture.numberOfTouchesRequired = 1; // 点按的手指数
                [mark addGestureRecognizer:tapGesture];
                
                mark;
            });
            
            
            // 标签宽度
            CGFloat markWidth = 15.0;
            CGFloat markHeight = 20.0;
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:12]};
            CGSize size = [tagModel.Name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                   attributes:attributes
                                                      context:nil].size;
            markWidth += size.width;
            
            // 计算一行标签宽度和
            lineMarkWidth += markWidth + margin;
            
            // 标签位置
            [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(markWidth));
                make.height.equalTo(@(markHeight));
                
                if (lineMarkWidth < SCREEN_WIDTH - 2*margin) {
                    
                    if (lastTagView) {
                        make.top.equalTo(lastTagView.mas_top).offset(0.0);
                        make.left.equalTo(lastTagView.mas_right).offset(margin);
                    } else {
                        make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(0.0);
                        make.left.equalTo(weakSelf.publicContainerView).offset(margin);
                    }
                    
                } else {
                    
                    lineMarkWidth = markWidth + margin; // 重围行标签宽度之和
                    
                    if (lastTagView) {
                        make.top.equalTo(lastTagView.mas_bottom).offset(margin/2.0);
                        make.left.equalTo(weakSelf.publicContainerView).offset(margin);
                    } else {
                        make.top.equalTo(weakSelf.publicContainerView.mas_top).offset(0.0);
                        make.left.equalTo(weakSelf.publicContainerView).offset(margin);
                    }
                    
                }
                
            }];
  
            // 标签位置
            [tagMark mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(tagView);
            }];
            
            // 记录上一个分类标签
            lastTagView = tagMark;
        }
        
        // 约束的完整性
        [self.publicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lastTagView.mas_bottom).offset(margin);
        }];
    }
    
}


#pragma mark - 触发操作事件

- (void)pressRelatedTagViewArea:(UITapGestureRecognizer *)gesture
{
    UILabel *label = (UILabel*)gesture.view;
    NSInteger index = label.tag - 1000;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickElementOfCellWithDishDetailTagsModel:)]) {
        [self.delegate didClickElementOfCellWithDishDetailTagsModel:self.model.Tags[index]];
    }
    
}




@end
