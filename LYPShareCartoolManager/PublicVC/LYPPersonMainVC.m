//
//  LYPPersonMainVC.m
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/18.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "LYPPersonMainVC.h"
#import "LYPPersonHeadView.h"
#import "LYPPersonCycTableViewCell.h"
#import "LYPPersonTableViewCell.h"

@interface LYPPersonMainVC ()<UITableViewDelegate,UITableViewDataSource,LYPPersonCycTableViewCellDelegate>

@property (nonatomic, strong) UITableView *headtableView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *rowDataArr;

@end

@implementation LYPPersonMainVC
-(NSMutableArray *)rowDataArr{
    if(!_rowDataArr){
        _rowDataArr = [NSMutableArray array];
        NSArray *arr = @[@{@"title":@"我的钱包",@"image":@"menu_wallet"},
                         @{@"title":@"我的卡劵",@"image":@"menu_promo"},
                         @{@"title":@"邀请好友",@"image":@"menu_invite"},
                         @{@"title":@"我的贴纸",@"image":@"menu_sticker"}];

        _rowDataArr = [NSMutableArray arrayWithArray:arr];
        
    }
    return _rowDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUPUI];
}
-(void)setUPUI{
    
    self.headtableView = [[UITableView alloc]init];
    self.headtableView.delegate = self;
    self.headtableView.dataSource = self;
    [self.view addSubview:self.headtableView];

    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT - 44, SCREENWIDTH, 44)];
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:lineV];
    UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 1, 60, 44)];
    [setBtn setTitle:@"设置" forState:UIControlStateNormal];
    [setBtn addTarget:self action:@selector(setPersonAction) forControlEvents:UIControlEventTouchUpInside];
    [setBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [bottomView addSubview:setBtn];
    UIButton *guideBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 1, 80, 44)];
    [guideBtn setTitle:@"用户指南" forState:UIControlStateNormal];
    [guideBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [guideBtn addTarget:self action:@selector(personGuideAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:guideBtn];
    [self.view addSubview:bottomView];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.headtableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 220);
    self.tableView.frame = CGRectMake(0, 220, self.view.bounds.size.width, SCREENHEIGHT - 220 - 44);
}

//设置
-(void)setPersonAction{
    
}

//用户指南
-(void)personGuideAction{
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.headtableView){
        return 2;
    }else{
        
        return self.rowDataArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView ==self.headtableView){
        if(indexPath.row == 0){
            LYPPersonHeadView *cell = [LYPPersonHeadView cellWithTableView:tableView];
            return cell;
        }else{
            LYPPersonCycTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CycCell"];
            if(!cell){
                cell = [[[NSBundle mainBundle]loadNibNamed:@"LYPPersonCycTableViewCell" owner:nil options:nil]firstObject];
            }
            cell.delegate = self;
            return cell;
        }
        
    }else{
        
        LYPPersonTableViewCell *cell = [LYPPersonTableViewCell cellWithTableView:tableView];
        cell.dataDic = self.rowDataArr[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.headtableView){
        if(indexPath.row == 0){
            return 100;
        }else{
            return 120;
        }
    }else{
        return 44;
    }
}

#pragma mark LYPPersonCycTableViewCellDelegate
-(void)cycTableViewcell:(LYPPersonCycTableViewCell *)cell withButton:(UIButton *)sender{
    
    
}

@end
