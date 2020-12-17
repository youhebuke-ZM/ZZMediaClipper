//
//  ZZVideoCropperView.h
//  ImageCutDemo
//
//  Created by ZM on 2020/7/21.
//  Copyright © 2020 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZZVideoCropperViewDelegate <NSObject>

@end
@interface ZZVideoCropperView : UIView

@property (nonatomic, strong) UIImage *playerCoverImage;
@property (nonatomic, assign) CGSize resizeWHRatio;
@property (nonatomic, copy) NSString *videoFilePath;
@property (nonatomic) CGRect cropRect;
@property (nonatomic,readonly) NSTimeInterval videoDuration;
@property (nonatomic,weak) id<ZZVideoCropperViewDelegate> delegate;

- (void)playerPause;
- (void)playerPlay;
- (void)playerStop;
- (void)seekToTime:(NSTimeInterval)seekTime;

@end

NS_ASSUME_NONNULL_END
