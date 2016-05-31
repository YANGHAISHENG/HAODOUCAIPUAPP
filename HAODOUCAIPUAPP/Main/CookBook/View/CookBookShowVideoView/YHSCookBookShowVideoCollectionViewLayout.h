//
//  YHSCookBookShowVideoCollectionViewLayout.h
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHSCookBookShowVideoCollectionViewLayout : UICollectionViewLayout

//瀑布流的行数
@property (nonatomic, assign) NSInteger columnCount;

//cell边距
@property (nonatomic, assign) NSInteger margin;

//四边的距离
@property (nonatomic,assign) UIEdgeInsets sectionInset;

//cell的最小高度
@property (nonatomic, assign) NSInteger cellMinHeight;

//cell的最大高度，最大高度比最小高度小，以最小高度为准
@property (nonatomic, assign) NSInteger cellMaxHeight;


@end
