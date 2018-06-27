//
//  LYPLoginVC.m
//  YPSharingCarton
//
//  Created by laiyp on 2018/3/1.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPLoginVC.h"
#import "LYPNetWorkTool.h"
#import "LYPRegisterVC.h"
#import "LYPSavePList.h"
#import "LYPloginModel.h"
#import "LYPUserSingle.h"
#import "LYPRegisterVC.h"

#import "LYPCleanMainVC.h"
#import "LYPManagerVC.h"
#import "LYPCleanHomePageVC.h"

@interface LYPLoginVC ()<UITextFieldDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;

@property (weak, nonatomic) IBOutlet UITextField *passWTextF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textPhoneLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passWViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginButtonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginButtonConstainHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descripLabelConstainHeight;

@end

@implementation LYPLoginVC
- (IBAction)dismissVC:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginButton:(id)sender {
    

    LYPNetWorkTool *longinTool = [[LYPNetWorkTool alloc]init];
    if ([StringEXtension isBlankString:self.phoneTextF.text] || [StringEXtension isBlankString:self.passWTextF.text]) {
        [SVStatusHUD showWithStatus:@"请输入正确的信息"];
        return;
    }
    
    if ([StringEXtension isBlankString:[LYPUserSingle shareUserSingle].deviceToken]) {
        [SVStatusHUD showWithStatus:@"服务器繁忙，稍后重试"];
        return;
    }
    
      NSString *passW = [StringEXtension sha1:self.passWTextF.text];
    NSDictionary *dic = @{@"mobile":self.phoneTextF.text,@"password":passW,@"deviceToken":[LYPUserSingle shareUserSingle].deviceToken,@"ios":@(1)};
    [SVProgressHUD showWithStatus:@"正在登陆"];
        [longinTool userLoginWithUserDic:dic Success:^(id responseData, NSInteger responseCode) {
            NSLog(@"login=%@",responseData);
            [SVProgressHUD dismiss];
            LYPloginModel *model = [LYPloginModel mj_objectWithKeyValues:responseData];
            if (![StringEXtension isBlankString:model.error.msg]) {
                [SVStatusHUD showWithStatus:model.error.msg];
            }else{

                if (![StringEXtension isBlankString:model.data.token]) {
                    //                写入本地
                    [LYPSavePList saveTokenPlistWith:model.data.token];
                    [LYPSavePList savePassWAndUser:dic];
                }
//                跳转到主页面
//                1.如果是管理员
//                LYPManagerVC *managerVc = [[LYPManagerVC alloc]init];
//                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:managerVc];
//                [self presentViewController:nav animated:YES completion:nil];
//                2.如果是清洁工
                LYPCleanHomePageVC *cleanVc = [[LYPCleanHomePageVC alloc]init];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:cleanVc];
                [UIApplication sharedApplication].keyWindow.rootViewController = nav;

            }
        } failue:^(id responseData, NSInteger responseCode) {
            [SVProgressHUD dismiss];
            NSLog(@"errlogin=%@",responseData);
        }];

}
- (IBAction)loginQQ:(id)sender {
    
}
- (IBAction)loginWechat:(id)sender {
    
}
- (IBAction)resetPassWButton:(id)sender {
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"LYPLoginVC" bundle:nil];
    LYPRegisterVC *registerVC = [board instantiateViewControllerWithIdentifier:@"LYPRegisterVC"];
    registerVC.isregister = NO;
    [self presentViewController:registerVC animated:YES completion:nil];
}
- (IBAction)registerButton:(id)sender {
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"LYPLoginVC" bundle:nil];
    LYPRegisterVC *registerVC = [board instantiateViewControllerWithIdentifier:@"LYPRegisterVC"];
    registerVC.isregister = YES;
    [self presentViewController:registerVC animated:YES completion:nil];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
  
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
  self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT-20);
  
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    CGFloat witdh = 345 *SCREENWIDTH/375;
    self.phoneLabelWidth.constant = witdh;
     self.textPhoneLabelWidth.constant = witdh;
     self.phoneViewWidth.constant = witdh;
     self.passWViewWidth.constant = witdh;
     self.loginButtonWidth.constant = witdh;
    
    self.loginButtonConstainHeight.constant = 80 *SCREENHEIGHT/667 - 10;
    self.descripLabelConstainHeight.constant = 35 * SCREENHEIGHT/667;
    
}

-(void)keyboardWillShow:(NSNotification*)notification
{
   
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    // 在这里调整UI位置
    CGPoint pt = [_loginButton convertPoint:CGPointMake(0, 0) toView:[UIApplication sharedApplication].keyWindow];
    float txDistanceToBottom = SCREENHEIGHT - pt.y - _loginButton.frame.size.height;   // 距离底部多远
    if( txDistanceToBottom >= kbSize.height )  // 键盘不会覆盖
        return;
    
    self.scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, _scrollView.contentSize.height + kbSize.height); //原始滑动距离增加键盘高度
    
    // 差多少
    float offsetY = txDistanceToBottom - kbSize.height - 40;  // 补一些给各种输入法
    [_scrollView setContentOffset:CGPointMake(0, _scrollView.contentOffset.y - offsetY) animated:YES];
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    
    CGFloat animationDurationValue = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:animationDurationValue animations:^{
        
        self.scrollView.contentSize = CGSizeMake(SCREENWIDTH, 0);
    }];
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

@end
