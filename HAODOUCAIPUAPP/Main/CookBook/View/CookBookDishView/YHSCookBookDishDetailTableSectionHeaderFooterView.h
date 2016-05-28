//
//  YHSCookBookDishDetailTableSectionHeaderFooterView.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/28.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHSCookBookDishDetailTableSectionHeaderFooterViewDelegate <NSObject>
@optional
- (void)didClickTableSectionHeader:(NSInteger )tabSection;
@end

@interface YHSCookBookDishDetailTableSectionHeaderFooterView : UIView

@property (nonatomic, strong) id<YHSCookBookDishDetailTableSectionHeaderFooterViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame content:(NSString *)content color:(UIColor *)color font:(UIFont *)font tableSecion:(NSInteger)tableSection tagHeight:(CGFloat)sectionHeight;

@end
