//
//  YHSButtonWithIcon.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/5.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSButtonWithIcon.h"

@implementation YHSButtonWithIcon

- (id)initWithFrame:(CGRect)frame haveLabel:(BOOL)haveLabel {
    return [self initWithFrame:frame haveLabel:haveLabel mode:YES];
}

- (id)initWithFrame:(CGRect)frame haveLabel:(BOOL)haveLabel mode:(BOOL)isCircularBtn {
    
    if ([super initWithFrame:frame]) {
        [self initBase];
        
        if (haveLabel) {
            _downlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width, frame.size.width, frame.size.height-frame.size.width)];
            [_downlabel setText:@""];
            [_downlabel setTextColor:down_normal_color];
            [_downlabel setTextAlignment:NSTextAlignmentCenter];
            [_downlabel setFont:[UIFont systemFontOfSize:_downlabel.frame.size.height*0.6]];
            [_downlabel setBackgroundColor:[UIColor clearColor]];
            [self addSubview:_downlabel];
            
            _baseimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
            [_baseimage setBackgroundColor:[UIColor clearColor]];
            [_baseimage setContentMode:UIViewContentModeScaleAspectFit];
            [self addSubview:_baseimage];
        }
        else {
            _baseimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [_baseimage setBackgroundColor:[UIColor clearColor]];
            [_baseimage setContentMode:UIViewContentModeScaleAspectFit];
            [self addSubview:_baseimage];
        }
        
        [self initIconLabel];
        [self setIconLabelMode:isCircularBtn];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame imageSize:(CGSize)size {
    return [self initWithFrame:frame imageSize:size mode:YES];
}

- (id)initWithFrame:(CGRect)frame imageSize:(CGSize)size mode:(BOOL)isCircularBtn {
    
    if ([super initWithFrame:frame]) {
        [self initBase];
        
        _downlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height, frame.size.width, frame.size.height-size.height)];
        [_downlabel setText:@""];
        [_downlabel setTextColor:down_normal_color];
        [_downlabel setTextAlignment:NSTextAlignmentCenter];
        [_downlabel setFont:[UIFont systemFontOfSize:_downlabel.frame.size.height*0.6]];
        [_downlabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_downlabel];
        
        _baseimage = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-size.width/2, 0, size.width, size.height)];
        [_baseimage setBackgroundColor:[UIColor clearColor]];
        [_baseimage setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:_baseimage];
        
        [self initIconLabel];
        [self setIconLabelMode:isCircularBtn];
    }
    
    return self;
}

- (void)initBase {
    down_normal_color = [UIColor whiteColor];
    down_highlight_color = [UIColor whiteColor];
    
    icon_bg_normal_color = [UIColor colorWithRed:0.85 green:0.25 blue:0.22 alpha:1.00];
    icon_bg_highlight_color = [UIColor colorWithRed:0.85 green:0.25 blue:0.22 alpha:1.00];
    
    icon_label_normal_color = [UIColor whiteColor];
    icon_label_highlight_color = [UIColor lightGrayColor];
    
    [self addTarget:self action:@selector(btnHighlighted) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(btnNormal) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(btnNormal) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)initIconLabel {
    _iconlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _baseimage.frame.size.width*0.4, _baseimage.frame.size.width*0.4)];
    _iconlabel.center = CGPointMake(_baseimage.frame.origin.x+_baseimage.frame.size.width-_iconlabel.frame.size.width/1.5, _baseimage.frame.origin.y+_iconlabel.frame.size.height/1.5);
    [_iconlabel setText:@""];
    [_iconlabel setTextColor:icon_label_normal_color];
    [_iconlabel setTextAlignment:NSTextAlignmentCenter];
    [_iconlabel setFont:[UIFont systemFontOfSize:_iconlabel.frame.size.height*0.6]];
    [_iconlabel setBackgroundColor:icon_bg_normal_color];
    //不能和加阴影同时使用
    _iconlabel.layer.masksToBounds = YES;
    _iconlabel.layer.cornerRadius = _iconlabel.frame.size.height/2;//如果圆角为一半，则可以截成圆形
    _iconlabel.hidden = YES;
    [self addSubview:_iconlabel];
}

- (void)setIconLabelMode:(BOOL)isCircularBtn {
    if (isCircularBtn) {
        _iconlabel.frame = CGRectMake(0, 0, _baseimage.frame.size.width*0.4, _baseimage.frame.size.width*0.4);
        _iconlabel.center = CGPointMake(_baseimage.frame.origin.x+_baseimage.frame.size.width-_iconlabel.frame.size.width/1.5, _baseimage.frame.origin.y+_iconlabel.frame.size.height/1.5);
        _iconlabel.layer.cornerRadius = _iconlabel.frame.size.height/2;//如果圆角为一半，则可以截成圆形
    }
    else {
        _iconlabel.frame = CGRectMake(0, 0, _baseimage.frame.size.width*0.4, _baseimage.frame.size.width*0.4);
        _iconlabel.center = CGPointMake(_baseimage.frame.origin.x+_baseimage.frame.size.width, _baseimage.frame.origin.y);
        _iconlabel.layer.cornerRadius = _iconlabel.frame.size.height/2;//如果圆角为一半，则可以截成圆形
    }
}


#pragma mark - use setting
- (void)showIconLabelWithoutText {
    _iconlabel.text = nil;
    _iconlabel.hidden = NO;
    
    CGRect frame = _iconlabel.frame;
    frame.size.width = frame.size.height;
}

- (void)setIconLabelText:(NSString*)str {
    if (str && str.length > 0) {
        _iconlabel.text = str;
        _iconlabel.hidden = NO;
        
        CGRect frame = _iconlabel.frame;
        [_iconlabel sizeToFit];
        frame.size.width = _iconlabel.frame.size.width+_iconlabel.frame.size.height*0.4;
        if (frame.size.width > _baseimage.frame.size.width/2) {
            frame.size.width = _baseimage.frame.size.width/2;
        }
        else if (frame.size.width < frame.size.height) {
            frame.size.width = frame.size.height;
        }
        frame.origin.x = _iconlabel.frame.origin.x;
        frame.origin.y = _iconlabel.frame.origin.y;
        _iconlabel.frame = frame;
    }
    else {
        _iconlabel.text = nil;
        _iconlabel.hidden = YES;
        
        CGRect frame = _iconlabel.frame;
        frame.size.width = frame.size.height;
    }
}

- (void)setDownLabelColor:(UIColor*)color highlightColor:(UIColor*)highlightColor {
    down_normal_color = color;
    down_highlight_color = highlightColor;
    
    _downlabel.textColor = down_normal_color;
}

- (void)setIconBgColor:(UIColor*)color highlightColor:(UIColor*)highlightColor {
    icon_bg_normal_color = color;
    icon_bg_highlight_color = highlightColor;
    
    _iconlabel.backgroundColor = icon_bg_normal_color;
}

- (void)setIconLabelColor:(UIColor*)color highlightColor:(UIColor*)highlightColor {
    icon_label_normal_color = color;
    icon_label_highlight_color = highlightColor;
    
    _iconlabel.textColor = icon_label_normal_color;
}

- (void)setBaseImage:(NSString*)image highlightImage:(NSString*)highlightImage {
    image_normal = image;
    image_highlight = highlightImage;
    
    [_baseimage setImage:[UIImage imageNamed:image_normal]];
}


#pragma mark - btn base action
- (void)btnHighlighted {
    if (down_highlight_color) {
        _downlabel.textColor = down_highlight_color;
    }
    
    if (icon_label_highlight_color) {
        [_iconlabel setTextColor:icon_label_highlight_color];
    }
    if (icon_bg_highlight_color) {
        [_iconlabel setBackgroundColor:icon_bg_highlight_color];
    }
    
    if (image_highlight && image_highlight.length > 0) {
        [_baseimage setImage:[UIImage imageNamed:image_highlight]];
    }
}

- (void)btnNormal {
    _downlabel.textColor = down_normal_color;
    
    [_iconlabel setTextColor:icon_label_normal_color];
    [_iconlabel setBackgroundColor:icon_bg_normal_color];
    
    [_baseimage setImage:[UIImage imageNamed:image_normal]];
}

@end


