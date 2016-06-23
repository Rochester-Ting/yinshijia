//
//  RRPicTableViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 13/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRPicTableViewController.h"
#import "RRImageItem.h"
#import <MJExtension/MJExtension.h>
#import <AFHTTPSessionManager.h>
#import <MJRefresh.h>
#import "RRRefreshFooter.h"
#import "RRRefreshHeader.h"
#import "RRPicItem.h"
#import "RRPictureCell.h"
#import "RRPicTableCell.h"
#import "UIView+RRLoad.h"
#import "RRPicHeadView.h"
#import <SDWebImage/SDImageCache.h>
#import "RRChooseDetailController.h"
#import "RRChooseItem.h"
#import "UIImage+Image.h"
@interface RRPicTableViewController ()
/** 请求管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** 模型数组*/
@property (nonatomic,strong) NSMutableArray *arrM;
/** 全局字典*/
@property (nonatomic,strong) NSMutableDictionary *dictM;
/** view*/
/** rrheadview*/
@property (nonatomic,strong) RRPicHeadView *headView;
@end

@implementation RRPicTableViewController
static NSString *ID = @"picCell";
static NSString *ruiID = @"ruirui";
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSMutableArray *)arrM
{
    if (!_arrM) {
        _arrM = [NSMutableArray array];
    }
    return _arrM;
}
- (NSMutableDictionary *)dictM
{
    if (!_dictM) {
        _dictM = [NSMutableDictionary dictionary];
    }
    return _dictM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRPictureCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRPicTableCell class]) bundle:nil] forCellReuseIdentifier:ruiID];
    RRPicHeadView *headView = [[RRPicHeadView alloc] init];
    self.tableView.tableHeaderView = headView;
    self.headView = headView;
    
//    headView.label =_des;
    headView.label = _value;

//    设置刷新
    [self setRefresh];
}
- (void)setRefresh{
    self.tableView.header = [RRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRefresh)];
    [self.tableView.header beginRefreshing];
}
#pragma mark - loadNewRefresh
- (void)loadNewRefresh{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSString *url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/apiv2/index/campaignItem/%@",_value];
//    RRLog(@"%@",_value);
    [self.manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        RRLog(@"%@",responseObject[@"data"][@"campaign"]);
        NSMutableDictionary *dict = responseObject[@"data"][@"campaign"];
        self.dictM = dict;
        self.navigationItem.title = dict[@"title"];
//        self.headView.label = dict[@"description"];

        NSArray *arr = responseObject[@"data"][@"item"];

//        RRLog(@"%zd",arr.count);
        self.arrM = [RRPicItem mj_objectArrayWithKeyValuesArray:arr];
        
        [self.tableView reloadData];
        [self.tableView.header endRefreshing];
        
        if (self.arrM.count == 0) {
            _blockValue(@"数组里面没有模型啊");
        }
        
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RRLog(@"%@",error);
        [self.tableView.header endRefreshing];
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.arrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        RRPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        cell.item = self.arrM[indexPath.row];
        return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 330;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [[SDImageCache sharedImageCache] clearMemory];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RRChooseDetailController *chooesDetailVC = [[RRChooseDetailController alloc] init];
    
    RRPicItem *chooseItem = self.arrM[indexPath.row];

    chooesDetailVC.dinnerNum = chooseItem.dinner_id;
    chooesDetailVC.type = chooseItem.type;
    [self.navigationController pushViewController:chooesDetailVC animated:YES];
//    RRLog(@"ruirui");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//当视图即将消失的时候把nav设置回来
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 1;
    // 获取导航条的颜色
    UIColor *navColor = [UIColor colorWithWhite:1 alpha:0.99];
    
    // 设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
}

@end
