//
//  ZZAngleScrollView.h
//  ImageCutDemo
//
//  Created by ZM on 2020/7/2.
//  Copyright © 2020 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZZAngleScrollViewDelegate <NSObject>

- (void)didSelectedAngleWithAngle:(NSInteger)angle;
- (void)didStopScroll;

@end
@interface ZZAngleScrollView : UIView
@property (nonatomic,weak) id<ZZAngleScrollViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
