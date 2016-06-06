//
//  YHSTopicGroupTableSectionHeaderView.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHSTopicGroupTableSectionHeaderViewDelegate <NSObject>
@optional
- (void)didClickHeaderOfTableSecion:(NSInteger)tableSection;
@end


@interface YHSTopicGroupTableSectionHeaderView : UIView

@property (nonatomic, strong) id<YHSTopicGroupTableSectionHeaderViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageIcon:(NSString *)imageIconName tableSecion:(NSInteger)tableSection;

@end


