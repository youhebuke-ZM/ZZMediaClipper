//
//  CALayer+ZZImageresizer.h
//  ImageCutDemo
//
//  Created by ZM on 2020/7/7.
//  Copyright © 2020 ZM. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CABasicAnimation (LZImageresizer)

+ (CABasicAnimation *)lz_backwardsAnimationWithKeyPath:(NSString *)keyPath
                                               fromValue:(id)fromValue
                                                 toValue:(id)toValue
                                      timingFunctionName:(CAMediaTimingFunctionName)timingFunctionName
                                                duration:(NSTimeInterval)duration;

@end

@interface CALayer (LZImageresizer)

- (void)lz_addBackwardsAnimationWithKeyPath:(NSString *)keyPath
                                    fromValue:(id)fromValue
                                      toValue:(id)toValue
                           timingFunctionName:(CAMediaTimingFunctionName)timingFunctionName
                                     duration:(NSTimeInterval)duration;

@end

NS_ASSUME_NONNULL_END
