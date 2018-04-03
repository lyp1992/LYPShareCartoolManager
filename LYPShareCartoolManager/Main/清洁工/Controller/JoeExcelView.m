//
//  JoeExcelView.m
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import "JoeExcelView.h"
#import "JContentTableView.h"
#import "TopCollectionView.h"
#import "JContentTableViewCell.h"
#import "JoeExcel.h"
#import "LYPCleanToolView.h"

#import "LYPToolModel.h"
#import "LYPCleanToolCell.h"
#import "YPLeftAndRightButton.h"
#import "LYPDeviceListModel.h"

@interface JoeExcelView ()<TopCollectionViewDelegate,LYPCleanToolViewDelegate>

@property (nonatomic, strong) JContentTableView *jContentTableView;
@property (nonatomic, strong) TopCollectionView *topCollectionView;
@property (nonatomic, strong)NSArray *topNumArr;
@property (nonatomic, strong) UIView *containToolView;

@end


@implementation JoeExcelView
@synthesize jContentTableView;
@synthesize topCollectionView;



#warning -- 如果想在类外面处理ContentTableView和TopCollectionView可以将他们的Delegate和DataSource代理出来 例如JContentTableView中CollectionView的didSelected方法...
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
          self.topNumArr = @[@"设备ID", @"场所", @"大楼", @"楼层", @"类型", @"区域", @"蹲位", @"换纸", @"换电池"];
        
        self.containToolView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, frame.size.width, 45)];
        [self addSubview:self.containToolView];
        UIButton *changePaperBtn = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width/2 -70)/2, 0, 70, 45)];
        [changePaperBtn setTitle:@"换纸" forState:UIControlStateNormal];
        [changePaperBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [changePaperBtn setImage:[UIImage imageNamed:@"ic_circle"] forState:UIControlStateNormal];
        [changePaperBtn addTarget:self action:@selector(changePaperBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.containToolView addSubview:changePaperBtn];
        
        UIButton *changeBattery = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2 +(frame.size.width/2 -80)/2, 0, 80, 50)];
        [changeBattery setTitle:@"换电池" forState:UIControlStateNormal];
        [changeBattery setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [changeBattery setImage:[UIImage imageNamed:@"ic_circle"] forState:UIControlStateNormal];
        [changeBattery addTarget:self action:@selector(changebattery:) forControlEvents:UIControlEventTouchUpInside];
        [self.containToolView addSubview:changeBattery];
        
        //        添加按钮
        UILabel *vNumLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.containToolView.frame), 60, 45)];
        vNumLab.backgroundColor = [UIColor yellowColor];
        vNumLab.textAlignment = NSTextAlignmentCenter;
        vNumLab.text = @"序号";
          [self addSubview:vNumLab];
        
        // 顶部横向序号CollectionView
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        topCollectionView = [[TopCollectionView alloc] initWithFrame:CGRectMake(vNumLab.frame.size.width, self.containToolView.frame.size.height+64, frame.size.width-vNumLab.frame.size.width, 45) collectionViewLayout:collectionViewFlowLayout];
        topCollectionView.showsHorizontalScrollIndicator = NO;
        topCollectionView.numArr = self.topNumArr;
        topCollectionView.topDelegate = self;
        [self addSubview:topCollectionView];
        
        // 添加Observer
        [topCollectionView addObserver:self forKeyPath:TopCollectionViewObserver options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        jContentTableView = [[JContentTableView alloc] initWithFrame:CGRectMake(0, vNumLab.frame.size.height+vNumLab.frame.origin.y, self.frame.size.width, self.frame.size.height-vNumLab.frame.size.height-self.containToolView.frame.size.height - 45-64) style:UITableViewStylePlain];
        jContentTableView.superVC = self.superVC;
        [self addSubview:jContentTableView];
        
        // 添加Observer
        [jContentTableView addObserver:self forKeyPath:JContentTableViewCellCollectionViewObserver options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        UIView *bottmView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 45, self.width, 45)];
        bottmView.backgroundColor = [UIColor whiteColor];
        bottmView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bottmView.layer.borderWidth = 1;
//        批量打开
        UIButton *batchBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.width -130)/2, 2.5, 130, 40)];
        [batchBtn setTitle:@"批量打开纸盒" forState:UIControlStateNormal];
        [batchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [batchBtn addTarget:self action:@selector(batchOpenPaperBox:) forControlEvents:UIControlEventTouchUpInside];
        batchBtn.layer.masksToBounds = YES;
        batchBtn.layer.cornerRadius = 5;
        batchBtn.layer.borderColor = [UIColor blackColor].CGColor;
        batchBtn.layer.borderWidth = 1;
        [bottmView addSubview:batchBtn];
        
        [self addSubview:bottmView];
    }
    return self;
}

-(void)setModel:(id)model
{
    _model = model;
//    传数据
    if ([model isKindOfClass:[LYPDeviceListModel class]]) {
        LYPDeviceListModel *model1 = model;
        jContentTableView.numArr = model1.data;
    }
   
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

// 不做容错处理crash
- (id)valueForUndefinedKey:(NSString *)key{
    return @"TopCollectionViewObserver";
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context{
    
    if ([keyPath isEqualToString:TopCollectionViewObserver]) {
        for (JContentTableViewCell* cell in jContentTableView.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = topCollectionView.contentOffset;
                    
                }
            }
        }
    }
    
    if ([keyPath isEqualToString:JContentTableViewCellCollectionViewObserver]) {
        for (JContentTableViewCell *cell in jContentTableView.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    topCollectionView.contentOffset = collectionView.contentOffset;
                    
                }
            }
        }
    }
}

// 移除Observer
- (void)dealloc{
    [topCollectionView removeObserver:self forKeyPath:TopCollectionViewObserver];
    [jContentTableView removeObserver:self forKeyPath:JContentTableViewCellCollectionViewObserver];
}

#pragma mark --TopCollectionViewDelegate
-(void)TopCollectionView:(TopCollectionView *)topView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"==%@",self.topNumArr);
    
}

@end
