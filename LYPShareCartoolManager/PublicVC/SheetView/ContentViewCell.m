//
//  ContentViewCell.m
//  SheetViewDemo
//
//  Created by Mengmin Duan on 2017/7/20.
//  Copyright © 2017年 Mengmin Duan. All rights reserved.
//

#import "ContentViewCell.h"
#define sheetViewBackColor [UIColor colorWithRed:224/255.0 green:236/255.0 blue:250/255.0 alpha:1.0]
#define sheetViewTopBackColor [UIColor colorWithRed:111/255.0 green:153/255.0 blue:204/255.0 alpha:1.0]
@interface ContentViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@end
@implementation ContentViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.cellCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        self.cellCollectionView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            self.cellCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        } else {
            // Fallback on earlier versions
        }

        self.cellCollectionView.backgroundColor = sheetViewBackColor;
        self.cellCollectionView.layer.borderColor = sheetViewBackColor.CGColor;
        self.cellCollectionView.layer.borderWidth = 1.0f;
        [self.cellCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"inner.cell"];
        self.cellCollectionView.dataSource = self;
        self.cellCollectionView.delegate = self;
        self.cellCollectionView.bounces = NO;
        
        [self.contentView addSubview:self.cellCollectionView];
    }
    
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.contentViewCellDidScrollBlock) {
        self.contentViewCellDidScrollBlock(scrollView);
    }
}


#pragma mark -- UICollectionViewDelegate && UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numberOfItemsBlock(section);
}

- (CGSize)collectionView:(UICollectionView *)uiCollectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.sizeForItemBlock(collectionViewLayout, indexPath);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *innerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"inner.cell" forIndexPath:indexPath];
    if (innerCell) {
        for (UIView *view in innerCell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    innerCell.layer.borderColor = sheetViewBackColor.CGColor;
    innerCell.layer.borderWidth = 1;
    
    BOOL hasColor = NO;
    if (self.cellWithColorBlock) hasColor = self.cellWithColorBlock(indexPath);
//    innerCell.backgroundColor = hasColor?[UIColor colorWithRed:(0xf0 / 255.0)green:(0xf0 / 255.0)blue:(0xf0 / 255.0)alpha:1]:[UIColor whiteColor];
    innerCell.backgroundColor = [UIColor whiteColor];
    CGFloat width = self.sizeForItemBlock(nil, indexPath).width;
    CGFloat height = self.sizeForItemBlock(nil, indexPath).height;
    CGRect rect = CGRectMake(0, 0, width, height);
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
  
    NSString *deviceIDStr = self.cellForItemBlock(indexPath);
    if (indexPath.row == 0) {
         NSArray *arr = [deviceIDStr componentsSeparatedByString:@"+"];
        label.text = [NSString stringWithFormat:@"%@",arr[0]];
    }else{
        label.text = deviceIDStr;
    }
   
    label.textAlignment = NSTextAlignmentCenter;
    [innerCell.contentView addSubview:label];
    label.adjustsFontSizeToFitWidth = YES;
    label.numberOfLines = 0;
    
    if (indexPath.row == 4 || indexPath.row == 5) {
        CGFloat cellTextF = [self.cellForItemBlock(indexPath) floatValue];
        BOOL police = NO;
        if (indexPath.row == 4 && !(cellTextF>7)) {
            police = YES;
        }else if(indexPath.row == 5 && !(cellTextF>20)){
            police = YES;
        }
        if (police) {
            label.textColor = [UIColor redColor];
        }else{
            label.textColor = [UIColor blackColor];
        }
    }else if (indexPath.row == 0){
        NSArray *arr = [deviceIDStr componentsSeparatedByString:@"+"];
        if (arr.count > 1) {
            CGFloat rowf = [arr[1] floatValue];
            if (rowf == 1) {
                label.textColor = [UIColor redColor];
            }else{
                label.textColor = [UIColor blackColor];
            }
        }
    }else{
        label.textColor = [UIColor blackColor];
    }
    
    return innerCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellDidSelectBlock) {
        self.cellDidSelectBlock(indexPath);
    }
}



@end
