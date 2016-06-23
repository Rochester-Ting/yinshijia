//
//  RRFairDetailVC.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRFairDetailVC.h"
#import "UIImage+Image.h"
#import <MJExtension.h>
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import <UIImageView+WebCache.h>
#import "RRFairCell1.h"
#import "RRFairCell2.h"
#import "RRFairCell3.h"
#import "RRFairCell4.h"
#import "RRBuyVC.h"
#import "RRTransition.h"
#import "RROrderFormFromBuyVC.h"
@interface RRFairDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@interface RRFairDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageH;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** cell1Arr*/
@property (nonatomic,strong) NSArray *cell1Arr;
/** cell2Arr*/
@property (nonatomic,strong) NSArray *cell2Arr;
/** cell3Arr*/
@property (nonatomic,strong) NSArray *cell3Arr;
/** cell4Arr*/
@property (nonatomic,strong) NSArray *cell4Arr;

/** nav title*/
@property (nonatomic,strong) UILabel *labelT;
/** 网络请求管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end
@implementation RRFairDetailVC
static NSString *CellID1 = @"faircell1";
static NSString *CellID2 = @"faircell2";
static NSString *CellID3 = @"faircell3";
static NSString *CellID4 = @"faircell4";
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    [self setTable];
    
    [self setNetWork];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}
- (void)setNetWork{
    NSString *url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/apiv2/goods/%@",_nameId];
//    NSLog(@"%@",url);
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        设置图片
        NSString *properties_image = responseObject[@"data"][@"properties_image"];
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:properties_image]];
//        cell  1
//        1.title标题
        NSString *titleLabel = responseObject[@"data"][@"title"];
//        2.描述
        NSString *des = responseObject[@"data"][@"description"];
//        3.价格
        NSString *subtitle = responseObject[@"data"][@"subtitle"];
        
        self.cell1Arr = @[titleLabel,des,subtitle];
//        cell2
//        1.头像
        NSString *icon = responseObject[@"data"][@"shop_headImage"];
//        2.名字
        NSString *nameLabel = responseObject[@"data"][@"shop_nickName"];
//        3.介绍
        NSString *shop_introduce = responseObject[@"data"][@"shop_introduce"];
        self.cell2Arr = @[icon,nameLabel,shop_introduce];
        
//        cell3
        NSArray *arr = responseObject[@"data"][@"properties"];
        
        NSString *propertiesImage = responseObject[@"data"][@"properties_image"];
        
        self.cell3Arr = @[arr,propertiesImage];
//        cell4
        NSString *book_info = responseObject[@"data"][@"book_info"];
        self.cell4Arr = @[book_info];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RRLog(@"%@",error);
    }];
    
}
- (void)setTable{
//    self.navigationController.navigationBar.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    设置导航栏的文字
    UILabel *labelT = [[UILabel alloc] init];
    //    设置文字的内容
    labelT.text = _name;
    //    设置文字的frame
    [labelT sizeToFit];
    //    设置文字的颜色和透明度
    labelT.textColor = [UIColor colorWithWhite:0 alpha:0];
    //    设置到导航栏
    self.navigationItem.titleView = labelT;
    self.labelT = labelT;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRFairCell1 class]) bundle:nil] forCellReuseIdentifier:CellID1];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRFairCell2 class]) bundle:nil] forCellReuseIdentifier:CellID2];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRFairCell3 class]) bundle:nil] forCellReuseIdentifier:CellID3];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRFairCell4 class]) bundle:nil] forCellReuseIdentifier:CellID4];
    
}
//设置nav
- (void)setNav{
    
    self.navigationController.navigationBar.alpha = 1;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"123";
    
    if (indexPath.row == 0) {
        RRFairCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellID1];
        cell.arr = self.cell1Arr;
        return cell;
    }else if (indexPath.row == 1) {
        RRFairCell2 *cell = [tableView dequeueReusableCellWithIdentifier:CellID2];
        cell.arr = self.cell2Arr;
        return cell;
    }else if (indexPath.row == 2) {
        RRFairCell3 *cell = [tableView dequeueReusableCellWithIdentifier:CellID3];
        cell.arr = self.cell3Arr;
        return cell;
    }else if (indexPath.row == 3) {
        RRFairCell4 *cell = [tableView dequeueReusableCellWithIdentifier:CellID4];
        cell.arr = self.cell4Arr;
        return cell;
    }



    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:ID];
    }
    cell.textLabel.text = @"rui";
    return cell;
}

#pragma mark - tableView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    原始的偏移量
    CGFloat originOffset = -300;
    //    现在的偏移量
    CGFloat offSet = scrollView.contentOffset.y - originOffset;
    //    图片的高度
    self.imageH.constant = 300 - offSet;
    if (self.imageH.constant < 64) {
        self.imageH.constant = 64;
    }
//    RRLog(@"viewh -- -- ---- ---- - -%.2f",self.imageH.constant);
    //    计算透明度
    CGFloat alpha = offSet / (300 - 64);
    if (alpha >= 1) {
        alpha = 0.99;
    }
//        设置文字的颜色和透明度
    self.labelT.textColor = [UIColor colorWithWhite:0 alpha:alpha];
//        获取透明度的变化
    UIColor *color = [UIColor colorWithWhite:1 alpha:alpha];
//        设置导航栏的图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}
- (IBAction)buyBtn:(id)sender {
    RRBuyVC *buyVC = [[RRBuyVC alloc] init];
    RRTransition *rrTrans = [[RRTransition alloc] init];
    buyVC.transitioningDelegate = rrTrans;
    rrTrans.isTabBar = 1;
    rrTrans.rr_frame = CGRectMake(0,screenH - 300, screenW, 300);
    buyVC.modalPresentationStyle = UIModalPresentationCustom;
    buyVC.titleLabel = self.cell1Arr[0];
    NSString *price = self.cell1Arr[2];
    price = [price componentsSeparatedByString:@"元"].firstObject;
    buyVC.priceLabel = price;
    buyVC.onePrice = price;
    
    [self presentViewController:buyVC animated:YES completion:nil];
    buyVC.buyBlock = ^(NSString *name,NSString *price,NSInteger account){
    
        RROrderFormFromBuyVC *formVC = [[RROrderFormFromBuyVC alloc] init];
        formVC.name = name;
        formVC.price = price;
        formVC.account = account;
        [self.navigationController pushViewController:formVC animated:YES];
    };
}

@end
