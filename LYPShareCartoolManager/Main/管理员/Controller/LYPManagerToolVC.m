//
//  LYPManagerToolVC.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/23.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPManagerToolVC.h"
#import "LYPCleanToolView.h"
#import "LYPToolModel.h"
@interface LYPManagerToolVC ()<LYPCleanToolViewDelegate>

@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, strong) LYPCleanToolView *cleanToolView;

@end

@implementation LYPManagerToolVC

-(NSMutableArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor yellowColor];
    NSArray *array = @[@"设备",@"场所",@"卫生间",@"保洁人员",@"智立行走"];
    
    for (int i = 0; i<array.count; i++) {
        LYPToolModel *toolM = [LYPToolModel new];
        toolM.name = array[i];
        toolM.isSelect = NO;
        [self.titleArr addObject:toolM];
    }
    
//    建立UI界面
    [self setUPUI];
}

-(void)setUPUI{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 115, 45)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"基本信息";
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(17.0)];
    [self.view addSubview:titleLabel];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.cleanToolView = [[LYPCleanToolView alloc]initWithFrame:CGRectMake(0, 45, 120, SCREENHEIGHT - 64) collectionViewLayout:flowLayout];
    self.cleanToolView.numArr = self.titleArr;
    self.cleanToolView.toolDelegate = self;
    [self.view addSubview:self.cleanToolView];
}
#pragma mark --LYPCleanToolViewDelegate
-(void)LYPCleanToolView:(LYPCleanToolView *)toolView didSelectRow:(NSIndexPath *)indexPath{
    NSLog(@"选中");
}
-(void)LYPCleanToolView:(LYPCleanToolView *)toolView didUnSelectRow:(NSIndexPath *)indexPath{
    NSLog(@"未选中");
}

@end
