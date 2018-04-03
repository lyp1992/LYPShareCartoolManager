//
//  LYPCleanToolView.m
//  LYPShareCartoolManager
//
//  Created by laiyp on 2018/3/21.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPCleanToolView.h"
#import "LYPCleanToolCell.h"
#import "LYPToolModel.h"


@interface LYPCleanToolView () <UICollectionViewDelegate, UICollectionViewDataSource,LYPCleanToolCellDelegate>
@property (nonatomic, assign) NSInteger lastIndexRow;

@end
static NSString *toolClIdentify = @"LYPCleanToolCellID";
@implementation LYPCleanToolView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {

        NSLog(@"%@",NSStringFromCGRect(frame));
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[LYPCleanToolCell class] forCellWithReuseIdentifier:@"LYPCleanToolCellID"];
        self.allowsMultipleSelection = NO;
        self.lastIndexRow = 0;
    }
    return self;
}

#pragma mark --collectionViewDataSource&&collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.numArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LYPCleanToolCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LYPCleanToolCellID" forIndexPath:indexPath];
    LYPToolModel *toolModel = self.numArr[indexPath.row];
    cell.indexPath = indexPath;
    cell.toolModel = toolModel;
    cell.delegate = self;
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath{
    
    return CGSizeMake(120, 50);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    
}

#pragma mark LYPCleanToolCellDelegate;
-(void)cleanToolView:(LYPCleanToolCell *)view selectButton:(UIButton *)sender withIndexPath:(NSIndexPath *)indexPath{
    
    if (self.numArr.count==0) {
        return;
    }
    LYPToolModel *toolModel = self.numArr[indexPath.row];
    if (self.lastIndexRow != indexPath.row) {
        for (LYPToolModel *model in self.numArr) {
            if (model.isSelect == YES) {
                model.isSelect = NO;
                [self reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:self.lastIndexRow inSection:0]]];
            }
        }
    }
    self.lastIndexRow = indexPath.row;
    if (toolModel.isSelect) {
        toolModel.isSelect = NO;
        [self reloadItemsAtIndexPaths:@[indexPath]];
        for (id<LYPManageCleanToolProtocol> VC in [LYPUserSingle shareUserSingle].managerControlArr) {
            [VC didSelectToolRow:indexPath withUnSelect:YES];
        }
    }else{
        toolModel.isSelect = YES;
        [self reloadItemsAtIndexPaths:@[indexPath]];
        for (id<LYPManageCleanToolProtocol> VC in [LYPUserSingle shareUserSingle].managerControlArr) {
            [VC didSelectToolRow:indexPath withUnSelect:NO];
        }
    }
   
}

@end;
