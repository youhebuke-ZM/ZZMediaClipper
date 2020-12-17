#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CALayer+ZZImageresizer.h"
#import "UIImage+ZZFixOrientation.h"
#import "UIView+ZZAdd.h"
#import "ZZImageCropperView.h"
#import "ZZImageScrollView.h"
#import "ZZVideoCropperView.h"
#import "ZZVideoExportTool.h"
#import "ZZVideoMarkPlayer.h"
#import "ZZVideoTimeClipView.h"

FOUNDATION_EXPORT double ZZMediaClipperVersionNumber;
FOUNDATION_EXPORT const unsigned char ZZMediaClipperVersionString[];

