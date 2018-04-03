//
//  ViewController.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/8.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBACOLOR(236, 236, 236, 1);
    
    // 导航栏的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:21 / 255.0f green:27 / 255.0f blue:42 / 255.0f alpha:1];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

@end
