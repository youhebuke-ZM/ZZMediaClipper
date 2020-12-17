//
//  UIImage+ZZFixOrientation.h

//
//  Created by ZM on 2020/7/6.
//  Copyright © 2020年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LZFixOrientation)

- (UIImage *)lz_fixOrientation;

- (UIImage *)lz_rotateByAngle:(CGFloat)angleInRadians;

- (UIImage *)lz_cropBySize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
