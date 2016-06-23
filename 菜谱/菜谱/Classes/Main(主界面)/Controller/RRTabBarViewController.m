//
//  RRTabBarViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRTabBarViewController.h"
#import "RRHomeViewController.h"
#import "RRDiscoverViewController.h"
#import "RRMenuViewController.h"
#import "RRMeViewController.h"
#import "RRNavViewController.h"
#import "RRTabBar.h"
#import "RRLoginOrRegisterViewController.h"
#import "SliderViewController.h"
#import <WYPopoverController.h>
#import "RRRBbtn.h"
#import "RRTransition.h"
@interface RRTabBarViewController ()
//@property (nonatomic,strong) SliderViewController *slider;
@property (nonatomic,strong) RRMeViewController *presentVC;
@property (nonatomic,strong) WYPopoverController *popoverController;
/** tabBar*/
@property (nonatomic,strong) RRTabBar *tab;
@end

@implementation RRTabBarViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *isLogin = [user objectForKey:@"isLogin"];
    if ([isLogin isEqualToString:@"1"]) {
        
        self.tab.publishBtn.enabled = NO;
        
    }else{
        self.tab.publishBtn.enabled = YES;
    }
    
}
- (RRTabBar *)tab
{
    if (!_tab) {
        _tab = [[RRTabBar alloc] init];
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    添加子控制器
    [self addChildVC];
//    设置tabBar
    [self setTab];
}
#pragma mark - 设置tabBar
- (void)setTab{
    [self setValue:self.tab forKeyPath:@"tabBar"];
    self.tab.block = ^(RRRBbtn *btn){
        
        RRMeViewController *sec = [[RRMeViewController alloc] init];
        RRTransition *rrTrans = [[RRTransition alloc]init];
        sec.transitioningDelegate = rrTrans;
        sec.modalPresentationStyle = UIModalPresentationCustom;
        rrTrans.rr_frame = CGRectMake(200, -35, 200, screenH + 35);
        rrTrans.isTabBar = 0;
        [self presentViewController:sec animated:YES completion:nil];        
    };
    
}
#pragma mark - 添加子控制器
- (void)addChildVC{

//    添加首页
    RRHomeViewController *homeVC = [[RRHomeViewController alloc] init];
    [self navAddRootView:homeVC withTitle:@"首页"];
//    添加发现
    RRDiscoverViewController *disVC = [[RRDiscoverViewController alloc] init];
    [self navAddRootView:disVC withTitle:@"发现"];


//    添加订单
    RRMenuViewController *menuVC = [[RRMenuViewController alloc] init];
    [self navAddRootView:menuVC withTitle:@"订单"];
//    添加我
//    RRMeViewController *meVC = [[RRMeViewController alloc] init];
//    [self navAddRootView:meVC withTitle:@"我"];
}
#pragma mark - 设置导航栏
- (void)navAddRootView:(UIViewController *)vc withTitle:(NSString *)title{
    
    
    RRNavViewController *nav = [[RRNavViewController alloc] initWithRootViewController:vc];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.navigationItem.title = title;
    [self addChildViewController:nav];
}

@end
