//
//  VideoCutViewController.m
//  ImageCutDemo
//
//  Created by ZM on 2020/7/21.
//  Copyright © 2020 ZM. All rights reserved.
//

#import "VideoCutViewController.h"
#import <ZZMediaClipper/ZZVideoCropperView.h>
#import <ZZMediaClipper/ZZVideoExportTool.h>
#import <ZZMediaClipper/ZZVideoTimeClipView.h>
#import <ZZMediaClipper/UIView+ZZAdd.h>


@interface VideoCutViewController () <ZZVideoTimeClipViewDelegate,ZZVideoCropperViewDelegate> {
    NSString *_videoFilePath;
    NSTimeInterval _videoStartTime;
    NSTimeInterval _videoEndTime;
}
@property (nonatomic, strong) UIButton *cutBtn;
@property (nonatomic, strong) UIButton *ratioBtn1;
@property (nonatomic, strong) UIButton *ratioBtn2;
@property (nonatomic, strong) UIButton *ratioBtn3;
@property (nonatomic, strong) UIButton *ratioBtn4;
@property (nonatomic, strong) UIButton *ratioBtn5;

@property (nonatomic, strong) UIButton *resetBtn;

@property (nonatomic, strong) UIButton *playBtn;

@property (nonatomic, strong) ZZVideoCropperView *videoCropperView;
@property (nonatomic, strong) ZZVideoTimeClipView *videoTimeClipView;

@end

@implementation VideoCutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.ratioBtn1 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"9:16" forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 134, 44, 44);
        [btn addTarget:self action:@selector(ratio1) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
    self.ratioBtn2 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"1:1" forState:UIControlStateNormal];
        btn.frame = CGRectMake(44*2, UIScreen.mainScreen.bounds.size.height - 134, 44, 44);
        [btn addTarget:self action:@selector(ratio2) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
    self.ratioBtn3 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"16:9" forState:UIControlStateNormal];
        btn.frame = CGRectMake(44*4, UIScreen.mainScreen.bounds.size.height - 134, 44, 44);
        [btn addTarget:self action:@selector(ratio3) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
    self.ratioBtn4 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"3:4" forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 188, 44, 44);
        [btn addTarget:self action:@selector(ratio4) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
    self.ratioBtn5 = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"4:3" forState:UIControlStateNormal];
        btn.frame = CGRectMake(44*2, UIScreen.mainScreen.bounds.size.height - 188, 44, 44);
        [btn addTarget:self action:@selector(ratio5) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
    self.resetBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"重置" forState:UIControlStateNormal];
        btn.frame = CGRectMake(44*6, UIScreen.mainScreen.bounds.size.height - 134, 44, 44);
        [btn addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
    
    self.cutBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"裁剪" forState:UIControlStateNormal];
        btn.frame = CGRectMake(44*6, UIScreen.mainScreen.bounds.size.height - 188, 44, 44);
        [btn addTarget:self action:@selector(cut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
    [self.view addSubview:self.videoCropperView];
    _videoFilePath = [[NSBundle mainBundle] pathForResource:@"Demo" ofType:@"mp4"];
    self.videoCropperView.videoFilePath = _videoFilePath;
    self.videoCropperView.playerCoverImage =  [ZZVideoExportTool getImageFromVideoFrame:_videoFilePath atTime:kCMTimeZero];
    self.videoCropperView.resizeWHRatio = CGSizeMake(self.videoCropperView.playerCoverImage.size.width, self.videoCropperView.playerCoverImage.size.height);
    
    [self.view addSubview:self.videoTimeClipView];
    self.videoTimeClipView.totalTime = self.videoCropperView.videoDuration;
    self.videoTimeClipView.startTime = _videoStartTime;
    self.videoTimeClipView.endTime = _videoEndTime ?: self.videoCropperView.videoDuration;
    self.videoTimeClipView.videoFilePath = _videoFilePath;
    
    self.playBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor colorWithRed:255/255.0 green:31/255.0 blue:90/255.0 alpha:1/1.0];
        [btn setTitle:@"播放裁剪片段" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.frame = CGRectMake((self.view.frame.size.width - 128)/2, CGRectGetMinY(self.cutBtn.frame) - 40, 128, 30);
        [btn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
}

#pragma mark - ZZVideoTimeClipView
- (ZZVideoTimeClipView *)videoTimeClipView {
    if (!_videoTimeClipView) {
        _videoTimeClipView = [[ZZVideoTimeClipView alloc] initWithFrame:CGRectMake(20, self.videoCropperView.bottom + 30, UIScreen.mainScreen.bounds.size.width - 40, 26.5+48+13)];
        _videoTimeClipView.delegate = self;
    }
    return _videoTimeClipView;
}

- (void)didChangeStartTimeAction:(ZZVideoTimeClipView *)view {
    _videoStartTime = view.startTime;
    [self.videoCropperView playerStop];
    [self.videoCropperView seekToTime:_videoStartTime];
}

- (void)didChangeEndTimeAction:(ZZVideoTimeClipView *)view {
    _videoEndTime = view.endTime;
    [self.videoCropperView playerStop];
    [self.videoCropperView seekToTime:_videoEndTime];
}

#pragma mark - ZZVideoCropperView
- (ZZVideoCropperView *)videoCropperView {
    if (!_videoCropperView) {
        _videoCropperView = [[ZZVideoCropperView alloc] initWithFrame:CGRectMake(20, 100, UIScreen.mainScreen.bounds.size.width - 40, UIScreen.mainScreen.bounds.size.width - 40)];
        _videoCropperView.delegate = self;
    }
    return _videoCropperView;
}

- (void)ratio1 {
    self.videoCropperView.resizeWHRatio = CGSizeMake(9, 16);
}

- (void)ratio2 {
    self.videoCropperView.resizeWHRatio = CGSizeMake(1, 1);
}

- (void)ratio3 {
    self.videoCropperView.resizeWHRatio = CGSizeMake(16, 9);
}

- (void)ratio4 {
    self.videoCropperView.resizeWHRatio = CGSizeMake(3, 4);
}

- (void)ratio5 {
    self.videoCropperView.resizeWHRatio = CGSizeMake(4, 3);
}

- (void)reset {
    self.videoCropperView.resizeWHRatio = CGSizeMake(self.videoCropperView.playerCoverImage.size.width, self.videoCropperView.playerCoverImage.size.height);
    _videoStartTime = 0;
    _videoEndTime = self.videoCropperView.videoDuration;
    [self.videoCropperView seekToTime:_videoStartTime];
    self.videoTimeClipView.startTime = _videoStartTime;
    self.videoTimeClipView.endTime = _videoEndTime;
}

- (void)play {
    [self.videoCropperView seekToTime:_videoStartTime];
    [self.videoCropperView playerPlay];
}

- (void)cut {
    __weak typeof(self) weakSelf = self;
    CGRect cropRect = self.videoCropperView.cropRect;
    NSLog(@"playerCoverImage.rect:%@",NSStringFromCGRect(cropRect));
    [ZZVideoExportTool.sharedInstance setExportProgressBlock:^(NSNumber * _Nonnull percentage) {
        NSLog(@"ZZVideoExportTool progress : %@",percentage);
    }];
    [ZZVideoExportTool.sharedInstance setFinishVideoBlock:^(BOOL success, id  _Nonnull result) {
        if (success) {
            [weakSelf writeExportedVideoToAssetsLibrary:result];
        }
    }];
    [ZZVideoExportTool.sharedInstance addEffectToVideo:_videoFilePath cropRect:cropRect startTime:_videoStartTime endTime:_videoEndTime];
}

- (void)writeExportedVideoToAssetsLibrary:(NSString *)outputPath
{
    NSURL *exportURL = [NSURL fileURLWithPath:outputPath];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    if ([library videoAtPathIsCompatibleWithSavedPhotosAlbum:exportURL])
    {
        [library writeVideoAtPathToSavedPhotosAlbum:exportURL completionBlock:^(NSURL *assetURL, NSError *error)
         {
             NSString *message;
             if (!error)
             {
                 message = @"SaveSuccess";
             }
             else
             {
                 message = [error description];
             }
         }];
    }
    else
    {
        NSString *message = @"SaveFailed";
        NSLog(@"%@", message);
        
    }
    
    library = nil;
}
@end
