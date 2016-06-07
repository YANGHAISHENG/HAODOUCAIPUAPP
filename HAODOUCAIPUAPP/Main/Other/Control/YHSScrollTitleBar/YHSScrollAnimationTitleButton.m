//
//  YHSScrollAnimationTitleButton.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/6.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSScrollAnimationTitleButton.h"

@implementation YHSScrollAnimationTitleButton


-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat imageW = contentRect.size.height * 0.7;
    
    CGFloat imageH = imageW;
    
    CGFloat imageX = contentRect.size.width * 0.45 - imageW * 1.0;
    
    CGFloat imageY = (contentRect.size.height - imageH)/2.0;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat titleW = CGRectGetWidth(contentRect) * 0.50;
    
    CGFloat titleH = contentRect.size.height;
    
    CGFloat titleX = contentRect.size.width * 0.50;
    
    CGFloat titleY = (contentRect.size.height - titleH)/2.0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}


@end
