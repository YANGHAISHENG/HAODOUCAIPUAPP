//
//  YHSScrollTitleBar.h
//  YHSDEVKIT
//
//  Created by YANGHAISHENG on 16/4/26.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSScrollTitleBar;


@protocol YHSScrollTitleBarDelegate <NSObject>
@required
- (void)scrollTitleBar:(YHSScrollTitleBar *)scrollTitleBar scrollToIndex:(NSInteger)tagIndex;
@end


@interface YHSScrollTitleBar : UIView
@property (nonatomic, weak) id<YHSScrollTitleBarDelegate> delegate;
- (void)wanerSelected:(NSInteger)tagIndex;
@end

