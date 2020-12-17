//
//  ZZVideoExportTool.h
//  ImageCutDemo
//
//  Created by ZM on 2020/7/21.
//  Copyright © 2020 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString *_Nullable(^LZVideoExportOutputFileNameBlock)(void);
typedef void (^LZVideoExportFinishVideoBlock)(BOOL success, id result);
typedef void (^LZVideoExportProgressBlock)(NSNumber *percentage);

@interface ZZVideoExportTool : NSObject

@property (copy, nonatomic) LZVideoExportFinishVideoBlock finishVideoBlock;
@property (copy, nonatomic) LZVideoExportProgressBlock exportProgressBlock;

+ (UIImage *)getImageFromVideoFrame:(NSString *)videoFilePath atTime:(CMTime)atTime;
+ (ZZVideoExportTool *)sharedInstance;
- (void)addEffectToVideo:(NSString *)videoFilePath cropRect:(CGRect)cropRect startTime:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime;

@end

NS_ASSUME_NONNULL_END
