//
//  LYPDataListModel.h
//  YPSharingCarton
//
//  Created by laiyp on 2018/3/28.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYPDataListModel : NSObject

@property (nonatomic, assign) int deviceId;
@property (nonatomic, copy) NSString *sn;
@property (nonatomic, copy) NSString *build;
@property (nonatomic, assign) int floor;
@property (nonatomic, copy) NSString *toiletId;
@property (nonatomic, copy) NSString *toiletType;
@property (nonatomic, copy) NSString *seatId;
@property (nonatomic, copy) NSString *lon;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *paper;
@property (nonatomic, copy) NSString *battery;
@property (nonatomic, assign) int online;

@end
