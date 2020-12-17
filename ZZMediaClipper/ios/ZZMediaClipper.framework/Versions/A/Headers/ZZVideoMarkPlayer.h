//
//  ZZVideoMarkPlayer.h
//  ImageCutDemo
//
//  Created by ZM on 2020/7/22.
//  Copyright © 2020 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, ZZVideoMarkPlayerPlaybackState) {
    ZZVideoMarkPlayerPlaybackStateStopped = 0,
    ZZVideoMarkPlayerPlaybackStatePlaying,
    ZZVideoMarkPlayerPlaybackStatePaused,
    ZZVideoMarkPlayerPlaybackStateFailed,
};

typedef NS_ENUM(NSInteger, ZZVideoMarkPlayerBufferingState)
{
    ZZVideoMarkPlayerBufferingStateUnknown = 0,
    ZZVideoMarkPlayerBufferingStateReady,
    ZZVideoMarkPlayerBufferingStateDelayed,
};


@class ZZVideoMarkPlayer;
@protocol ZZVideoMarkPlayerDelegate <NSObject>

- (void)videoPlayerPlaybackStateDidChange:(ZZVideoMarkPlayer *)videoPlayer;

@end
@interface ZZVideoMarkPlayer : UIView
@property (nonatomic, copy) NSString *videoPath;
@property (nonatomic, readonly) NSTimeInterval maxDuration;

@property (nonatomic, readonly) ZZVideoMarkPlayerPlaybackState playbackState;
@property (nonatomic, readonly) ZZVideoMarkPlayerBufferingState bufferingState;

@property (nonatomic,weak) id<ZZVideoMarkPlayerDelegate> delegate;
- (void)play;
- (void)pause;
- (void)stop;
- (void)seekToTime:(NSTimeInterval)seekTime;

@end

NS_ASSUME_NONNULL_END
