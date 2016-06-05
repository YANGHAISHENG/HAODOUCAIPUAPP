

#import <UIKit/UIKit.h>
@class YHSBackHomeFoodieFavoriteGoodsModel;

UIKIT_EXTERN NSString * const CELL_IDENTIFIER_BACKHOME_FOODIEFAVORITE_GOODS;

@protocol YHSBackHomeFoodieFavoriteGoodsTableViewCellDelegate <NSObject>
@optional
- (void)didClickElementOfCellWithBackHomeFoodieFavoriteGoodsModels:(YHSBackHomeFoodieFavoriteGoodsModel *)model;
@end


@interface YHSBackHomeFoodieFavoriteGoodsTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray<YHSBackHomeFoodieFavoriteGoodsModel *> *model;

@property (nonatomic, strong) id<YHSBackHomeFoodieFavoriteGoodsTableViewCellDelegate> delegate;

@end


