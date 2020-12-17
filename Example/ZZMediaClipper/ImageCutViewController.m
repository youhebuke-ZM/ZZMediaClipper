//
//  ImageCutViewController.m
//  ImageCutDemo
//
//  Created by ZM on 2020/7/21.
//  Copyright © 2020 ZM. All rights reserved.
//

#import "ImageCutViewController.h"
#import <ZZMediaClipper/ZZImageCropperView.h>
#import "ZZAngleScrollView.h"
#import "ZZImageViewController.h"

@interface ImageCutViewController ()<ZZAngleScrollViewDelegate>
@property (nonatomic) ZZAngleScrollView *angleScrollView;
@property (nonatomic, strong) ZZImageCropperView *imageCropperView;
@property (nonatomic, strong) UIButton *cutBtn;
@property (nonatomic, strong) UIButton *ratioBtn1;
@property (nonatomic, strong) UIButton *ratioBtn2;
@property (nonatomic, strong) UIButton *ratioBtn3;
@property (nonatomic, strong) UIButton *resetBtn;

@property (nonatomic, assign) CGSize currScale;

@end

@implementation ImageCutViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.cutBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"裁剪" forState:UIControlStateNormal];
        btn.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width - 44, UIScreen.mainScreen.bounds.size.height - 134, 44, 44);
        [btn addTarget:self action:@selector(cut) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
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
    
    self.resetBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:@"重置" forState:UIControlStateNormal];
        btn.frame = CGRectMake(44*6, UIScreen.mainScreen.bounds.size.height - 134, 44, 44);
        [btn addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    
    self.angleScrollView = ({
        ZZAngleScrollView *v = [[ZZAngleScrollView alloc] initWithFrame:CGRectMake(0, UIScreen.mainScreen.bounds.size.height - 80, UIScreen.mainScreen.bounds.size.width, 50)];
        v.delegate = self;
        [self.view addSubview:v];
        v;
    });
    
    [self.view addSubview:self.imageCropperView];
}

- (ZZImageCropperView *)imageCropperView {
    if (!_imageCropperView) {
        _imageCropperView = ({
            ZZImageCropperView *imageCropperView = [[ZZImageCropperView alloc] initWithImage:[UIImage imageNamed:@"DanielWu.jpg"] frame:[self imageCropViewFrame:CGSizeMake(2, 3)]];
            imageCropperView.maskColor = [UIColor yellowColor];
            imageCropperView.resizeWHRatio = CGSizeMake(9, 16);
            imageCropperView.minificationFilter = kCAFilterTrilinear;
            imageCropperView.magnificationFilter = kCAFilterTrilinear;
            imageCropperView.minZoomScale = 200;
            imageCropperView.maxZoomScale = MAXFLOAT;
            imageCropperView;
        });
    }
    return _imageCropperView;
}

- (CGRect)imageCropViewFrame:(CGSize)size {
    CGRect rect = CGRectZero;
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGFloat height = width * 3 / 2.0;
    rect = CGRectMake(0, (UIScreen.mainScreen.bounds.size.height - height) / 2.0, width, height);
    return rect;
}

- (void)ratio1 {
    self.imageCropperView.resizeWHRatio = CGSizeMake(9, 16);
}

- (void)ratio2 {
    self.imageCropperView.resizeWHRatio = CGSizeMake(1, 1);
}

- (void)ratio3 {
    self.imageCropperView.resizeWHRatio = CGSizeMake(16, 9);
}

- (void)reset {
    [self.imageCropperView reset:YES];
    self.imageCropperView.resizeWHRatio = CGSizeMake(2, 3);
}

- (void)cut {
    __weak typeof(self) wSelf = self;
    [self.imageCropperView cropImageWithComplete:^(UIImage *resizeImage) {
        __strong typeof(wSelf) sSelf = wSelf;
        if (!sSelf) {
            return;
        }
        [self imageResizerDone:resizeImage];
    }];
}

- (void)imageResizerDone:(UIImage *)resizeImage {
    if (!resizeImage) {
        NSLog(@"没有裁剪图片");
        return;
    }
    ZZImageViewController *vc = [ZZImageViewController new];
    vc.image = resizeImage;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - ZZAngleScrollViewDelegate

- (void)didSelectedAngleWithAngle:(NSInteger)angle {
    [self.imageCropperView setRotationAngle:angle];
}

- (void)didStopScroll {
    [self.imageCropperView updateLayouts];
}

@end
