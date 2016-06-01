

#import <UIKit/UIKit.h>

@class YHSCookBookDishModel;

@interface YHSCookBookDishVideoCommentInfoViewController : UIViewController

@property (nonatomic, strong) YHSCookBookDishModel *infoModel;

@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, assign) NSInteger rid;
@property (nonatomic, assign) NSUInteger limit; // 数量限制
@property (nonatomic, assign) NSUInteger offset; // 数据偏移量
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *type;


@end
