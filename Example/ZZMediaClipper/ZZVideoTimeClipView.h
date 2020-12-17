//
//  ZZVideoTimeClipView.h
//  ImageCutDemo
//
//  Created by ZM on 2020/7/23.
//  Copyright © 2020 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZZVideoTimeClipView;
@protocol ZZVideoTimeClipViewDelegate <NSObject>
@optional
- (void)didChangeStartTimeAction:(ZZVideoTimeClipView *)view;
- (void)didChangeEndTimeAction:(ZZVideoTimeClipView *)view;

@end

@interface ZZVideoTimeClipView : UIView

@property (nonatomic,copy) NSString *videoFilePath;
@property (nonatomic,assign) NSTimeInterval totalTime;
@property (nonatomic,assign) NSTimeInterval startTime;
@property (nonatomic,assign) NSTimeInterval endTime;

@property (nonatomic, weak) id <ZZVideoTimeClipViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
