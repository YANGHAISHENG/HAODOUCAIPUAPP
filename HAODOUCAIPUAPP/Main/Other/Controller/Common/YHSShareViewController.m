//
//  YHSShareViewController.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/6/2.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSShareViewController.h"

@interface YHSShareViewController ()
- (void)addDismissButton;
- (void)dismiss:(id)sender;
@end

@implementation YHSShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.layer.cornerRadius = 8.f;
    self.view.backgroundColor = [UIColor colorWithRed:(float)(52/255.f) green:(float)(152/255.f) blue:(float)(219/255.f) alpha:1.f];
    [self addDismissButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Private Instance methods

- (void)addDismissButton
{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    dismissButton.tintColor = [UIColor whiteColor];
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
    
    __weak __typeof(&*self)weakSelf = self;
    [dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-10);
        make.left.and.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(60);
    }];
    
}

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
