#import <UIKit/UIKit.h>
@interface UIView (KGAdd)
@property (nonatomic) CGPoint origin;
@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;
@property (nonatomic, assign) UIEdgeInsets touchExtendInset;
- (void)kg_runAddAnimaion;
- (void)kg_runRemoveAnimaion;
- (void)kg_keyframeAnimation;
- (void)lz_shakeAnimation;

#pragma mark - Snapshot
- (nullable UIImage *)snapshotImage;
- (nullable UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;
@end
