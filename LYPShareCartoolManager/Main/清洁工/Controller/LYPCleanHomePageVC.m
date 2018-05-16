//
//  LYPCleanHomePageVC.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/21.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPCleanHomePageVC.h"
#import "LYPCleanHomeCell.h"
#import "LYPPersonMainVC.h"
#import "LYPMessageMainVC.h"
#import "KKSliderMenuTool.h"

#import "LYPCleanMainVC.h"

#import "LYPBuildListModel.h"
#import "LYPBuildDataModel.h"

@interface LYPCleanHomePageVC ()<UICollectionViewDelegate ,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *numArr;

@property (nonatomic, strong) LYPBuildDataModel *dataModel;

@end

static NSString *cleanHomeCellId = @"cleanHomeCellId";
@implementation LYPCleanHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.numArr = @[@"A区男厕",@"A区女厕",@"B区男厕",@"B区女厕"];
    
    [self setNavBar];//导航栏
////    获取数据
//    [self setUPData];
    
    [self setupUI];
}

-(void)setupUI
{
 
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[LYPCleanHomeCell class] forCellWithReuseIdentifier:cleanHomeCellId];
    self.collectionView.backgroundColor = RGBACOLOR(236, 236, 236, 1);
    [self.view addSubview:self.collectionView];
    

    self.collectionView.mj_header = [MJRefreshStateHeader  headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [self.collectionView.mj_header beginRefreshing];
}

-(void)setNavBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNomalImage:@"navigationbar_list_normal" selectImage:@"navigationbar_list_hl" target:self action:@selector(showPersonVC)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNomalImage:@"navigationbar_msg" selectImage:@"navigationbar_msg" target:self action:@selector(showMessageVC)];
    self.title = @"共享纸盒"; self.navigationController.navigationBar.backgroundColor =  RGBACOLOR(43, 45, 51, 1);

}

-(void)setUPData{
    
    LYPNetWorkTool *netTool = [[LYPNetWorkTool alloc]init];
    [netTool getBuildFloorListWithDic:nil success:^(id responseData, NSInteger responseCode) {
        [self.collectionView.mj_header endRefreshing];
        LYPBuildDataModel *dataModel = [LYPBuildDataModel mj_objectWithKeyValues:responseData];
        if ([StringEXtension isBlankString:dataModel.error.msg]) {
            self.dataModel = dataModel;
            [self.collectionView reloadData];
        }else{
            [SVStatusHUD showWithStatus:dataModel.error.msg];
        }
        
    } failure:^(id responseData, NSInteger responseCode) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

-(void)refreshData{
    [self setUPData];
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

#pragma mark --UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataModel.data.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LYPCleanHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cleanHomeCellId forIndexPath:indexPath];
    cell.buildListModel = self.dataModel.data[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    
    return CGSizeMake(120, 120);
}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 20, 10, 20);//分别为上、左、下、右
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LYPCleanMainVC *cleanMainVC = [[LYPCleanMainVC alloc]init];
    cleanMainVC.buildListModel = self.dataModel.data[indexPath.item];
    [self.navigationController pushViewController:cleanMainVC animated:YES];
}

@end
