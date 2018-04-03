//
//  LYPManagerVC.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/23.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPManagerVC.h"
#import "LYPManagerToolVC.h"
#import "LYPmanagerExcelVC.h"
#import "LYPPersonMainVC.h"
#import "LYPMessageMainVC.h"
#import "KKSliderMenuTool.h"


@interface LYPManagerVC ()
@property (nonatomic, strong) LYPManagerToolVC *toolVC ;
@property (nonatomic, strong) LYPmanagerExcelVC *excelVC;

@property (nonatomic, strong) UIButton *controlBtn;

@end

@implementation LYPManagerVC

-(UIButton *)controlBtn{
    if (!_controlBtn) {
        _controlBtn = [[UIButton alloc]init];
        _controlBtn.frame = CGRectMake(120, (self.view.height - 64-75)/2, 40, 75);
        [_controlBtn setImage:[UIImage imageNamed:@"L_Lage"] forState:UIControlStateNormal];
        [LYPUserSingle shareUserSingle].openToolView = NO;
        [_controlBtn addTarget:self action:@selector(controlViewframe:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _controlBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBar];//导航栏
    [self setUPUI];
    [self.view addSubview:self.controlBtn];
    [self.view bringSubviewToFront:self.controlBtn];
    

}

-(void)setUPUI{
    
    LYPManagerToolVC *toolVC = [[LYPManagerToolVC alloc]init];
    toolVC.view.frame = CGRectMake(0, 64, 120, self.view.height - 64);
    [self.view addSubview:toolVC.view];
    self.toolVC = toolVC;
    
    LYPmanagerExcelVC *excelVC = [[LYPmanagerExcelVC alloc]init];
    excelVC.view.frame = CGRectMake(120, 64, self.view.width - 120, self.view.height-64);
    [self.view addSubview:excelVC.view];
    self.excelVC = excelVC;
    
}

-(void)controlViewframe:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [LYPUserSingle shareUserSingle].openToolView = YES;
        [self.controlBtn setImage:[UIImage imageNamed:@"R_Lage"] forState:UIControlStateNormal];
        self.controlBtn.frame = CGRectMake(0, (self.view.height - 64-75)/2, 40, 75);
        self.toolVC.view.frame = CGRectMake(-120, 64, 120, self.view.height - 64);
        self.excelVC.view.frame = CGRectMake(0, 64, self.view.width, self.view.height-64);
        
    }else{
        [LYPUserSingle shareUserSingle].openToolView = NO;
        [self.controlBtn setImage:[UIImage imageNamed:@"L_Lage"] forState:UIControlStateNormal];
        self.controlBtn.frame = CGRectMake(120, (self.view.height - 64-75)/2, 40, 75);
        self.toolVC.view.frame = CGRectMake(0, 64, 120, self.view.height - 64);
        self.excelVC.view.frame = CGRectMake(120, 64, self.view.width - 120, self.view.height-64);
    }
}

-(void)setNavBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNomalImage:@"navigationbar_list_normal" selectImage:@"navigationbar_list_hl" target:self action:@selector(showPersonVC)];
    self.title = @"共享纸盒";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNomalImage:@"navigationbar_msg" selectImage:@"navigationbar_msg" target:self action:@selector(showMessageVC)];
    self.navigationController.navigationBar.backgroundColor =  RGBACOLOR(43, 45, 51, 1);
    
}
#pragma method
-(void)showPersonVC{
    
    LYPPersonMainVC *perVc = [[LYPPersonMainVC alloc]init];
    
    [KKSliderMenuTool showWithRootViewController:self contentViewController:perVc];
    
}

-(void)showMessageVC{
    
    LYPMessageMainVC *messVC = [[LYPMessageMainVC alloc]init];
    [self.navigationController pushViewController:messVC animated:YES];
}


@end
