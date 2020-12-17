//
//  ZZImageClipView.m
//  ImageCutDemo
//
//  Created by ZM on 2020/7/2.
//  Copyright © 2020 ZM. All rights reserved.
//

#import "ZZImageClipView.h"


#define UIColorFromRGB(rgbValue)            [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBWithAlpha(rgbValue,alphaValue)            [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]


@interface ZZImageClipView ()
@property (nonatomic,strong) UIView *imageView;
@end

@implementation ZZImageClipView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0x111021);
    }
    return self;
}



@end
