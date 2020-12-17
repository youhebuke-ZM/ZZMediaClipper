//
//  ZZAngleScrollView.m
//  ImageCutDemo
//
//  Created by ZM on 2020/7/2.
//  Copyright © 2020 ZM. All rights reserved.
//

#import "ZZAngleScrollView.h"

#define angleTotal 140
#define anglePerItem 1
#define angleStart -70
#define itemCount angleTotal / anglePerItem + 1
#define itemWidth 2.0f
#define itemMargin 10.0f

@interface ZZAngleScrollView ()<UIScrollViewDelegate>
@property (nonatomic) UIScrollView *angleScroll;
@end

@implementation ZZAngleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.angleScroll = ({
        UIScrollView *scrollV = [UIScrollView new];
        scrollV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        scrollV.delegate = self;
        scrollV.showsHorizontalScrollIndicator = NO;
        scrollV.showsVerticalScrollIndicator = NO;
        scrollV.bounces = NO;
        [self addSubview:scrollV];
        scrollV;
    });
    
    
    for (NSInteger i = 0; i < itemCount; i ++) {
        UIView *lineV = [UIView new];
        lineV.backgroundColor = [UIColor whiteColor];
        CGFloat h = 11;
        if (i%10 == 0) {
            h = 16;
        }
        lineV.frame = CGRectMake(self.angleScroll.frame.size.width/2 - itemWidth/2 + itemWidth*i + itemMargin*i, self.angleScroll.frame.size.height - h, itemWidth, h);
        [self.angleScroll addSubview:lineV];
        
        if (i%10 == 0) {
            UILabel *angleLabel = [UILabel new];
            NSInteger angle = angleStart + i*anglePerItem;
            angleLabel.text = [NSString stringWithFormat:@"%ld",(long)angle];
            if (angle == 0) {
                angleLabel.textColor = [UIColor yellowColor];
                angleLabel.font = [UIFont systemFontOfSize:14];
            }else {
                angleLabel.textColor = [UIColor whiteColor];
                angleLabel.font = [UIFont systemFontOfSize:10];
            }
            CGFloat w = [angleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width;
            angleLabel.textAlignment = NSTextAlignmentCenter;
            angleLabel.frame = CGRectMake(lineV.frame.origin.x - w/2 + itemWidth/2, lineV.frame.origin.y - 25, w, 20);
            [self.angleScroll addSubview:angleLabel];
            
            UILabel *angleSignLabel = [UILabel new];
            angleSignLabel.text = @"°";
            if (angle == 0) {
                angleSignLabel.textColor = [UIColor yellowColor];
                angleSignLabel.font = [UIFont systemFontOfSize:14];
            }else {
                angleSignLabel.textColor = [UIColor whiteColor];
                angleSignLabel.font = [UIFont systemFontOfSize:10];
            }
            angleSignLabel.textAlignment = NSTextAlignmentLeft;
            angleSignLabel.frame = CGRectMake(CGRectGetMaxX(angleLabel.frame), CGRectGetMinY(angleLabel.frame), 10, CGRectGetHeight(angleLabel.frame));
            [self.angleScroll addSubview:angleSignLabel];
        }
    }
    self.angleScroll.contentSize = CGSizeMake(self.angleScroll.frame.size.width - itemWidth + itemWidth*itemCount + itemMargin*(itemCount-1), self.angleScroll.frame.size.height);
    self.angleScroll.contentOffset = CGPointMake(self.angleScroll.contentSize.width/2 - self.angleScroll.frame.size.width/2, 0);
    
    UIView *baseLine = [UIView new];
    baseLine.frame = CGRectMake(self.frame.size.width/2 - itemWidth/2, self.frame.size.height - 16, itemWidth, 16);
    baseLine.backgroundColor = [UIColor yellowColor];
    [self addSubview:baseLine];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = [self caculateCurrentIndex:scrollView];
    NSInteger angle = angleStart + index*anglePerItem;
    if ([self.delegate respondsToSelector:@selector(didSelectedAngleWithAngle:)]) {
        [self.delegate didSelectedAngleWithAngle:angle];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self resetContentOffset:scrollView];
    if ([self.delegate respondsToSelector:@selector(didStopScroll)]) {
        [self.delegate didStopScroll];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate == NO) {
        [self resetContentOffset:scrollView];
        if ([self.delegate respondsToSelector:@selector(didStopScroll)]) {
            [self.delegate didStopScroll];
        }
    }
}

- (NSInteger)caculateCurrentIndex:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x;
    NSInteger index = x / (itemWidth + itemMargin);
    CGFloat indexOffset = index*itemWidth + index*itemMargin;
    if (indexOffset < x && x - indexOffset >= 5) {
        index += 1;
    }
    return index;
}

- (void)resetContentOffset:(UIScrollView *)scrollView {
    NSInteger index = [self caculateCurrentIndex:scrollView];
    CGFloat indexOffset = index*itemWidth + index*itemMargin;
    [self.angleScroll setContentOffset:CGPointMake(indexOffset, 0) animated:YES];
}

@end
