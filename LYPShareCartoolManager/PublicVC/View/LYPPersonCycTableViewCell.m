//
//  LYPPersonCycTableViewCell.m
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/20.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import "LYPPersonCycTableViewCell.h"

@implementation LYPPersonCycTableViewCell

- (IBAction)cycAchivementAction:(id)sender {
    if([_delegate respondsToSelector:@selector(cycTableViewcell:withButton:)]){
        [self.delegate cycTableViewcell:self withButton:sender];
    }
}

@end
