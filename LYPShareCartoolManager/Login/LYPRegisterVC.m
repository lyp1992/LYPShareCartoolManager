//
//  LYPRegisterVC.m
//  YPSharingCarton
//
//  Created by laiyp on 2018/3/2.
//  Copyright © 2018年 laiyongpeng. All rights reserved.
//

#import "LYPRegisterVC.h"
#import "LYPNetWorkTool.h"
#import "LYPloginModel.h"
#import "LYPSavePList.h"

#define timeOut 60

@interface LYPRegisterVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextF;
@property (weak, nonatomic) IBOutlet UITextField *passWTextF;
@property (weak, nonatomic) IBOutlet UITextField *vercodeTextF;
@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *dismssButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textPhoneLabelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passWViewWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginButtonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginButtonConstainHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vericodeContainWitdh;


@end

@implementation LYPRegisterVC
{
    
    dispatch_source_t _timer;
    
}
- (IBAction)getCodeClick:(id)sender {
    if ([StringEXtension isBlankString:self.phoneTextF.text]) {
        [SVStatusHUD showWithStatus:@"请填写手机号码"];
        return;
    }else{
        
        LYPNetWorkTool *tool = [[LYPNetWorkTool alloc]init];
        
        int ctype = self.isregister ? 1:2;
       
            NSDictionary *parames = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextF.text,@"mobile",@(ctype),@"ctype", nil];
            [tool getVerificationCodeWithDic:parames success:^(id responseData, NSInteger responseCode) {
                LYPloginModel *model = [LYPloginModel mj_objectWithKeyValues:responseData];
                if (![StringEXtension isBlankString:model.error.msg]) {
                    [SVStatusHUD showWithStatus:@"获取验证码失败"];
                     dispatch_resume(_timer);
                }
            } failure:^(id responseData, NSInteger responseCode) {
                [SVStatusHUD showWithStatus:@"获取验证码失败"];
                 dispatch_resume(_timer);
            }];

    __block int timeout = timeOut; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
        
                self.timeLabel.hidden = YES;
                self.getCodeButton.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 61;
            //                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                self.timeLabel.hidden = NO;
                self.timeLabel.backgroundColor = [UIColor lightGrayColor];
                self.getCodeButton.userInteractionEnabled = NO;
                self.timeLabel.text = [NSString stringWithFormat:@"%.2ds重新获取",seconds];
                
                self.timeLabel.textColor = [UIColor whiteColor];
                self.timeLabel.textAlignment = NSTextAlignmentCenter;
                self.timeLabel.font = [UIFont systemFontOfSize:14];
                self.timeLabel.layer.masksToBounds = YES;
                self.timeLabel.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
        
    }
    
}

- (IBAction)registerButton:(id)sender {
    if ([StringEXtension isBlankString:self.phoneTextF.text] || [StringEXtension isBlankString:self.passWTextF.text] || [StringEXtension isBlankString:self.vercodeTextF.text] ) {
        [SVStatusHUD showWithStatus:@"请输入正确的信息"];
    }else{
        LYPNetWorkTool *longinTool = [[LYPNetWorkTool alloc]init];
        NSString *passW = [StringEXtension sha1:self.passWTextF.text];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneTextF.text,@"mobile",self.vercodeTextF.text,@"code",passW,@"password", nil];
            [SVProgressHUD showWithStatus:@"正在重置"];
            [longinTool resetPasswordWithDic:dic success:^(id responseData, NSInteger responseCode) {
                [SVProgressHUD dismiss];
                LYPloginModel *model = [LYPloginModel mj_objectWithKeyValues:responseData];
                if (![StringEXtension isBlankString:model.error.msg]) {
                    [SVStatusHUD showWithStatus:model.error.msg];
                }else{
                    [SVStatusHUD showWithStatus:@"重置成功"];
//                    先读取本地的文件
                    NSDictionary *userDic = [LYPSavePList readUserInfo];
                    if (userDic) {
                        NSString *passW = userDic[@"password"];
                        NSString *mobile = self.phoneTextF.text;
                        NSString *deviceToken =userDic[@"deviceToken"];
                        int ios = [userDic[@"ios"] intValue];
                        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:passW,@"password",mobile,@"mobile",deviceToken,@"deviceToken",@"ios",@(ios), nil];
//                        保存
                        [LYPSavePList savePassWAndUser:dic];
                    }

                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            } failure:^(id responseData, NSInteger responseCode) {
                [SVProgressHUD dismiss];
                [SVStatusHUD showWithStatus:@"重置失败"];
            }];
        }

    
}
- (IBAction)dismissClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (!self.isregister) {
        [self.registerButton setTitle:@"重置密码" forState:UIControlStateNormal];
    }
    self.scrollview.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT-20);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)updateViewConstraints{
    [super updateViewConstraints];
    
    CGFloat witdh = 345 *SCREENWIDTH/375;
    self.phoneLabelWidth.constant = witdh;
    self.textPhoneLabelWidth.constant = witdh;
    self.phoneViewWidth.constant = witdh;
    self.passWViewWidth.constant = witdh;
    self.loginButtonWidth.constant = witdh;
    
    self.loginButtonConstainHeight.constant = 85 *SCREENHEIGHT/667 -10;
    self.vericodeContainWitdh.constant = witdh;
    
}

-(void)keyboardWillShow:(NSNotification*)notification
{
    
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    // 在这里调整UI位置
    CGPoint pt = [_registerButton convertPoint:CGPointMake(0, 0) toView:[UIApplication sharedApplication].keyWindow];
    float txDistanceToBottom = SCREENHEIGHT - pt.y - _registerButton.frame.size.height;   // 距离底部多远
    if( txDistanceToBottom >= kbSize.height )  // 键盘不会覆盖
        return;
    
    self.scrollview.contentSize = CGSizeMake(_scrollview.contentSize.width, _scrollview.contentSize.height + kbSize.height); //原始滑动距离增加键盘高度
    
    // 差多少
    float offsetY = txDistanceToBottom - kbSize.height - 40;  // 补一些给各种输入法
    [_scrollview setContentOffset:CGPointMake(0, _scrollview.contentOffset.y - offsetY) animated:YES];
}

-(void)keyboardWillHide:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    //    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat animationDurationValue = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:animationDurationValue animations:^{
        
        self.scrollview.contentSize = CGSizeMake(SCREENWIDTH, 0);
    }];
}

@end
