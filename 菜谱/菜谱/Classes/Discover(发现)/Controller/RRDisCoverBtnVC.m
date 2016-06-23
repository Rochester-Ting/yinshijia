//
//  RRDisCoverBtnVC.m
//  菜谱
//
//  Created by 丁瑞瑞 on 17/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRDisCoverBtnVC.h"
#import <MJExtension.h>
#import "UIImage+Image.h"
#import "RRRefreshHeader.h"
#import "RRRefreshFooter.h"
#import <AFHTTPSessionManager.h>
#import "RRPictureCell.h"
#import "RRDisCoverBtnItem.h"
#import <SVProgressHUD.h>
#import "RRChooseDetailController.h"
@interface RRDisCoverBtnVC ()<UITableViewDelegate,UITableViewDataSource>
/** manager*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** 模型数组*/
@property (nonatomic,strong) NSMutableArray *arr;
@end

@implementation RRDisCoverBtnVC
static NSString *ID = @"picCell";
//懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setTable];
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
#pragma mark - setTable
- (void)setTable{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRPictureCell class]) bundle:nil] forCellReuseIdentifier:ID];
}
#pragma mark - setNav
- (void)setNav{
    self.navigationItem.title = _catalogTitle;
}
#pragma mark - setRefresh
- (void)setRefresh{
//    创建上拉刷新
    self.tableView.header = [RRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    [self.tableView.header beginRefreshing];
}
#pragma mark - 实现上拉刷新监听的方法
- (void)loadNew{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    创建参数
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"version"] = @3.4;
//    获取url
    NSString *url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/apiv2/index/catalog/%@",_catalogId];
//    发送网络请求
    [self.manager POST:url parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.arr = [RRDisCoverBtnItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RRPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.disItem = self.arr[indexPath.row];
    cell.selectionStyle = 0;
    return cell;

}
#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RRChooseDetailController *chooesDetailVC = [[RRChooseDetailController alloc] init];
    
    RRDisCoverBtnItem *disItem = self.arr[indexPath.row];
    
    chooesDetailVC.dinnerNum = disItem.itemId;
    chooesDetailVC.type = disItem.type.integerValue;
    [self.navigationController pushViewController:chooesDetailVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 330;
}
@end
