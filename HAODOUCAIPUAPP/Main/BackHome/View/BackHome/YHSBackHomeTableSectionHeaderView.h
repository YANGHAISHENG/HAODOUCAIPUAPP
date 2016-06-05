//
//  YHSBackHomeTableSectionHeaderView.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/3.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHSBackHomeTableSectionHeaderViewDelegate <NSObject>
@optional
- (void)didClickHeaderOfTableSecion:(NSInteger)tableSection;
@end


@interface YHSBackHomeTableSectionHeaderView : UIView

@property (nonatomic, strong) id<YHSBackHomeTableSectionHeaderViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageIcon:(NSString *)imageIconName tableSecion:(NSInteger)tableSection;

@end


