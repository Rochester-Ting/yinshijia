//
//  RRDoneVC.m
//  菜谱
//
//  Created by 丁瑞瑞 on 17/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRDoneVC.h"
#import "RRRefreshHeader.h"
#import "RRCancelCell.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "RRCancelItem.h"
#import <AFHTTPSessionManager.h>

@interface RRDoneVC ()
/** 模型数组*/
@property (nonatomic,strong) NSMutableArray *arrM;
@property (nonatomic,strong) NSArray *orderList;

/** manager*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation RRDoneVC

static NSString *ID = @"cancel";
- (NSMutableArray *)arrM
{
    if (!_arrM) {
        _arrM = [NSMutableArray array];
    }
    return _arrM;
}
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        //        _manager.acceptableContentTypes
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTable];
    [self setRefresh];
}
- (void)setTable{
    self.tableView.separatorStyle = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(navH + titleViewH, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRCancelCell class]) bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.rowHeight = 72;
}

- (void)setRefresh{
    self.tableView.header = [RRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNew)];
    [self.tableView.header beginRefreshing];
}
- (void)loadNew{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"version"] = @3.4;
    dictM[@"data"] = @"{\"token\":\"9758:562a61d106834e92aecb1521c9313331\"}";
    NSString *url = @"http://api.yinshijia.com/mobile/apiv2/orders/user/onGoing/1/8";
    [self.manager POST:url parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.arrM = [RRCancelItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"orderList"]];
        [self.tableView.header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.header endRefreshing];
        RRLog(@"%@",error);
    }];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RRCancelCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    RRCancelItem *item = self.arrM[indexPath.row];
    cell.item = item;
    return cell;
}


@end
