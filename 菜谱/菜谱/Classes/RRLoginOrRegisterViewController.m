//
//  RRLoginOrRegisterViewController.m
//  百思不得姐
//
//  Created by 丁瑞瑞 on 30/1/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRLoginOrRegisterViewController.h"
#import "EaseMob.h"
#import "RRTextField.h"
#import <SVProgressHUD.h>
@interface RRLoginOrRegisterViewController ()
@property (weak, nonatomic) IBOutlet RRTextField *pwdText;
@property (weak, nonatomic) IBOutlet RRTextField *accountText;
@property (weak, nonatomic) IBOutlet UIView *Login;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLeading;
@property (weak, nonatomic) IBOutlet UIButton *loginOrRegisterBtn;

@end

@implementation RRLoginOrRegisterViewController
SingleM(RRLoginOrRegisterViewController);
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//关闭按钮
- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//登陆按钮
- (IBAction)loginClick:(UIButton *)sender {
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.accountText.text password:self.pwdText.text completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
            // 设置自动登录
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:@"1" forKey:@"isLogin"];
            
            [self dismissViewControllerAnimated:YES completion:nil];
//            self.accountText.text = nil;
//            self.pwdText.text = nil;
        }else{
            NSLog(@"%@---%@",error,loginInfo);
            
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
        }
    } onQueue:nil];
}
//注册按钮
- (IBAction)registerClick:(UIButton *)sender {
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.accountText.text password:self.pwdText.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            NSString *accountT = self.accountText.text;
            [SVProgressHUD showSuccessWithStatus:@"注册成功！"];
            self.loginOrRegisterBtn.selected = NO;
            self.leftLeading.constant = 0;
            
//            self.accountText.text = nil;
//            self.pwdText.text = nil;
            
            [UIView animateWithDuration:0.25 animations:^{
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }else{
            NSLog(@"%@",error);
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
        }
    } onQueue:nil];
    
}
//登陆或注册
- (IBAction)loginOrRegisterClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self.loginOrRegisterBtn.titleLabel.text isEqualToString:@"注册账号"]) {
        self.loginOrRegisterBtn.selected = YES;
        self.leftLeading.constant = -[UIScreen mainScreen].bounds.size.width;
    }else if ([self.loginOrRegisterBtn.titleLabel.text isEqualToString:@"已有账号"]){
        self.loginOrRegisterBtn.selected = NO;
        self.leftLeading.constant = 0;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
//设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//点击空白处关闭键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
