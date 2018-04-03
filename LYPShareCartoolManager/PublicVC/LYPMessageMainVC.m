//
//  LYPMessageMainVC.m
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/18.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "LYPMessageMainVC.h"
#import "LYPPromptView.h"

@interface LYPMessageMainVC ()

@property (nonatomic, strong) LYPPromptView *promptView;

@end

@implementation LYPMessageMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavBar];
    
    self.promptView = [[LYPPromptView alloc]initWithFrame:CGRectMake((SCREENWIDTH - 200)/2, (SCREENHEIGHT - 164)/2, 200, 100) LabelString:@"抱歉！您没有信息"];
    [self.view addSubview:self.promptView];

}
-(void)setNavBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNomalImage:@"navigation_back_normal" selectImage:nil target:self action:@selector(back)];
    self.title =@"我的消息";
    self.navigationController.navigationBar.backgroundColor =  RGBACOLOR(43, 45, 51, 1);
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
