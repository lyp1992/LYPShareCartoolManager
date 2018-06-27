//
//  LYPCleanMainVC.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/19.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPCleanMainVC.h"
#import "JoeExcelView.h"
#import "LYPPersonMainVC.h"
#import "LYPMessageMainVC.h"
#import "KKSliderMenuTool.h"
#import "LYPNetWorkTool.h"

#import "LYPDeviceListModel.h"
#import "LYPSureOperationVC.h"
#import "LYPDevicesModel.h"
#import "LYPDataListModel.h"
#import "LYPBuildListModel.h"

#import "LYPOperationVC.h"

@interface LYPCleanMainVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic, strong) LYPDeviceListModel *listModel;
@property (nonatomic, strong) UIView *containToolView;
@property (nonatomic, strong) UITableView *tableview;
@end

@implementation LYPCleanMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
//       [self setNavBar];//导航栏
//    [self setupTool];

    self.titleArr =  @[@"设备ID",@"类型", @"区域", @"蹲位", @"换纸", @"换电池"];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    self.tableview = tableView;
    
//    请求数据
    LYPNetWorkTool *netWorkTool = [[LYPNetWorkTool alloc]init];
    [SVProgressHUD showWithStatus:@"正在请求数据"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@(self.buildListModel.buildId),@"buildId",@(self.buildListModel.floor),@"floor", nil];
    [netWorkTool getEquipmentListWithDic:dic success:^(id responseData, NSInteger responseCode) {
        [SVProgressHUD dismiss];
        self.listModel = [LYPDeviceListModel mj_objectWithKeyValues:responseData];
        if (![StringEXtension isBlankString:self.listModel.error.msg]) {
            [SVStatusHUD showWithStatus:self.listModel.error.msg];
        }else{
            [self.tableview reloadData];
        }
        
    } failure:^(id responseData, NSInteger responseCode) {
        [SVProgressHUD dismiss];
        [SVStatusHUD showWithStatus:@"数据请求失败"];
    }];
    
}
-(void)setupTool{
    
    self.containToolView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 45)];
    [self.view addSubview:self.containToolView];
    UIButton *changePaperBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2 -70)/2, 0, 70, 45)];
    [changePaperBtn setTitle:@"换纸" forState:UIControlStateNormal];
    [changePaperBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changePaperBtn setImage:[UIImage imageNamed:@"ic_circle"] forState:UIControlStateNormal];
    [changePaperBtn addTarget:self action:@selector(changePaperBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.containToolView addSubview:changePaperBtn];
    
    UIButton *changeBattery = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 +(self.view.frame.size.width/2 -80)/2, 0, 80, 50)];
    [changeBattery setTitle:@"换电池" forState:UIControlStateNormal];
    [changeBattery setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [changeBattery setImage:[UIImage imageNamed:@"ic_circle"] forState:UIControlStateNormal];
    [changeBattery addTarget:self action:@selector(changebattery:) forControlEvents:UIControlEventTouchUpInside];
    [self.containToolView addSubview:changeBattery];
    
    UIView *bottmView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height - 45, self.view.width, 45)];
    bottmView.backgroundColor = [UIColor whiteColor];
    bottmView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    bottmView.layer.borderWidth = 1;
    //        批量打开
    UIButton *batchBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.width -130)/2, 2.5, 130, 40)];
    [batchBtn setTitle:@"批量打开纸盒" forState:UIControlStateNormal];
    [batchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [batchBtn addTarget:self action:@selector(batchOpenPaperBox:) forControlEvents:UIControlEventTouchUpInside];
    batchBtn.layer.masksToBounds = YES;
    batchBtn.layer.cornerRadius = 5;
    batchBtn.layer.borderColor = [UIColor blackColor].CGColor;
    batchBtn.layer.borderWidth = 1;
    [bottmView addSubview:batchBtn];
    
    [self.view addSubview:bottmView];
}
-(void)setNavBar{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNomalImage:@"navigationbar_list_normal" selectImage:@"navigationbar_list_hl" target:self action:@selector(showPersonVC)];

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

-(void)changePaperBtn:(UIButton *)sender{
    [self changeWork:sender];
}
-(void)changeWork:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"ic_selected"] forState:UIControlStateNormal];
        for (UIButton *btn in self.containToolView.subviews) {
            if (![btn isEqual:sender]) {
                [btn setImage:[UIImage imageNamed:@"ic_circle"] forState:UIControlStateNormal];
            }
        }
    }else{
        [sender setImage:[UIImage imageNamed:@"ic_circle"] forState:UIControlStateNormal];
    }
}
-(void)changebattery:(UIButton *)sender{
    [self changeWork:sender];
}

-(void)batchOpenPaperBox:(UIButton *)sender{
    
    NSLog(@"批量打开纸盒");
}

#pragma mark --UITableViewDelegate;
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listModel.data.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    LYPDataListModel *dataListModel = self.listModel.data[section];
//    return dataListModel.devices.count;
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"tableViewID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    LYPDataListModel *dataListModel = self.listModel.data[indexPath.section];
    //    60 * arr.count
    SheetView *sheetView = [[SheetView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60 * (dataListModel.devices.count +1))];
    sheetView.tableViewIndexPath = indexPath;
    sheetView.dataSource = self;
    sheetView.delegate = self;
    sheetView.sheetHead = @"序号";
    sheetView.titleRowHeight = 60;
    sheetView.titleColWidth = 80;
   
    [cell.contentView addSubview:sheetView];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYPDataListModel *dataListModel = self.listModel.data[indexPath.section];
    return 60 * (dataListModel.devices.count+1);
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIColor *backColor = [UIColor colorWithRed:224/255.0 green:236/255.0 blue:250/255.0 alpha:1.0];
    
    UIView *containView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
    containView.backgroundColor = backColor;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, tableView.frame.size.height, 45)];
     LYPDataListModel *dataListModel = self.listModel.data[section];
    label.text = dataListModel.location;
    label.backgroundColor = backColor;
    [containView addSubview:label];
    
    return containView;
}

#pragma mark --sheetDelegate
- (NSInteger)sheetView:(SheetView *)sheetView numberOfRowsInSection:(NSInteger)section
{
      LYPDataListModel *dataListModel = self.listModel.data[sheetView.tableViewIndexPath.section];
    return dataListModel.devices.count;
}
- (NSInteger)sheetView:(SheetView *)sheetView numberOfColsInSection:(NSInteger)section
{
    return self.titleArr.count;
}
- (NSString *)sheetView:(SheetView *)sheetView cellForContentItemAtIndexRow:(NSIndexPath *)indexRow indexCol:(NSIndexPath *)indexCol
{
    LYPDataListModel *dataListModel = self.listModel.data[sheetView.tableViewIndexPath.section];
    LYPDevicesModel *model = dataListModel.devices[indexRow.row];
    NSString *rowStr;
    switch (indexCol.row) {
        case 0:{
            rowStr = [NSString stringWithFormat:@"%d+%d",model.deviceId,model.online];
            break;
        }
            //        case 1:{
            //
            //           rowStr = [NSString stringWithFormat:@"%@",model.sn];
            //                break;
            //        }
//        case 2:{
//            rowStr = [NSString stringWithFormat:@"%@",model.build];
//            break;
//        }
//        case 3:{
//            rowStr = [NSString stringWithFormat:@"%d",model.floor];
//            break;
//        }
        case 1:{
            rowStr = [NSString stringWithFormat:@"%@",model.toiletType];
            break;
        }
        case 2:{
            rowStr = [NSString stringWithFormat:@"%@",model.toiletId];
            break;
        }
        case 3:{
            rowStr = [NSString stringWithFormat:@"%@",model.seatId];
            break;
        }
        case 4:{
            rowStr = [NSString stringWithFormat:@"%@",model.paper];
            break;
        }
        case 5:{
            rowStr = [NSString stringWithFormat:@"%@",model.battery];
            break;
        }
        default:
            break;
    }
    return rowStr;
}

- (NSString *)sheetView:(SheetView *)sheetView cellForLeftColAtIndexPath:(NSIndexPath*)indexPath
{
    return [NSString stringWithFormat:@"%ld", (long)indexPath.row];
}
- (NSString *)sheetView:(SheetView *)sheetView cellForTopRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString *topTitle = self.titleArr[indexPath.row];
    return topTitle;
}

- (CGFloat)sheetView:(SheetView *)sheetView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)sheetView:(SheetView *)sheetView widthForColAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (BOOL)sheetView:(SheetView *)sheetView cellWithColorAtIndexRow:(NSIndexPath *)indexRow
{
    return (indexRow.row%2 != 0)?YES:NO;
}

-(void)sheetView:(SheetView *)sheetView didSelectItemAtIndexRow:(NSIndexPath *)indexRow indexCol:(NSIndexPath *)indexCol
{
    NSLog(@"点击 row %ld, col %ld", (long)indexRow.row, (long)indexCol.row);
    if (!(indexCol.row == 4 || indexCol.row == 5)) {
        return;
    }
    LYPDataListModel *dataListModel = self.listModel.data[sheetView.tableViewIndexPath.section];
    LYPDevicesModel *dataModel = dataListModel.devices[indexRow.row];
//    if (dataModel.online == 0) {
//        [SVStatusHUD showWithStatus:@"设备出错了"];
//        return;
//    }
//    else{//还是需要调到其他界面去，点击确定换电磁成功或者换纸成功，才能刷新界面
    BOOL isbattery = NO;
    if (indexCol.row == 4) {
        isbattery = NO;
    }else{
        isbattery = YES;
    }
//        LYPSureOperationVC *operationVC = [[LYPSureOperationVC alloc]init];
//        [operationVC itemWithModel:dataModel withTopTitleArr:self.titleArr andIndexRow:nil withIndexCol:nil IsBattery:isbattery];
//        [self.navigationController pushViewController:operationVC animated:YES];
    
    LYPOperationVC *operationVC = [[LYPOperationVC alloc]init];
    [operationVC itemWithModel:dataListModel withTopTitleArr:self.titleArr andIndexRow:indexRow withIndexCol:nil IsBattery:isbattery];
    [self.navigationController pushViewController:operationVC animated:YES];
    
//    }
 
}


@end
