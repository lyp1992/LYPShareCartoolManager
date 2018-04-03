//
//  UIImage+Extention.m
//  老赖微博
//
//  Created by 赖永鹏 on 15/9/23.
//  Copyright © 2015年 赖永鹏. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

+(UIImage *)resizableImage:(NSString *)name{

    UIImage *image=[UIImage imageNamed:name];
    
    UIImage *norImage=[image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];

    return norImage;
}

+(UIImage *)YPdecodeBase64ToImage:(NSString *)encodeData {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:encodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}


@end
