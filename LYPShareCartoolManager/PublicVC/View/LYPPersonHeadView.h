//
//  LYPPersonHeadView.h
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/20.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPPersonHeadView : UITableViewCell

@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *iphoneLabel;
@property (nonatomic, strong) UIButton *memberButton;
@property (nonatomic, strong) UIButton *creditButton;

+(LYPPersonHeadView*)cellWithTableView:(UITableView*)tableView;


@end
