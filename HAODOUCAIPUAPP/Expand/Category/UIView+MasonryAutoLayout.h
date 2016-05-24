//
//  UIView+MasonryAutoLayout.h
//  MasonryDemo
//
//  Created by YANGHAISHENG on 16/4/2.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MasonryAutoLayout)

- (void) distributeSpacingHorizontallyWith:(NSArray*)views;

- (void) distributeSpacingVerticallyWith:(NSArray*)views;

@end
