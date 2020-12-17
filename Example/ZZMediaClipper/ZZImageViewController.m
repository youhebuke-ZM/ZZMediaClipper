//
//  ZZImageViewController.m
//  ZZImageresizerView_Example
//
//  Created by ZM on 2018/1/2.
//  Copyright © 2020年 zm. All rights reserved.
//

#import "ZZImageViewController.h"

@interface ZZImageViewController ()
@property (nonatomic) UIImageView *imageView;
@end

@implementation ZZImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = ({
        UIImageView *imgV = [UIImageView new];
        imgV.frame = CGRectMake(10, 50, UIScreen.mainScreen.bounds.size.width - 20, UIScreen.mainScreen.bounds.size.height - 100);
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:imgV];
        imgV;
    });
    self.imageView.image = self.image;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setupNavigationBar {
    self.title = @"Finish";
}

- (void)dealloc {
    NSLog(@"ZZImageViewController dealloc");
}

@end
