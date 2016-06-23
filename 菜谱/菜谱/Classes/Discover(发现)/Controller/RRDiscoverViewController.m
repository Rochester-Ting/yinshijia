//
//  RRDiscoverViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRDiscoverViewController.h"
#import "RRDisHeaderView.h"
#import "RRDisCoverCell.h"
#import <AFHTTPSessionManager.h>
#import "RRRefreshHeader.h"
#import <MJExtension.h>
#import "RRFirstTableViewCell.h"
#import "RRDisItem.h"
#import "RRDisCoverBtnVC.h"
#import "UIImage+Image.h"
#import "RRChefDetailVC.h"
@interface RRDiscoverViewController ()
/** 刷新管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** 模型数组*/
@property (nonatomic,strong) NSMutableArray *modelArrM;
/** rrheadView*/
@property (nonatomic,strong) RRDisHeaderView *headView;
@end

@implementation RRDiscoverViewController
NSString *ID = @"cellDis";
NSString *firstID = @"fisrtID";
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSMutableArray *)modelArrM
{
    if (!_modelArrM) {
        _modelArrM = [NSMutableArray array];
    }
    return _modelArrM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    设置tabBar
    [self setTabBar];
    
    [self setTableView];
    [self setRefresh];
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
#pragma mark - 设置tableView
- (void)setTableView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRDisCoverCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRFirstTableViewCell class]) bundle:nil] forCellReuseIdentifier:firstID];
    RRDisHeaderView *headView = [[RRDisHeaderView alloc] init];
    self.tableView.tableHeaderView = headView;
//    headView的回调
    headView.btnBlock = ^(NSString *catalogId,NSString *catalogTitle){
        RRDisCoverBtnVC *btnVC = [[RRDisCoverBtnVC alloc] init];
        btnVC.catalogId = catalogId;
        btnVC.catalogTitle = catalogTitle;
        [self.navigationController pushViewController:btnVC animated:YES];
    };

    self.headView = headView;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 10;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
#pragma mark - 设置刷新
- (void)setRefresh{
    self.tableView.header = [RRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewHead)];
    [self.tableView.header beginRefreshing];
}
- (void)loadNewHead{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    设置参数
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"version"] = @3.4;
    __block typeof(self) weakSelf = self;
    [self.manager POST:@"http://api.yinshijia.com/mobile/apiv2/discovery/city/1" parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        weakSelf.modelArrM = [RRDisItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"chefs"]];
        weakSelf.headView.arr = [RRDisItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"catalogs"]];
//        self.tableView.tableHeaderView.frame = CGRectMake(0, 0, screenW, screenW / weakSelf.headView.arr.count * 2);
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RRLog(@"%@",error);
        [weakSelf.tableView.header endRefreshing];
    }];
}
#pragma mark - 设置tabBar
- (void)setTabBar{
    self.tabBarItem.title = @"发现";

    self.tabBarItem.image = [UIImage imageNamed:@"dock_bowl_unselected"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"dock_bowl_selected"];
}
#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        RRFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstID];
        cell.selectionStyle = 0;
        return cell;
    }else{
        RRDisCoverCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.disItem = self.modelArrM[indexPath.row];
        cell.selectionStyle = 0;
        return cell;
    }
    
}
#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 30;
    }
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RRChefDetailVC *detailVC = [[RRChefDetailVC alloc] init];
    RRDisItem *item = self.modelArrM[indexPath.row];
    detailVC.UserId = item.userId;
    detailVC.yuding = item.orderedCount;
    detailVC.xihuan = item.likeCount;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
