//
//  TopCollectionView.m
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import "TopCollectionView.h"
#import "TopCollectionViewCell.h"
#import "JoeExcel.h"

static NSString *topClIdentify = @"topCollectionViewCellIdentify";

@interface TopCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@end

@implementation TopCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TopCollectionViewCell class] forCellWithReuseIdentifier:topClIdentify];
     
    }
    return self;
}

-(void)setNumArr:(NSArray *)numArr{
    _numArr = numArr;
    [self reloadData];
}

- (id)valueForUndefinedKey:(NSString *)key{
    return TopCollectionViewObserver;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

#pragma mark --collectionViewDataSource&&collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:topClIdentify forIndexPath:indexPath];
    cell.topTextLab.text = self.numArr[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    
    return CGSizeMake(100, 45);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_topDelegate respondsToSelector:@selector(TopCollectionView:didSelectItemAtIndexPath:)]) {
        [self.topDelegate TopCollectionView:self didSelectItemAtIndexPath:indexPath];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setValue:[NSValue valueWithCGPoint:scrollView.contentOffset] forKey:TopCollectionViewObserver];
}

@end
