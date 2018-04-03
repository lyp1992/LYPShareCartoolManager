//
//  JContentTableView.m
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import "JContentTableView.h"
#import "JContentTableViewCell.h"
#import "ContentCollectionViewCell.h"
#import "JoeExcel.h"
#import "ContentTableFooter.h"
#import "LYPDataListModel.h"

static NSString *tbIdentify = @"tableViewCellIdentify";
static NSString *clIdentify = @"collectionViewCellIdentify";
@interface JContentTableView ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *parameterArr;
@end

@implementation JContentTableView
@synthesize parameterArr;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate=self;
        self.dataSource=self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"JContentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"JContentCellID"];
        parameterArr = @[@"设备ID", @"场所", @"大楼", @"楼层", @"类型", @"区域", @"蹲位", @"换纸", @"换电池"];
    }
    return self;
}

-(void)setNumArr:(NSArray *)numArr{
    _numArr = numArr;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    JContentTableViewCell *cell = (JContentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:tbIdentify];

    // 在cell.contentView上添加一个UICollectionView控制横向滑动
    if (cell == nil)
    {
        cell = [[JContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tbIdentify];
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        collectionViewFlowLayout.minimumInteritemSpacing = 0;
        collectionViewFlowLayout.minimumLineSpacing = 0;
        [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        UICollectionView *contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(60, 0, self.frame.size.width-60, 60) collectionViewLayout:collectionViewFlowLayout];
        contentCollectionView.showsHorizontalScrollIndicator = NO;
        contentCollectionView.backgroundColor = [UIColor whiteColor];
        contentCollectionView.delegate = self;
        contentCollectionView.dataSource = self;
        [cell.contentView addSubview:contentCollectionView];
        [contentCollectionView registerClass:[ContentCollectionViewCell class] forCellWithReuseIdentifier:clIdentify];
        
    }
    
    cell.leftTextLab.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return parameterArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%@",collectionView.superview);
    ContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:clIdentify forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor cyanColor];
    cell.textLab.text = @"yo";
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    return CGSizeMake(100, 60);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.item == 7) {
        UIAlertController *alertVC = [UIAlertController alertNoticeWithTitle:@"" Message:@"是否进行换纸" sureblock:^{
            
        } cancelblock:^{
            
        }];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    
    }else if(indexPath.item == 8){
        UIAlertController *alertVC = [UIAlertController alertNoticeWithTitle:@"" Message:@"是否进行换电池" sureblock:^{
            
        } cancelblock:^{
            
        }];
       [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        
        if (scrollView.contentOffset.y != 0) {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
            return;
        }
        for (JContentTableViewCell* cell in self.visibleCells) {
            for (UIView *view in cell.contentView.subviews) {
                if ([view isKindOfClass:[UICollectionView class]]) {
                    UICollectionView *collectionView = (UICollectionView *)view;
                    collectionView.contentOffset = scrollView.contentOffset;
                }
            }
            
        }
        [self setValue:[NSValue valueWithCGPoint:scrollView.contentOffset] forKey:JContentTableViewCellCollectionViewObserver];
    }
}

// 不做容错处理crash
- (id)valueForUndefinedKey:(NSString *)key{
    return JContentTableViewCellCollectionViewObserver;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
