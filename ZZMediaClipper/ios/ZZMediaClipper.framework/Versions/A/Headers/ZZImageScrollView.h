//
//  ZZImageScrollView.h

//
//  Created by ZM on 2020/7/6.
//  Copyright © 2020年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZImageScrollView : UIScrollView
@property (nonatomic, strong, nullable) UIImageView *zoomView;
@property (nonatomic, assign) BOOL fillScreen;
@property (nonatomic, copy) void (^beginZooming)(void);
@property (nonatomic, copy) void (^didEndZooming)(CGFloat scale);
@property (nonatomic, copy) void (^beginDragging)(void);
@property (nonatomic, copy) void (^didEndDragging)(BOOL decelerate);

- (void)showImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
