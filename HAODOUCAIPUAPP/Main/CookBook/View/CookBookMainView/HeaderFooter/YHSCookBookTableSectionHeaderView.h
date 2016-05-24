//
//  YHSCookBookTableSectionHeaderView.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/12.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHSCookBookTableSectionHeaderViewDelegate <NSObject>
@optional
- (void)didClickHeaderOfTableSecion:(NSInteger)tableSection;
@end


@interface YHSCookBookTableSectionHeaderView : UIView

@property (nonatomic, strong) id<YHSCookBookTableSectionHeaderViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageIcon:(NSString *)imageIconName tableSecion:(NSInteger)tableSection;

@end
