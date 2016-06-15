//
//  YHSIntroViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/15.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSIntroViewController.h"
#import "YHSIntroView.h"

@interface YHSIntroViewController () <YHSIntroDelegate>
{
    UIView *rootView;
}
@property (nonatomic, strong) YHSIntroView *intro;
@end


@implementation YHSIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    rootView = self.view;
    [self showIntroWithCustomView];
}

#pragma  mark 引导图
- (void)showIntroWithCustomView {
    
    UIImageView *image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_1_bg.jpg"]];
    image1.frame = rootView.bounds;
    YHSIntroPage *page1 = [YHSIntroPage pageWithCustomView:image1];
    
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_2_bg.jpg"]];
    image2.frame = rootView.bounds;
    YHSIntroPage *page2 = [YHSIntroPage pageWithCustomView:image2];
    
    UIImageView *image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_3_bg.jpg"]];
    image3.frame = rootView.bounds;
    YHSIntroPage *page3 = [YHSIntroPage pageWithCustomView:image3];
    
    UIImageView *image4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_4_bg.jpg"]];
    image4.frame = rootView.bounds;
    YHSIntroPage *page4 = [YHSIntroPage pageWithCustomView:image4];
    
    CGFloat w = CGRectGetWidth(self.view.bounds);
    UIButton *lastguidebtn = [[UIButton alloc] initWithFrame:CGRectMake((w - 100)/2, rootView.bounds.size.height - 100, 100, 29)];
    [lastguidebtn setImage:[UIImage imageNamed:@"lastguidebtn.png"] forState:UIControlStateNormal];
    [lastguidebtn addTarget:self action:@selector(gotoMain:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *image5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_5_bg.jpg"]];
    image5.frame = rootView.bounds;
    image5.userInteractionEnabled = YES;
    [image5 addSubview:lastguidebtn];
    YHSIntroPage *page5 = [YHSIntroPage pageWithCustomView:image5];
    
    self.intro = [[YHSIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1, page2, page3, page4, page5]];
    [self.intro.skipButton setTitle:@"跳过" forState:UIControlStateNormal];
    [self.intro setDelegate:self];
    [self.intro showInView:rootView animateDuration:0.3];
}

- (void)gotoMain:(UIButton *)btn
{
    [self.intro hideWithFadeOutDuration:0.3];
    YHSLogLight(@"引导结束");
    if (self.didSelectedLastPage) {
        self.didSelectedLastPage();
    }
}

- (void)introDidFinish:(YHSIntroView *)introView
{
    YHSLogLight(@"引导结束");
    if (self.didSelectedLastPage) {
        self.didSelectedLastPage();
    }
}


@end


