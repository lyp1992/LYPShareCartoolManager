//
//  LYPPersonTableViewCell.h
//  YPSharingCarton
//
//  Created by laiyp on 2017/12/20.
//  Copyright © 2017年 laiyongpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYPPersonTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *menuImageView;
@property (strong, nonatomic) UILabel *eventlabel;

@property (strong, nonatomic) UILabel *menuLabel;

@property (nonatomic, strong) NSDictionary *dataDic;

+(LYPPersonTableViewCell *)cellWithTableView:(UITableView *)tableView;

@end
