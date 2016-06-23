//
//  RRChooseTableViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChooseTableViewController.h"
#import <AFHTTPSessionManager.h>
#import "RRChooseItem.h"
#import <AFNetworking/AFNetworking.h>
#import "RRChooseCell.h"
#import "RRRefreshFooter.h"
#import "RRRefreshHeader.h"
#import "NSString+RRString.h"
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD.h>
#import "RRHeaderView.h"
#import "UIImage+Image.h"
#import "UIView+RRLoad.h"
#import "RRImageItem.h"
#import "RRPicTableViewController.h"
#import <SDWebImage/SDImageCache.h>
#import "RRWebViewController.h"
#import "RRChooseDetailController.h"
@interface RRChooseTableViewController ()
/** 创建任务管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** 用来存储模型*/
@property (nonatomic,strong) NSMutableArray *arr;
/** 用来储存轮播图*/
@property (nonatomic,strong) NSMutableArray *arrImage;
/** index*/
@property (nonatomic,assign) int index;
/** 轮播*/
@property (nonatomic,strong) RRHeaderView *rrView;
@property(nonatomic,assign)CGFloat historyY;
@end

@implementation RRChooseTableViewController
- (NSMutableArray *)arr
{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
NSString *CellID = @"CellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(navH + titleViewH, 0, 0, 0);
    [self setTable];
    //    设置刷新
    [self setRefresh];

}
- (void)setTable{
    //    self.navigationController.navigationBar.alpha = 1;
    //    注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRChooseCell class]) bundle:nil] forCellReuseIdentifier:CellID];
    self.tableView.estimatedRowHeight = 300;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //    设置headView
    //    self.tableView.tableHeaderView = [RRHeaderView loadWithXib];
    RRHeaderView *rrView = [RRHeaderView loadWithXib];
    
    self.tableView.tableHeaderView = rrView;
    //    block回调
    
    rrView.headViewBlock = ^(NSString *value,NSString *value2){
        
        //        RRLog(@"%@",value);
        //        点击轮播图跳转页面
        RRPicTableViewController *picVC = [[RRPicTableViewController alloc] init];
        RRWebViewController *webVC = [[RRWebViewController alloc] init];
        picVC.value = value;
        NSLog(@"%@",value);
        if ([value2 hasPrefix:@"http://"]) {
            webVC.web = value2;
            [self.navigationController pushViewController:webVC animated:YES];
        }else{
            picVC.des = value2;
            [self.navigationController pushViewController:picVC animated:YES];
        }
        
        //        picVC.blockValue = ^(NSString *value){
        //            [self.navigationController pushViewController:[[RRWebViewController alloc] init]  animated:YES];
        //        };
        
    };
    
    self.rrView = rrView;

}

#pragma mark - 设置刷新
- (void)setRefresh{
    self.tableView.header = [RRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMessage)];
    [self.tableView.header beginRefreshing];
    self.tableView.footer = [RRRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMessage)];
}
//实现头部刷新方法
- (void)loadNewMessage{
//    先取消前一个刷新任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    设置参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    dict[@"version"] = @(3.4);
    [self.manager POST:@"http://api.yinshijia.com/mobile/apiv2/index/choice/1" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        获取模型
        NSDictionary *dictM = responseObject[@"data"];
//        获取轮播图片模型
        self.arrImage = [RRImageItem mj_objectArrayWithKeyValuesArray:dictM[@"banner"]];

        self.rrView.urlArrM = self.arrImage;
//        获取cell模型
        self.arr = [RRChooseItem mj_objectArrayWithKeyValuesArray:dictM[@"dinnerList"]];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RRLog(@"%@",error);
        [self.tableView.header endRefreshing];
    }];
    self.index = 2;
}

//实现尾部刷新
- (void)loadMoreMessage{
//    先取消前一个刷新任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //    设置参数
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"version"] = @(3.4);
    
    NSString *str = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/apiv2/index/choiceDinner/1/%zd/10",self.index];
//    RRLog(@"%d",self.index);
    [self.manager POST:str parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [responseObject writeToFile:@"/Users/Rochester/Desktop/ruit.plist" atomically:YES];
        //        获取模型
        
        NSArray *arrM = [RRChooseItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

        
        
        if (arrM.count > 0) {
            [self.arr addObjectsFromArray:arrM];
            [self.tableView reloadData];
            self.index++;
        }else{
            [SVProgressHUD showInfoWithStatus:@"拉什么拉,后面没有了!!!"];
        }
        
        [self.tableView.footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RRLog(@"%@",error);
        [self.tableView.footer endRefreshing];
    }];
    
    
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RRChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    cell.chooseItem = self.arr[indexPath.row];
    return cell;
}

#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RRLog(@"%zd",indexPath.row);
    RRChooseDetailController *chooesDetailVC = [[RRChooseDetailController alloc] init];
    
    RRChooseItem *chooseItem = self.arr[indexPath.row];
    if (chooseItem.dinnerType == 1) {
        chooesDetailVC.dinnerNum = chooseItem.dinnerId;
        chooesDetailVC.type = 1;
    }else{
        chooesDetailVC.dinnerNum = chooseItem.themeDinnerId;
        chooesDetailVC.type = 2;
    }
//    chooesDetailVC.dinnerId = ^(NSString *value){
//
//        
//    };
    [self.navigationController pushViewController:chooesDetailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [[SDImageCache sharedImageCache] clearMemory];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 1;
    // 获取导航条的颜色
    UIColor *navColor = [UIColor colorWithWhite:1 alpha:0.99];
    
    // 设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
}
//设置滑动的判定范围,显示隐藏tabBar
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (_historyY+20<targetContentOffset->y)
    {
        [self setTabBarHidden:YES];
    }
    else if(_historyY-20>targetContentOffset->y)
    {
        
        [self setTabBarHidden:NO];
    }
    _historyY=targetContentOffset->y;
}
//隐藏显示tabbar
- (void)setTabBarHidden:(BOOL)hidden
{
    UIView *tab = self.tabBarController.view;
    CGRect  tabRect=self.tabBarController.tabBar.frame;
    if ([tab.subviews count] < 2) {
        return;
    }
    
    UIView *view;
    if ([[tab.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        view = [tab.subviews objectAtIndex:1];
    } else {
        view = [tab.subviews objectAtIndex:0];
    }
    
    if (hidden) {
        view.frame = tab.bounds;
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    } else {
        view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
        tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    }
    
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame=tabRect;
    }completion:^(BOOL finished) {
        
    }];
    
}


@end
