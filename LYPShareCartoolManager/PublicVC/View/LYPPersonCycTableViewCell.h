//
//  LYPPersonCycTableViewCell.h
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/20.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYPPersonCycTableViewCell;
@protocol LYPPersonCycTableViewCellDelegate<NSObject>

-(void)cycTableViewcell:(LYPPersonCycTableViewCell *)cell withButton:(UIButton *)sender;

@end

@interface LYPPersonCycTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shengshiLabel;

@property (nonatomic, weak)id<LYPPersonCycTableViewCellDelegate>delegate;

@end
