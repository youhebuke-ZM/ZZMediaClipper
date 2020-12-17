//
//  ZZImageCropperView.h

//
//  Created by ZM on 2019/7/19.
//  Copyright © 2020年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZImageScrollView.h"

@interface ZZImageCropperView : UIView

/**
 初始化方式 / Initialization mode
 This initialization method must be used, otherwise the view will not be displayed.
 The display range of the view does not support AutoLayout temporarily

 @param originalImage 原图 / picture to be cropped
 @param frame
 */
- (instancetype)initWithImage:(UIImage *)originalImage frame:(CGRect)frame;

/**
 容器 / control container for picture view
 */
@property (nonatomic, strong) ZZImageScrollView *imageScrollView;

/** 原图 / picture to be cropped
    It can only be set, and it is not supported to assign again
 */
@property (nonatomic, strong, readonly) UIImage *originalImage;

/** 缩小图像滤波器 / reduced image filter, default value is kCAFilterLinear  */
@property (nonatomic, strong) CALayerContentsFilter minificationFilter;

/** 放大图像滤波器 / reduced image filter, default value is kCAFilterLinear  */
@property (nonatomic, strong) CALayerContentsFilter magnificationFilter;

/** 最小裁剪分辨率 / Minimum clipping resolution ，default value is 1.0f */
@property (nonatomic, assign) CGFloat minZoomScale;

/** 最大裁剪分辨率 / Maximum clipping resolution，default value is  MAXFLOAT */
@property (nonatomic, assign) CGFloat maxZoomScale;

/** 开始缩放 / User interaction events */
@property (nonatomic, copy) void (^beginZooming)(void);

/** 结束缩放 / User interaction events */
@property (nonatomic, copy) void (^didEndZooming)(CGFloat scale);

/** 开始拖动 / User interaction events */
@property (nonatomic, copy) void (^beginDragging)(void);

/** 结束拖动，decelerate 减速状态 / User interaction events */
@property (nonatomic, copy) void (^didEndDragging)(BOOL decelerate);

/** 裁剪框范围 / Position of the crop box relative to the cropview */
@property (nonatomic, assign, readonly) CGRect maskRect;

/** 裁剪框尺寸 / Size of crop box relative to cropview */
@property (nonatomic, assign, readonly) CGRect cropRect;

/** 裁剪框颜色 / Mask layer color */
@property (nonatomic, strong) UIColor *maskColor;

/** 是否为顺势转旋转 / Is it clockwise rotation , default value is NO */
@property (nonatomic, assign, getter=isClockwiseRotation) BOOL clockwiseRotation;

/** 重置 / reset */
- (void)reset:(BOOL)animated;

/** 设置【裁剪比例】 / Setup the cut scale */
@property (nonatomic, assign) CGSize resizeWHRatio;

- (void)setResizeWHRatio:(CGSize)resizeWHRatio;

- (void)setResizeWHRatio:(CGSize)resizeWHRatio animated:(BOOL)animated;

/** 设置【旋转角度】/ Setup the rotation angle */
@property (nonatomic, assign) CGFloat rotationAngle;

- (void)rotation:(BOOL)animated;

- (void)setRotationAngle:(CGFloat)rotationAngle;

- (void)setRotationAngle:(CGFloat)rotationAngle animated:(BOOL)animated;

- (void)updateLayouts;

/**
 裁剪 / crop
 */
- (void)cropImageWithComplete:(void(^)(UIImage *resizeImage))complete;

@end


