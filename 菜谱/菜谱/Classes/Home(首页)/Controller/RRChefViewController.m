//
//  RRChefViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 13/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChefViewController.h"
#import "RRCollectionViewCell.h"
#import "RRCollectionViewCell.h"
#import "chefViewItem.h"
#import "RRRefreshFooter.h"
#import "RRRefreshHeader.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <SDWebImage/SDImageCache.h>
#import "RRHeaderView.h"
#import "UIView+RRLoad.h"
#import <Masonry.h>
#import "RRBtnView.h"
#import "RRChefDetailVC.h"
#import "RRChefHeaderView.h"
@interface RRChefViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** 数组模型*/
@property (nonatomic,strong) NSMutableArray *arrM;
/** 创建任务监听者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** 存放滚动视图照片的模型*/
@property (nonatomic,strong) NSMutableArray *arrImages;
/** index*/
@property (nonatomic,assign) NSInteger index;
//设置headView的偏移量
@property(nonatomic ,assign) CGFloat oriOffsetY;
//collectionView
@property (weak, nonatomic)  UICollectionView *collectionView;
@property (strong, nonatomic)  UIView *head;
@property (weak, nonatomic)  UIView *titleView;

@property (weak, nonatomic)  NSLayoutConstraint *headViewCons;
@property(nonatomic,assign)CGFloat historyY;

@end

@implementation RRChefViewController

static NSString * const ID = @"RR";
static NSString * const HeaderID = @"header";
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
//        _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", nil];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    设置collection
    [self setCollectionVC];
//    设置刷新
    [self setRefresh];
    
    self.index = 2;
//    [self addHeadView];
    self.oriOffsetY = -(64 + 44);
    //    添加titleView
    [self setTitleView];
}
#pragma mark - 实现设置titleView的方法
- (void)setTitleView{
    UIView *titleView = [[UIView alloc] init];
//    titleView.backgroundColor = [UIColor redColor];
    
//    titleView.frame = CGRectMake(0, 64 + 44 + 200, screenW, 44);
    [self.collectionView addSubview:titleView];
    
//    添加约束
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64 + 44 + 200);
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(@44);
    }];
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor whiteColor];
//    设置按钮
    [self setyinshijia];
//    设置分割线
    [self setupFengexian];
//    设置最热和最新按钮
    [self setNewAndHotBtn];
    
}
#pragma mark - 设置隐食家按钮
- (void)setyinshijia{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 20, 100, self.titleView.rr_height);
    [btn setTitle:@"隐食家" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [self.titleView addSubview:btn];
}
#pragma mark - 设置分割线
- (void)setupFengexian{
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor lightGrayColor];
    view2.frame = CGRectMake(0, 0, screenW, 1);
    [self.titleView addSubview:view2];
    
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor lightGrayColor];
    view3.frame = CGRectMake(0, 44, screenW, 1);
    [self.titleView addSubview:view3];
}
#pragma mark - 设置最新最热按钮
- (void)setNewAndHotBtn{
    //    最热最新
    UIButton *btnhot = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btnhot.frame = CGRectMake(270, 20, 40, self.titleView.rr_height);
    [btnhot setTitle:@"最热" forState:UIControlStateNormal];
    [btnhot setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnhot setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btnhot.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [self.titleView addSubview:btnhot];
    
    
    UIButton *btnxin = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    btnxin.frame = CGRectMake(310, 20, 40, self.titleView.rr_height);
    [btnxin setTitle:@"最新" forState:UIControlStateNormal];
    [btnxin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnxin setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    btnxin.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [self.titleView addSubview:btnxin];
    
}
#pragma mark - 实现设置headView的方法
- (void)addHeadView{
    RRChefHeaderView *head = [RRChefHeaderView loadWithXib];
    head.chefBlock = ^(NSString *userId,NSString *name){
        RRChefDetailVC *detailVC = [[RRChefDetailVC alloc] init];
        detailVC.UserId = userId;
        detailVC.name = name;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    head.urlArrM = self.arrImages;
//    head.frame = CGRectMake(-20, 0, self.view.rr_width, 200);
    [self.collectionView addSubview:head];
    
//    添加约束
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView).with.offset(0);
        make.left.equalTo(self.collectionView).with.offset(-10);
        make.right.equalTo(self.collectionView).with.offset(0);
//        make.bottom.equalTo(self.titleView.mas_top).with.offset(0);
        make.width.mas_equalTo(screenW);
        make.height.mas_equalTo(@200);

    }];
    self.head = head;
    
}
//    设置collection
- (void)setCollectionVC{
    UICollectionViewFlowLayout *layout = ({
        
        layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(170, 200);
        layout.sectionHeadersPinToVisibleBounds = YES;
        layout.headerReferenceSize = CGSizeMake(screenW, 244);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout;
        
    });
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];

//    注册cell
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RRCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
//    注册头部视图
//    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([RRHeaderView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    collectionView.contentInset = UIEdgeInsetsMake(navH + titleViewH, 10, 0, 10);

    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.frame = self.view.bounds;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}
#pragma mark - 设置刷新
- (void)setRefresh{
    self.collectionView.header = [RRRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewMessage)];
    [self.collectionView.header beginRefreshing];
    self.collectionView.footer = [RRRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreMessage)];
}
#pragma mark - 实现刷新监听的方法
//上拉刷新
- (void)loadNewMessage{
//    取消上一次的刷新
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    设置参数
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"version"] = @3.4;
//    发送请求
    __block typeof(self) weakSelf = self;
    [self.manager POST:@"http://api.yinshijia.com/mobile/apiv2/index/chef/1" parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        取出字典
        NSDictionary *dictChef = responseObject[@"data"];
//        取出厨师数组列表
        NSArray *arrChef = dictChef[@"chefList"];
//        字典转模型weakSelf.arrM
        NSMutableArray *arr1 = [chefViewItem mj_objectArrayWithKeyValuesArray:arrChef];
        self.arrImages = [chefViewItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"banner"]];
//        判断是否有新数据刷新出来
        if (arr1.count > 0) {
            weakSelf.arrM = nil;
            weakSelf.arrM = arr1;
        }
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.header endRefreshing];
        [self addHeadView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RRLog(@"%@",error);
        [self.collectionView.header endRefreshing];
    }];
}
//下拉刷新
- (void)loadMoreMessage{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
//    设置参数
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[@"version"] = @3.4;
//    发送请求
    
    NSString *url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/apiv2/index/chefList/hot/1/%zd/10",self.index];
    [self.manager POST:url parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        字典转模型
        NSMutableArray *arr2 = [chefViewItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        判断是否有新数据刷出来
        if (arr2 > 0) {
            [self.arrM addObjectsFromArray:arr2];
        }else{
            [SVProgressHUD showInfoWithStatus:@"没有更多了!"];
        }
//        刷新
        [self.collectionView reloadData];
        [self.collectionView.footer endRefreshing];
        self.index++;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RRLog(@"%@",error);
        [self.collectionView.footer endRefreshing];
    }];
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.arrM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RRCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    chefViewItem *item = self.arrM[indexPath.row];
    cell.chefItem = item;

    
    return cell;
}

/**
 *  滚动完毕
 */
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[SDImageCache sharedImageCache] clearMemory];
    CGFloat offSetY = scrollView.contentOffset.y - self.oriOffsetY;
    if (offSetY > 202) {
        offSetY = 202;
    }
//    RRLog(@"%f",offSetY);
    [self.titleView mas_updateConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(self.view).with.offset(310 - offSetY);
//        make.height.mas_equalTo(@(h))
    }];
    
}
//设置滑动的判定范围,显示隐藏tabBar
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.historyY+20<targetContentOffset->y)
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
    CGRect  tabRect = self.tabBarController.tabBar.frame;
    UIView *view;
    for (view in tab.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            continue;
        }
        
        if (hidden) {
            view.frame = tab.bounds;
            tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
        } else {
            view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
            tabRect.origin.y=[[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
        }
    }
    
    
    [UIView animateWithDuration:0.5f animations:^{
        self.tabBarController.tabBar.frame=tabRect;
    }completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    RRLog(@"点击collectionView");
    
    RRChefDetailVC *chefDetailVC = [[RRChefDetailVC alloc] init];
    chefViewItem *item = self.arrM[indexPath.row];
    chefDetailVC.UserId = item.userId;
    chefDetailVC.name = item.shopName;
    chefDetailVC.yuding = item.orderedCount;
    chefDetailVC.xihuan = item.likeCount;
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:chefDetailVC animated:YES];
    
}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//}

@end
