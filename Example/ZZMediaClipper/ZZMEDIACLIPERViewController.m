//
//  ZZMEDIACLIPERViewController.m
//  ZZMediaClipper
//
//  Created by 周敏 on 12/17/2020.
//  Copyright (c) 2020 周敏. All rights reserved.
//

#import "ZZMEDIACLIPERViewController.h"
#import "ImageCutViewController.h"
#import "VideoCutViewController.h"

@interface ZZMEDIACLIPERViewController ()

@end

@implementation ZZMEDIACLIPERViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)imageCut:(id)sender {
    ImageCutViewController *imgCutVC = [ImageCutViewController new];
    [self.navigationController pushViewController:imgCutVC animated:YES];
}

- (IBAction)videoCut:(id)sender {
    VideoCutViewController *videoCutVC = [VideoCutViewController new];
    [self.navigationController pushViewController:videoCutVC animated:YES];
}

@end
