//
//  YHSCookBookShowVideoCollectionViewLayout.m
//  HAODOUCAIPUAPP
//
//  Created by YANGHAISHENG on 16/5/31.
//  Copyright © 2016年 YANGHAISHENG. All rights reserved.
//

#import "YHSCookBookShowVideoCollectionViewLayout.h"


#define COLLECTION_VIEW_WIDTH self.collectionView.frame.size.width

@interface YHSCookBookShowVideoCollectionViewLayout ()

//section的数量
@property (nonatomic) NSInteger numberOfSections;

//section中Cell的数量
@property (nonatomic) NSInteger numberOfCellsInSections;

//cell的宽度
@property (nonatomic) CGFloat cellWidth;

//存储每列Cell的X坐标
@property (strong, nonatomic) NSMutableArray *cellXArray;

//存储每个cell的随机高度，避免每次加载的随机高度都不同
@property (strong, nonatomic) NSMutableArray *cellHeightArray;

//记录每列Cell的最新Cell的Y坐标
@property (strong, nonatomic) NSMutableArray *cellYArray;

@end


@implementation YHSCookBookShowVideoCollectionViewLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 默认值
        _columnCount = 2;
        _cellMinHeight = 10;
        _cellMaxHeight = 100;
        _margin = 0;
        _sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

#pragma mark -- <UICollectionViewLayout>虚基类中重写的方法

/**
 * 该方法是预加载layout, 只会被执行一次
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    [self initData];
    
    [self initCellWidth];
    
    [self initCellHeight];
}

/**
 * 该方法返回CollectionView的ContentSize的大小
 */
- (CGSize)collectionViewContentSize
{
    CGFloat maxCellY = [self maxCellYArrayWithArray:_cellYArray];
    
    if (_sectionInset.bottom) {
        return CGSizeMake(COLLECTION_VIEW_WIDTH,  maxCellY - _margin + _sectionInset.bottom);
    }
    return CGSizeMake(COLLECTION_VIEW_WIDTH,  maxCellY-_margin);
}

/**
 * 该方法为每个Cell绑定一个Layout属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    [self initCellYArray];
    
    NSMutableArray *array = [NSMutableArray array];
    
    //add cells
    for (int i=0; i < _numberOfCellsInSections; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [array addObject:attributes];
    }
    
    return array;
}

/**
 * 该方法为每个Cell绑定一个Layout属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGRect frame = CGRectZero;
    
    CGFloat cellHeight = [_cellHeightArray[indexPath.row] floatValue];
    
    NSInteger minYIndex = [self minCellYArrayWithArray:_cellYArray];
    
    CGFloat tempX = [_cellXArray[minYIndex] floatValue];
    
    CGFloat tempY = [_cellYArray[minYIndex] floatValue];
    
    frame = CGRectMake(tempX, tempY, _cellWidth, cellHeight);
    
    //更新相应的Y坐标
    _cellYArray[minYIndex] = @(tempY + cellHeight + _margin);
    
    //计算每个Cell的位置
    attributes.frame = frame;
    
    return attributes;
}

/**
 * 初始化相关数据
 */
- (void) initData
{
    _numberOfSections = [self.collectionView numberOfSections];
    _numberOfCellsInSections = [self.collectionView numberOfItemsInSection:0];
}

/**
 * 根据Cell的列数求出Cell的宽度
 */
- (void) initCellWidth
{
    //计算每个Cell的宽度
    //_cellWidth = (COLLECTION_VIEW_WIDTH - (_columnCount -1) * _margin) / _columnCount;
    _cellWidth = (self.collectionView.frame.size.width - _sectionInset.left - _sectionInset.right - _margin * (_columnCount-1)) / _columnCount;
    
    //为每个Cell计算X坐标
    _cellXArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
    for (int i = 0; i < _columnCount; i ++) {
        
        CGFloat tempX = _sectionInset.left + i * (_cellWidth + _margin);
        
        [_cellXArray addObject:@(tempX)];
    }
}

/**
 * 随机生成Cell的高度
 */
- (void) initCellHeight
{
    //随机生成Cell的高度
    _cellHeightArray = [[NSMutableArray alloc] initWithCapacity:_numberOfCellsInSections];
    for (int i = 0; i < _numberOfCellsInSections; i ++) {
        
        CGFloat cellHeight = arc4random() % (_cellMaxHeight - _cellMinHeight) + _cellMinHeight;
        
        [_cellHeightArray addObject:@(cellHeight)];
    }
}

/**
 * 初始化每列Cell的Y轴坐标
 */
- (void) initCellYArray
{
    if (_cellYArray == nil) {
        _cellYArray = [[NSMutableArray alloc] initWithCapacity:_columnCount];
    }
    for (int i = 0; i < _columnCount; i ++) {
        _cellYArray[i] = @(_sectionInset.top);
    }
}

/**
 * 求CellY数组中的最大值并返回
 */
- (CGFloat) maxCellYArrayWithArray:(NSMutableArray *) array
{
    if (array.count == 0) {
        return 0.0f;
    }
    
    CGFloat max = [array[0] floatValue];
    for (NSNumber *number in array) {
        
        CGFloat temp = [number floatValue];
        
        if (max < temp) {
            max = temp;
        }
    }
    
    return max;
}

/**
 * 求CellY数组中的最小值的索引
 */
- (CGFloat) minCellYArrayWithArray:(NSMutableArray *) array
{
    if (array.count == 0) {
        return 0.0f;
    }
    
    NSInteger minIndex = 0;
    CGFloat min = [array[0] floatValue];
    
    for (int i = 0; i < array.count; i ++) {
        CGFloat temp = [array[i] floatValue];
        
        if (min > temp) {
            min = temp;
            minIndex = i;
        }
    }
    
    return minIndex;
}


@end
