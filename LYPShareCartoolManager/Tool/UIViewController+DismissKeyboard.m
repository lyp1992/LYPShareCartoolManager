//
//  UIViewController+DismissKeyboard.m
//  LYPEaseMob
//
//  Created by 赖永鹏 on 16/4/13.
//  Copyright © 2016年 赖永鹏. All rights reserved.
//

#import "UIViewController+DismissKeyboard.h"



@implementation UIViewController (DismissKeyboard)

-(void)setupForDismissKeyboard{

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakself = self;
    
    NSOperationQueue *mainQuene = [NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQuene usingBlock:^(NSNotification * _Nonnull note) {
        
        [weakself.view addGestureRecognizer:singerTap];
    }];
    
    [nc addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQuene usingBlock:^(NSNotification * _Nonnull note) {
        
        [weakself.view removeGestureRecognizer:singerTap];
    }];
    

}

-(void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer{
    
//    此方法调用将self.view 的所有subView 的first response 都resign掉
    [self.view endEditing:YES];
    
}

@end
