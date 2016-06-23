//
//  RRFairViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRFairViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <AFHTTPSessionManager.h>
#import <MJExtension/MJExtension.h>
#import "RRRefreshFooter.h"
#import "RRRefreshHeader.h"
#import "RRFairItem.h"
#import "RRFairViewCell.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking.h>
#import <SDWebImage/SDImageCache.h>
#import "RRFairDetailVC.h"
#import "UIImage+Image.h"
@interface RRFairViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/** uicollectionView*/
@property (nonatomic,strong) UICollectionView *collectionView;
/** 网络请求管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** 模型数组*/
@property (nonatomic,strong) NSMutableArray *modelArrM;
/** index*/
@property (nonatomic,assign) NSInteger index;
@property(nonatomic,assign)CGFloat historyY;
@end

@implementation RRFairViewController
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
//        _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
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
static NSString *ID = @"FairCell";
- (void)viewDidLoad {
    [super viewDidLoad];
//    设置collectionView
    [self setCollectionView];
//    设置刷新
    [self setRefresh];
    self.index = 2;
}
#pragma mark - 设置collectionView
- (void)setCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    设置collectioncell的大小
    flowLayout.itemSize = CGSizeMake(170, 200);
//    设置最小间距
    flowLayout.minimumInteritemSpacing = RRMargin;
//    设置行的最小距离
    flowLayout.minimumLineSpacing = RRMargin;
//    设置滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
//    设置背景颜色
    collectionView.backgroundColor = [UIColor whiteColor];
//    注册cell
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RRFairViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.contentInset = UIEdgeInsetsMake(navH + titleViewH, RRMargin, 0, RRMargin);
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    
}
#pragma mark - 设置刷新
- (void)setRefresh{
    self.collectionView.header = [RRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewHead)];
    [self.collectionView.header beginRefreshing];
    self.collectionView.footer = [RRRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreFoot)];
}
#pragma mark - loadNewHead
- (void)loadNewHead
{
//    取消前面的刷新操作
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    设置参数
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"version"] = @3.4;
    __block typeof(self) weakSelf = self;

//    发送请求
    NSString *url = @"http://api.yinshijia.com/mobile/apiv2/goods/list/1/10";
    [self.manager POST:url parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableArray *arrM = [RRFairItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];

        weakSelf.modelArrM = arrM;
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RRLog(@"%@",error);
        [weakSelf.collectionView.header endRefreshing];
    }];
}
#pragma mark - loadMoreFoot
- (void)loadMoreFoot{
//    取消前面的刷新操作
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    NSString *url = @"http://api.yinshijia.com/mobile/apiv2/goods/list/1/10";
    NSString *url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/apiv2/goods/list/%zd/10",self.index];
//    设置参数
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"version"] = @3.4;
//    发送请求
    __block typeof(self) weakSelf = self;
    [self.manager POST:url parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        字典专属组
        NSMutableArray *arrM = [RRFairItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (arrM.count > 0) {
            [weakSelf.modelArrM addObjectsFromArray:arrM];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有更多了啊"];
        }
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.footer endRefreshing];
        weakSelf.index++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RRLog(@"%@",error);
        [weakSelf.collectionView.footer endRefreshing];
    }];
}
#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArrM.count;
//    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RRFairViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    RRFairItem *item = self.modelArrM[indexPath.row];
//    cell.backgroundColor = [UIColor redColor];
    cell.fairItem = item;
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    return cell;
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

//当视图即将消失的时候把nav设置回来
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.alpha = 1;
    // 获取导航条的颜色
    UIColor *navColor = [UIColor colorWithWhite:1 alpha:0.99];
    
    // 设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RRFairDetailVC *vc = [[RRFairDetailVC alloc] init];
    RRFairItem *item = self.modelArrM[indexPath.row];
    
    vc.nameId = item.goodsId;
    vc.name = item.title;
    [self.navigationController pushViewController:vc animated:YES];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
@end
