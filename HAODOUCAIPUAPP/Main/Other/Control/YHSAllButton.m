//
//  YHSAllButton.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/2.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSAllButton.h"

@implementation YHSAllButton

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat titleW = contentRect.size.width * 0.65;
    
    CGFloat titleH = contentRect.size.height;
    
    return CGRectMake(0, 0, titleW, titleH);
    
}


-(CGRect)imageRectForContentRect:(CGRect)contentRect
{

    CGFloat imageW = CGRectGetWidth(contentRect) * 0.30;
    
    CGFloat imageX = contentRect.size.width * 0.65;
    
    CGFloat imageY = (contentRect.size.height - imageW)/2.0;
    
    return CGRectMake(imageX, imageY, imageW, imageW);
    
}


@end
