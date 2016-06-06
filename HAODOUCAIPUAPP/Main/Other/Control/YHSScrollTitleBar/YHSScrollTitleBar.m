//
//  YHSScrollTitleBar.m
//  YHSDEVKIT
//
//  Created by YANGHAISHENG on 16/4/26.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSScrollTitleBar.h"
#import "Masonry.h"

@interface YHSScrollTitleBar ()
@property (nonatomic, weak) UIButton *button;
@end


@implementation YHSScrollTitleBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
        [self setViewAtuoLayout];
    }
    return self;
}

- (void)createUI
{
    [self addButton:@"item1"];
    [self addButton:@"item2"];
    [self addButton:@"item3"];
}

- (void)addButton:(NSString*)title
{
    UIButton *btn = [[UIButton alloc]init];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:75/255.0 green:75/255.0 blue:75/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:247/255.0 green:133/255.0 blue:136/255.0 alpha:1.0] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

-(void)setViewAtuoLayout
{
    // 弱引用self
    __weak __typeof(&*self) weakSelf = self;
    
    // 添加约束
    UIButton *lastBtn = nil;
    int count = (int)self.subviews.count;
    CGFloat multiplie = 1.0/count;
    for (int i = 0; i < count; i ++) {
        UIButton *button = self.subviews[i];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).offset(0);
            make.bottom.equalTo(weakSelf).offset(0);
            make.width.equalTo(weakSelf).with.multipliedBy(multiplie);
            
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(0);
            } else {
                make.left.equalTo(weakSelf.mas_left).offset(0);
            }
        }];
        
        lastBtn = weakSelf.subviews[i];
        button.tag = i;
    }
    
}


- (void)titleButtonClick:(UIButton*)sender
{
    if([self.delegate respondsToSelector:@selector(scrollTitleBar:scrollToIndex:)]) {
        [self.delegate scrollTitleBar:self scrollToIndex:sender.tag];
    }
    
    self.button.selected = NO;
    self.button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    sender.selected = YES;
    sender.titleLabel.font = [UIFont systemFontOfSize:18];
    self.button = sender;
    
    YHSLogBrown(@"Click Scroll Title Button:%ld", sender.tag);
}


- (void)wanerSelected:(NSInteger)tagIndex
{
    self.button.selected = NO;
    self.button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIButton *btn = self.subviews[tagIndex];
    btn.selected = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.button = btn;
}


@end
