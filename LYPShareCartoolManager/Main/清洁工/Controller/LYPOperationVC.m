//
//  LYPOperationVC.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/5/17.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPOperationVC.h"
#import "LYPOperationHeadView.h"
#import "LYPPaperModel.h"
#import "LYPDevicesModel.h"
#import "LYPDataListModel.h"

@interface LYPOperationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) LYPOperationHeadView *operationHeaderView;

@property (nonatomic, strong) UITableView *tablView;

//取料锁
@property (nonatomic, strong) UIButton *materBtn;

//点击完成操作
@property (nonatomic, strong)UIButton *batButton;


@property (nonatomic, assign) BOOL isBattry;
@property (nonatomic, strong) LYPDataListModel *dataModel;
@property (nonatomic, strong) LYPPaperModel *paperM;
@property (nonatomic, strong) LYPPaperDataMOdel *SelectPaperDataModel;

@property (nonatomic, strong) NSIndexPath *indexpath;

@end

@implementation LYPOperationVC

-(void)itemWithModel:(LYPDataListModel *)model withTopTitleArr:(NSArray *)titleArr andIndexRow:(NSIndexPath *)indexPath withIndexCol:(NSIndexPath *)indexCol IsBattery:(BOOL)isBattery{
    self.isBattry = isBattery;
    self.dataModel = model;
    self.indexpath = indexPath;
    
    self.operationHeaderView.indePath = indexPath;
    self.operationHeaderView.dataListModel = model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    进入界面的时候去开启设备
    [self setupData];
    
    self.view.backgroundColor = [UIColor whiteColor];
//   顶部
    self.operationHeaderView = [LYPOperationHeadView awakeFormXib];
    self.operationHeaderView.frame = CGRectMake(0, 74, self.operationHeaderView.width, self.operationHeaderView.height) ;
    [self.view addSubview:self.operationHeaderView];
    
//    中部
    self.tablView = [[UITableView alloc]initWithFrame:CGRectMake(0, 304, SCREENWIDTH, 45 * 3)];
    self.tablView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tablView.delegate = self;
    self.tablView.dataSource = self;
    self.tablView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tablView];
//    self.tablView.allowsMultipleSelection = NO;
//    240 + 135 +
//    底部
    [self setupBottomView];

}
-(void)setupBottomView{
    UIButton *batButton = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREENHEIGHT - 60, SCREENWIDTH - 40, 44)];
    batButton.backgroundColor = [UIColor lightGrayColor];
    [batButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    batButton.layer.masksToBounds = YES;
    batButton.layer.cornerRadius = 5;
    [batButton addTarget:self action:@selector(batBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:batButton];
    [batButton setTitle:@"更换完成" forState:UIControlStateNormal];
    self.batButton = batButton;
    
    self.materBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREENHEIGHT - 60-54, SCREENWIDTH - 40, 44)];
    self.materBtn.backgroundColor = [UIColor lightGrayColor];
    [ self.materBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.materBtn setTitle:@"开取料锁" forState:UIControlStateNormal];
    self.materBtn.layer.masksToBounds = YES;
    self.materBtn.layer.cornerRadius = 5;
    [ self.materBtn addTarget:self action:@selector(materBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.materBtn];
}

-(void)setupData
{
    LYPNetWorkTool *netWorkTool = [[LYPNetWorkTool alloc]init];
    //    换纸和换电池都是一个接口
    //    拿到当前的行列模型
    LYPDevicesModel *deviceModel = self.dataModel.devices[self.indexpath.row];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:deviceModel.sn,@"devicesn", nil];
    [SVProgressHUD showWithStatus:@"正在打开"];
    [netWorkTool openDeviceWithDic:dic success:^(id responseData, NSInteger responseCode) {
        [SVProgressHUD dismiss];
        LYPloginModel *model = [LYPloginModel mj_objectWithKeyValues:responseData];
        if (![StringEXtension isBlankString:model.error.msg]) {
            [SVStatusHUD showWithStatus:model.error.msg];
            self.operationHeaderView.successOpen = NO;
        }else{
            [SVStatusHUD showWithStatus:@"打开成功"];
            self.operationHeaderView.successOpen = YES;
        }
        
    } failure:^(id responseData, NSInteger responseCode) {
        [SVProgressHUD dismiss];
        [SVStatusHUD showWithStatus:@"打开失败"];
        self.operationHeaderView.successOpen = NO;
    }];
    
    if (self.isBattry) {
    }else{
        
        [self.batButton setTitle:@"确认换纸成功" forState:UIControlStateNormal];
        //        去纸品列表
        [SVProgressHUD showWithStatus:@"正在请求纸品"];
        [netWorkTool getPaperListWithDic:nil success:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            self.paperM = [LYPPaperModel mj_objectWithKeyValues:responseData];
            if (![StringEXtension isBlankString:self.paperM.error.msg]) {
                [SVStatusHUD showWithStatus:self.paperM.error.msg];
            }else{
                
                [self.tablView reloadData];
            }
            
        } failure:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            [SVStatusHUD showWithStatus:@"请求失败"];
        }];
        
    }
}
-(void)materBtnClick:(UIButton *)sender{
    
    LYPNetWorkTool *networkTool = [[LYPNetWorkTool alloc]init];
     LYPDevicesModel *deviceModel = self.dataModel.devices[self.indexpath.row];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:deviceModel.sn,@"devicesn", nil];
    [SVProgressHUD showWithStatus:@"正在开锁"];
    [networkTool openDevice2WithDic:dic success:^(id responseData, NSInteger responseCode) {
        [SVProgressHUD dismiss];
        LYPloginModel *model = [LYPloginModel mj_objectWithKeyValues:responseData];
        if (![StringEXtension isBlankString:model.error.msg]) {
            [SVStatusHUD showWithStatus:model.error.msg];
        }else{
            [SVStatusHUD showWithStatus:@"开锁成功"];
        }
    } failure:^(id responseData, NSInteger responseCode) {
        [SVProgressHUD dismiss];
        [SVStatusHUD showWithStatus:@"打开失败，请重试"];
    }];
    
}

-(void)batBtnClick:(UIButton *)sender{
    
    LYPNetWorkTool *networkTool = [[LYPNetWorkTool alloc]init];
    if (self.isBattry) {//换电池
         LYPDevicesModel *deviceModel = self.dataModel.devices[self.indexpath.row];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:deviceModel.sn,@"devicesn", nil];
        [SVProgressHUD showWithStatus:@"正在上传数据"];
        [networkTool inBatteryRecordWithDic:dic success:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            LYPloginModel *model = [LYPloginModel mj_objectWithKeyValues:responseData];
            if (![StringEXtension isBlankString:model.error.msg]) {
                [SVStatusHUD showWithStatus:model.error.msg];
            }else{
                [SVStatusHUD showWithStatus:@"上传成功"];
                [self popoverPresentationController];
            }
        } failure:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            [SVStatusHUD showWithStatus:@"上传失败"];
        }];
        
    }else{//换纸记录
        if ([StringEXtension isBlankString:self.SelectPaperDataModel.paperId]) {
            [SVStatusHUD showWithStatus:@"请选择纸品"];
            return;
        }
         LYPDevicesModel *deviceModel = self.dataModel.devices[self.indexpath.row];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:deviceModel.sn,@"devicesn",self.SelectPaperDataModel.paperId,@"paperId", nil];
        [SVProgressHUD showWithStatus:@"请在上传数据"];
        [networkTool InPaperRecordsWithDic:dic success:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            LYPloginModel *model = [LYPloginModel mj_objectWithKeyValues:responseData];
            if (![StringEXtension isBlankString:model.error.msg]) {
                [SVStatusHUD showWithStatus:model.error.msg];
            }else{
                [SVStatusHUD showWithStatus:@"上传成功"];
                [self popoverPresentationController];
            }
        } failure:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            [SVStatusHUD showWithStatus:@"上传失败"];
        }];
    }
}

#pragma mark --UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.paperM.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"operationVCId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIView *containView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 5, 43)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 43)];
    LYPPaperDataMOdel *paperDataModel = self.paperM.data[indexPath.row];
    titleLabel.text = paperDataModel.title;
    [containView addSubview:titleLabel];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(SCREENWIDTH - 5 - 50, (43- 30)/2, 30, 30)];
    [button addTarget:self action:@selector(selectPaper:) forControlEvents:UIControlEventTouchUpInside];
    if (paperDataModel.isSelect) {
        [button setImage:[UIImage imageNamed:@"ic_selected"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"ic_circle"] forState:UIControlStateNormal];
    }
    button.tag = indexPath.row;
    [containView addSubview:button];
    [cell.contentView addSubview:containView];
//   给底部绘制
    containView.layer.shadowOpacity = 1.0f;
    containView.layer.shadowColor = [UIColor blackColor].CGColor;
    containView.layer.shadowRadius = 7.0f;
    containView.layer.shadowOffset = CGSizeMake(0, 1);
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)selectPaper:(UIButton *)sender{
    
//    取到数组中的模型，取消其他的选择
    for (LYPPaperDataMOdel *paperDataM in self.paperM.data) {
        if (paperDataM.isSelect) {
            paperDataM.isSelect = NO;
        }
    }
    LYPPaperDataMOdel *paperDataM = self.paperM.data[sender.tag];
    paperDataM.isSelect = YES;
//    复制
    self.SelectPaperDataModel = paperDataM;
    
    [self.tablView reloadData];
    
}

@end
