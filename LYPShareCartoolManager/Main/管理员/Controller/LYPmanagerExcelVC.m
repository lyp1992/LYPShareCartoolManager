//
//  LYPmanagerExcelVC.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/23.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPmanagerExcelVC.h"
#import "YPPopView.h"
#import "LYPLocationView.h"
#import "LYPDeviceListModel.h"
#import "LYPModifyLocationView.h"

@interface LYPmanagerExcelVC ()

//设备title
@property (nonatomic, strong) NSArray *equipTitleArr;
//场所titleArr
@property (nonatomic, strong) NSArray *placeTitleArr;
//卫生间titleArr
@property (nonatomic, strong) NSArray *toileTitletArr;
//清洁工titleArr
@property (nonatomic, strong) NSArray *gambleTitleArr;
//公司TitleArr
@property (nonatomic, strong) NSArray *companyTitleArr;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) SheetView *sheetView;

@property (nonatomic, assign) NSIndexPath *selectIndexPath;
@property (nonatomic, strong) LYPDeviceListModel *listModle;
@property (nonatomic, strong) YPPopView *popView;

@end

@implementation LYPmanagerExcelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[LYPUserSingle shareUserSingle].managerControlArr addObject:self];
    [self setUPData];
    SheetView *sheetView = [[SheetView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    sheetView.dataSource = self;
    sheetView.delegate = self;
    sheetView.sheetHead = @"序号";
    sheetView.titleRowHeight = 60;
    sheetView.titleColWidth = 100;
    [self.view addSubview:sheetView];
    self.sheetView = sheetView;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changePopViewFrame:) name:@"changePopViewFrame" object:nil];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    //绘制阴影
    self.view.layer.shadowColor = [UIColor colorWithRed:49.0/255.0 green:54/255.0 blue:50/255.0 alpha:1].CGColor;
    self.view.layer.shadowOpacity = 0.7f;
    //阴影的偏移量
    self.view.layer.shadowOffset = CGSizeMake(-5, 0);
    self.sheetView.frame = self.view.bounds;

}
-(void)setUPData{
    
    self.equipTitleArr = @[@"剩余纸量", @"剩余电量", @"异常振动", @"工作状态", @"保洁人员", @"主管负责人", @"仓库负责人"];
    self.placeTitleArr = @[@"场所名称", @"大楼名称", @"地址", @"主管负责人", @"IW区域负责人"];
    self.toileTitletArr =   @[@"场所名称", @"大楼名称", @"楼层", @"区域编号", @"类型", @"厕所数", @"保洁负责人", @"主管负责人",@"智立负责人",@"智立负责人电话"];
    self.gambleTitleArr = @[@"场所名称",@"主管人",@"电话",@"负责区域"];
    self.companyTitleArr = @[@"公司负责人",@"公司区域负责人",@"公司联系方式"];
    
}

-(void)removeView{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
}

-(void)changePopViewFrame:(NSNotification *)notifi{
     [self.popView showInRect:CGRectMake((SCREENWIDTH - 280)/2, (SCREENHEIGHT - 123)/2 -[notifi.userInfo[@"height"] floatValue], 280, 123)];
}
-(void)callPhoneWithNumber:(NSString *)phoneNum{
    UIAlertController *alertVC = [UIAlertController alertNoticeWithTitle:@"是否拨打该负责人" Message:phoneNum sureblock:^{
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNum];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    } cancelblock:^{
        
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}
#pragma mark --sheetDelegate
- (NSInteger)sheetView:(SheetView *)sheetView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}
- (NSInteger)sheetView:(SheetView *)sheetView numberOfColsInSection:(NSInteger)section
{
    NSInteger row = 6;
    
    switch (self.selectIndexPath.row) {
        case 0:
            row = self.listModle.data.count;
            break;
        default:
            row = 6;
            break;
    }
    return row;
}
- (NSString *)sheetView:(SheetView *)sheetView cellForContentItemAtIndexRow:(NSIndexPath *)indexRow indexCol:(NSIndexPath *)indexCol
{
//    只能一行一行的去显示数据
    return [NSString stringWithFormat:@"第%ld行第%ld列", (long)indexRow.row,(long)indexCol.row];
}

- (NSString *)sheetView:(SheetView *)sheetView cellForLeftColAtIndexPath:(NSIndexPath*)indexPath
{
    NSString *topTitle = self.titleArr[indexPath.row];
    return topTitle;
}
- (NSString *)sheetView:(SheetView *)sheetView cellForTopRowAtIndexPath:(NSIndexPath*)indexPath
{
    return [NSString stringWithFormat:@"%ld", (long)indexPath.row];
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
//点击行列
-(void)sheetView:(SheetView *)sheetView didSelectItemAtIndexRow:(NSIndexPath *)indexRow indexCol:(NSIndexPath *)indexCol
{
    NSLog(@"点击 row %ld, col %ld", (long)indexRow.row, (long)indexCol.row);
    switch (self.selectIndexPath.row) {
        case 0://设备
        {
//            点击相关人员弹出联系方式
            if (indexRow.row == 4 || indexRow.row == 5 || indexRow.row == 6) {
                [self callPhoneWithNumber:@"15210959257"];
            }
            break;
        }
        case 1://场所
        {
            //            点击相关人员弹出联系方式
            if (indexRow.row == 3 || indexRow.row == 4 ) {
                [self callPhoneWithNumber:@"15210959257"];
            }
            break;
        }
        default:
            break;
    }
}

//点击顶部
-(void)sheetView:(SheetView *)sheetView didSelectTopItemIndexCol:(NSIndexPath *)indexCol{
    NSLog(@"====%ld",(long)indexCol.row);
    NSLog(@"%@",self.listModle.data);
    switch (self.selectIndexPath.row) {
        case 0:
        {
            LYPLocationView *view = [LYPLocationView aweakFromXib];
            view.model = self.listModle.data[indexCol.row];
            YPPopView *popView = [[YPPopView alloc]initWithContentView:view];
            popView.dimBackground = YES;
            [popView showInRect:CGRectMake((SCREENWIDTH - 280)/2, (SCREENHEIGHT - 197)/2, 280, 197)];
            break;
        }
        default:
            break;
    }
}

-(void)sheetView:(SheetView *)sheetView longTapGestureAtIndexRow:(NSIndexPath *)indexRow indexCol:(NSIndexPath *)indexCol{
     NSLog(@"点击== row %ld, col %ld", (long)indexRow.row, (long)indexCol.row);
    switch (self.selectIndexPath.row ) {
        case 1://场所
        {
            if (indexRow.row == 2) {//弹出框，显示是否需要修改地址
                LYPModifyLocationView *modifyView = [LYPModifyLocationView aweakFromXib];
                self.popView = [[YPPopView alloc]initWithContentView:modifyView];
                self.popView.dimBackground = YES;
                [self.popView showInRect:CGRectMake((SCREENWIDTH - 280)/2, (SCREENHEIGHT - 123)/2, 280, 123)];
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark --protocol
-(void)didSelectToolRow:(NSIndexPath *)indexPath withUnSelect:(BOOL)unSelect
{
    if (unSelect) {
        [self removeView];
        self.titleArr = 0;
        self.selectIndexPath = nil;
        self.listModle = nil;
        return;
    }
    self.selectIndexPath = indexPath;
    //请求数据
    switch (indexPath.row) {
        case 0:
        {//设备
            self.titleArr = self.equipTitleArr;
            //    请求数据
            LYPNetWorkTool *networkTool = [[LYPNetWorkTool alloc]init];
            [SVProgressHUD showWithStatus:@"正在请求数据"];
            [networkTool getEquipmentListWithDic:nil success:^(id responseData, NSInteger responseCode) {
                [SVProgressHUD dismiss];
                self.listModle = [LYPDeviceListModel mj_objectWithKeyValues:responseData];
                if (![StringEXtension isBlankString:self.listModle.error.msg]) {
                    [SVProgressHUD showWithStatus:@"请求数据失败"];
                }else{
                    [self.sheetView reloadData];
                }
            } failure:^(id responseData, NSInteger responseCode) {
                [SVProgressHUD dismiss];
                [SVStatusHUD showWithStatus:@"数据请求失败"];
            }];
            break;
        }
        case 1:
        {//场所
            self.titleArr = self.placeTitleArr;
            break;
        }
        case 2:
        {//卫生间
            self.titleArr = self.toileTitletArr;

            break;
        }
        case 3:
        {//保洁人员
            self.titleArr = self.gambleTitleArr;

            break;
        }
        case 4:
        {//智立行走
            self.titleArr = self.companyTitleArr;

            break;
        }
    }
    [self.sheetView reloadData];
}


@end
