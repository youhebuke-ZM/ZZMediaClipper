//
//  ZZVideoTimeClipView.m
//  ImageCutDemo
//
//  Created by ZM on 2020/7/23.
//  Copyright © 2020 ZM. All rights reserved.
//

#import "ZZVideoTimeClipView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <ZZMediaClipper/ZZMediaCliper.h>

#define kPanViewWidth 11.f
#define kPanViewHeight 48.f
#define kMargin 26.5f
#define kPanLineHeight 2.f
#define kTimeLabelWidth 50.f
#define kImageCount 10

///最短裁剪时间10S
#define kMinClipTime 10.f

@interface ZZVideoTimeClipView ()
{
    ///滑块最小间距
    CGFloat _minPanPadding;
}
@property (nonatomic,strong) UILabel *leftTimeLabel;
@property (nonatomic,strong) UILabel *rightTimeLabel;
@property (nonatomic,strong) UIImageView *leftPanView;
@property (nonatomic,strong) UIImageView *rightPanView;
@property (nonatomic,strong) UIScrollView *videoTimesView;
@property (nonatomic,strong) UIView *lineViewTop;
@property (nonatomic,strong) UIView *lineViewBottom;
@property (nonatomic,strong) UIView *leftShadowView;
@property (nonatomic,strong) UIView *rightShadowView;

@end

@implementation ZZVideoTimeClipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.userInteractionEnabled = true;
    self.backgroundColor = [UIColor colorWithRed:37/255.0 green:37/255.0 blue:44/255.0 alpha:1/1.0];
    
    self.videoTimesView = ({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.backgroundColor = self.backgroundColor;
        scrollView.frame = CGRectMake(kMargin+kPanViewWidth, kMargin, self.frame.size.width - (kMargin+kPanViewWidth)*2, kPanViewHeight);
        [self addSubview:scrollView];
        scrollView;
    });
    
    self.leftShadowView = ({
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(self.videoTimesView.left, self.videoTimesView.top, 0, self.videoTimesView.height);
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addSubview:view];
        view;
    });
    
    self.rightShadowView = ({
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(self.videoTimesView.right, self.videoTimesView.top, 0, self.videoTimesView.height);
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addSubview:view];
        view;
    });
    
    self.leftPanView = ({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:@"zz_video_clip_left_pan"];
        imgV.frame = CGRectMake(kMargin, kMargin, kPanViewWidth, kPanViewHeight);
        imgV.userInteractionEnabled = true;
        UIPanGestureRecognizer *leftGuesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftPanGuestureAction:)];
        [imgV addGestureRecognizer:leftGuesture];
        [self addSubview:imgV];
        imgV;
    });
    
    self.rightPanView = ({
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:@"zz_video_clip_right_pan"];
        imgV.frame = CGRectMake(CGRectGetMaxX(self.videoTimesView.frame), kMargin, kPanViewWidth, kPanViewHeight);
        imgV.userInteractionEnabled = true;
        UIPanGestureRecognizer *panGuesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightPanGuestureAction:)];
        [imgV addGestureRecognizer:panGuesture];
        [self addSubview:imgV];
        imgV;
    });
    
    self.leftTimeLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMinX(self.leftPanView.frame) + kPanViewWidth/2 - kTimeLabelWidth/2, 0, kTimeLabelWidth, kMargin);
        label.text = [self convertTimeSecond:_startTime];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        [self addSubview:label];
        label;
    });
    
    self.rightTimeLabel =  ({
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(CGRectGetMinX(self.rightPanView.frame) + kPanViewWidth/2 - kTimeLabelWidth/2, 0, kTimeLabelWidth, kMargin);
        label.text = [self convertTimeSecond:_endTime];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
        label;
    });
    
    self.lineViewTop = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(CGRectGetMidX(self.leftPanView.frame), CGRectGetMinY(self.leftPanView.frame), CGRectGetMidX(self.rightPanView.frame) - CGRectGetMidX(self.leftPanView.frame), kPanLineHeight);
        [self addSubview:view];
        view;
    });
    
    self.lineViewBottom = ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(CGRectGetMidX(self.leftPanView.frame), CGRectGetMaxY(self.leftPanView.frame) - kPanLineHeight, CGRectGetMidX(self.rightPanView.frame) - CGRectGetMidX(self.leftPanView.frame), kPanLineHeight);
        [self addSubview:view];
        view;
    });
}

#pragma mark - Private Methods
- (void)updateViews {
    self.leftShadowView.width = self.leftPanView.right - self.videoTimesView.left;
    self.rightShadowView.left = self.rightPanView.left;
    self.rightShadowView.width = self.videoTimesView.right - self.rightPanView.left;
    
    self.leftTimeLabel.centerX = self.leftPanView.centerX;
    self.leftTimeLabel.text = [self convertTimeSecond:_startTime];

    self.rightTimeLabel.centerX = self.rightPanView.centerX;
    self.rightTimeLabel.text = [self convertTimeSecond:_endTime];

    self.lineViewTop.left = self.leftPanView.centerX;
    self.lineViewTop.width = self.rightPanView.centerX - self.leftPanView.centerX;
    self.lineViewBottom.left = self.lineViewTop.left;
    self.lineViewBottom.width = self.lineViewTop.width;
}


#pragma mark - Setter

- (void)setTotalTime:(NSTimeInterval)totalTime {
    _totalTime = totalTime;
    if (_totalTime <= 0) {
        _totalTime = kMinClipTime;
    }
    NSTimeInterval minTime = MIN(_totalTime, kMinClipTime);
    _minPanPadding = minTime/_totalTime * self.videoTimesView.width;
    [self updateViews];
}

- (void)setStartTime:(NSTimeInterval)startTime {
    _startTime = startTime;
    if (_startTime < 0) {
        _startTime = 0;
    }
    if (_startTime > _totalTime - kMinClipTime) {
        _startTime = _totalTime - kMinClipTime;
    }
    CGFloat percent = _startTime / _totalTime;
    self.leftPanView.right = self.videoTimesView.width * percent + self.videoTimesView.left;
    [self updateViews];
}

- (void)setEndTime:(NSTimeInterval)endTime {
    _endTime = endTime;
    if (_endTime <= 0) {
        _endTime = kMinClipTime;
    }
    if (_endTime > _totalTime) {
        _endTime = _totalTime;
    }
    CGFloat percent = _endTime / _totalTime;
    self.rightPanView.left = self.videoTimesView.width * percent + self.videoTimesView.left;
    [self updateViews];
}

- (void)setVideoFilePath:(NSString *)videoFilePath {
    _videoFilePath = [videoFilePath copy];
    NSURL *videoURL = [NSURL URLWithString:videoFilePath];
    if (!videoURL || !videoURL.scheme) {
        videoURL = [NSURL fileURLWithPath:videoFilePath];
    }
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    assetImageGenerator.maximumSize = UIScreen.mainScreen.bounds.size;
    UIImageView *imageView = nil;
    CGFloat itemWidth = self.videoTimesView.width / kImageCount;
    for (NSInteger i = 0; i < kImageCount; i++) {
        @autoreleasepool {
            CMTime time = CMTimeMakeWithSeconds(i * (CMTimeGetSeconds(asset.duration) / kImageCount), asset.duration.timescale);
            CGImageRef cgImage = [assetImageGenerator copyCGImageAtTime:time actualTime:NULL error:nil];
            UIImage *image = [UIImage imageWithCGImage:cgImage];
            CGRect frame = CGRectMake(i * itemWidth, 0, itemWidth, self.videoTimesView.height);
            imageView = [[UIImageView alloc] initWithFrame:frame];
            imageView.image = image;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            [self.videoTimesView insertSubview:imageView atIndex:0];
            if (cgImage) {
                CGImageRelease(cgImage);
            }
        }
    }
}

#pragma mark - UIPanGestureRecognizer

- (void)leftPanGuestureAction:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat start = self.videoTimesView.left;
            if (point.x < start) {
                self.leftPanView.right = start;
            }else if (point.x >= self.rightPanView.left - _minPanPadding) {
                self.leftPanView.right = self.rightPanView.left - _minPanPadding;
            }else {
                self.leftPanView.right = point.x;
            }
            CGFloat percent = (self.leftPanView.right - self.videoTimesView.left) / self.videoTimesView.width;
            NSTimeInterval time = percent * _totalTime;
            _startTime = time;
            [self updateViews];
            if ([self.delegate respondsToSelector:@selector(didChangeStartTimeAction:)]) {
                [self.delegate didChangeStartTimeAction:self];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if ([self.delegate respondsToSelector:@selector(didChangeStartTimeAction:)]) {
                [self.delegate didChangeStartTimeAction:self];
            }
        }
            break;
        default:
            break;
    }
}

- (void)rightPanGuestureAction:(UIPanGestureRecognizer *)pan {
    CGPoint point1 = [pan locationInView:self];
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat end = self.videoTimesView.right;
            if (point1.x > end) {
                self.rightPanView.left = end;
            }else if (point1.x <= self.leftPanView.right + _minPanPadding) {
                self.rightPanView.left = self.leftPanView.right + _minPanPadding;
            }else {
                self.rightPanView.left = point1.x;
            }
            CGFloat percent = (self.rightPanView.left - self.videoTimesView.left ) / self.videoTimesView.width;
            NSTimeInterval time = percent * _totalTime;
            _endTime = time;
            [self updateViews];
            if ([self.delegate respondsToSelector:@selector(didChangeEndTimeAction:)]) {
                [self.delegate didChangeEndTimeAction:self];
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            if ([self.delegate respondsToSelector:@selector(didChangeEndTimeAction:)]) {
                [self.delegate didChangeEndTimeAction:self];
            }
        }
            break;
        default:
            break;
    }
}



#pragma mark --
- (NSString *)convertTimeSecond:(NSInteger)timeSecond {
    NSString *theLastTime = nil;
    long second = timeSecond;
    if (timeSecond < 60) {
        theLastTime = [NSString stringWithFormat:@"00:%02zd", second];
    } else if(timeSecond >= 60 && timeSecond < 3600){
        theLastTime = [NSString stringWithFormat:@"%02zd:%02zd", second/60, second%60];
    } else if(timeSecond >= 3600){
        theLastTime = [NSString stringWithFormat:@"%02zd:%02zd:%02zd", second/3600, second%3600/60, second%60];
    }
    return theLastTime;
}

@end
