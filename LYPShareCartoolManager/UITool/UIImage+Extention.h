//
//  UIImage+Extention.h
//  老赖微博
//
//  Created by 赖永鹏 on 15/9/23.
//  Copyright © 2015年 赖永鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)
+(UIImage *)resizableImage:(NSString *)image;

+(UIImage *)YPdecodeBase64ToImage:(NSString *)encodeData;
@end
