//
//  TopCollectionView.h
//  JoeExcelView
//
//  Created by Joe on 2016/12/9.
//  Copyright © 2016年 QQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopCollectionView;
@protocol TopCollectionViewDelegate <NSObject>

-(void)TopCollectionView:(TopCollectionView*)topView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface TopCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *numArr;

@property (nonatomic, weak) id<TopCollectionViewDelegate>topDelegate;

@end
