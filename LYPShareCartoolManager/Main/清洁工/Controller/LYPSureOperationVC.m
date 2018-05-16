//
//  LYPSureOperationVC.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/30.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPSureOperationVC.h"
#import "LYPDevicesModel.h"
#import "LYPPaperModel.h"
#import "LYPPaperDataMOdel.h"

@interface LYPSureOperationVC ()

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) LYPDevicesModel *dataModel;

@property (nonatomic, strong) LYPPaperModel *paperM;

@property (nonatomic, strong) SheetView *sheetView;

//上传数据
@property (nonatomic, strong)UIButton *batButton;
//取料锁
@property (nonatomic, strong)UIButton *materBtn;

@property (nonatomic, assign) BOOL isBattry;

@property (nonatomic, strong) LYPPaperDataMOdel *SelectPaperDataModel;

@end

@implementation LYPSureOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SheetView *sheetView = [[SheetView alloc] initWithFrame:CGRectMake(0,64, self.view.frame.size.width, 120)];
    sheetView.dataSource = self;
    sheetView.delegate = self;
    sheetView.sheetHead = @"序号";
    sheetView.titleRowHeight = 60;
    sheetView.titleColWidth = 100;
    [self.view addSubview:sheetView];
    self.sheetView = sheetView;
    
    UIButton *batButton = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREENHEIGHT - 64-60, SCREENWIDTH - 40, 60)];
    batButton.backgroundColor = [UIColor lightGrayColor];
    [batButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    batButton.layer.borderColor = [UIColor blackColor].CGColor;
    batButton.layer.masksToBounds = YES;
//    batButton.layer.borderWidth = 1;
    batButton.layer.cornerRadius = 5;
    [batButton addTarget:self action:@selector(batBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:batButton];
    self.batButton = batButton;
    
    self.materBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, SCREENHEIGHT - 64-60-80, SCREENWIDTH - 40, 60)];
     self.materBtn.backgroundColor = [UIColor lightGrayColor];
    [ self.materBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.materBtn setTitle:@"开取料锁" forState:UIControlStateNormal];
     self.materBtn.layer.masksToBounds = YES;
     self.materBtn.layer.cornerRadius = 5;
    [ self.materBtn addTarget:self action:@selector(materBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.materBtn];
    
    [self setUPData];
}

-(void)setUPData{
    LYPNetWorkTool *netWorkTool = [[LYPNetWorkTool alloc]init];
    if (self.isBattry) {
        [self.batButton setTitle:@"确认换电池成功" forState:UIControlStateNormal];
        //换电池.直接换，然后点击确认换电池
        self.sheetView.hidden = YES;
        //        发送这在打开纸盒的请求
        //    换纸和换电池都是一个接口
        //    拿到当前的行列模型
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.dataModel.sn,@"devicesn", nil];
        [SVProgressHUD showWithStatus:@"正在打开"];
        [netWorkTool openDeviceWithDic:dic success:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            LYPloginModel *model = [LYPloginModel mj_objectWithKeyValues:responseData];
            if (![StringEXtension isBlankString:model.error.msg]) {
                [SVStatusHUD showWithStatus:model.error.msg];
            }else{
                [SVStatusHUD showWithStatus:@"打开成功"];
            }
            
        } failure:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            [SVStatusHUD showWithStatus:@"打开失败"];
        }];
        
    }else{
        self.sheetView.hidden = NO;
        self.titleArr = @[@"纸品名称"];
        [self.batButton setTitle:@"确认换纸成功" forState:UIControlStateNormal];
        //        去纸品列表
        [SVProgressHUD showWithStatus:@"正在请求纸品"];
        [netWorkTool getPaperListWithDic:nil success:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            self.paperM = [LYPPaperModel mj_objectWithKeyValues:responseData];
            if (![StringEXtension isBlankString:self.paperM.error.msg]) {
                [SVStatusHUD showWithStatus:self.paperM.error.msg];
            }else{
                
                [self.sheetView reloadData];
            }
            
        } failure:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            [SVStatusHUD showWithStatus:@"请求失败"];
        }];
        
    }
}

-(void)materBtnClick:(UIButton *)sender{
    
    LYPNetWorkTool *networkTool = [[LYPNetWorkTool alloc]init];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.dataModel.sn,@"devicesn", nil];
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
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.dataModel.sn,@"devicesn", nil];
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
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.dataModel.sn,@"devicesn",self.SelectPaperDataModel.paperId,@"paperId", nil];
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

-(void)itemWithModel:(LYPDevicesModel *)model withTopTitleArr:(NSArray *)titleArr andIndexRow:(NSIndexPath *)indexPath withIndexCol:(NSIndexPath *)indexCol IsBattery:(BOOL)isBattery{
    self.isBattry = isBattery;
    self.dataModel = model;
}
#pragma mark --sheetDelegate
- (NSInteger)sheetView:(SheetView *)sheetView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}
- (NSInteger)sheetView:(SheetView *)sheetView numberOfColsInSection:(NSInteger)section
{
    return self.paperM.data.count;
}
- (NSString *)sheetView:(SheetView *)sheetView cellForContentItemAtIndexRow:(NSIndexPath *)indexRow indexCol:(NSIndexPath *)indexCol
{
    LYPPaperDataMOdel *model = self.paperM.data[indexCol.row];
    
    return model.title;
}

- (NSString *)sheetView:(SheetView *)sheetView cellForLeftColAtIndexPath:(NSIndexPath*)indexPath
{
     NSString *topTitle = self.titleArr[indexPath.row];
    return topTitle;
}
- (NSString *)sheetView:(SheetView *)sheetView cellForTopRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [NSString stringWithFormat:@"%ld", (long)indexPath.row];;
}

- (CGFloat)sheetView:(SheetView *)sheetView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)sheetView:(SheetView *)sheetView widthForColAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (BOOL)sheetView:(SheetView *)sheetView cellWithColorAtIndexRow:(NSIndexPath *)indexRow
{
    return (indexRow.row%2 != 0)?YES:NO;
}

-(void)sheetView:(SheetView *)sheetView didSelectItemAtIndexRow:(NSIndexPath *)indexRow indexCol:(NSIndexPath *)indexCol
{
//    选择了某一个纸品
    self.SelectPaperDataModel = self.paperM.data[indexCol.row];
    
}
@end
