//
//  RRChooseDetailController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 24/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChooseDetailController.h"
#import "UIImage+Image.h"
#import <AFHTTPSessionManager.h>
#import <MJExtension/MJExtension.h>
#import "RRChooseDetailCell1.h"
#import "RRChooseDetailType2Cell1.h"
#import "RRType2RowCell2.h"
//#import "RRType2Row3Cell.h"
#import "RRPlainMenu.h"
#import <MJExtension.h>
#import "RRType2Row3TableViewCell.h"
#import "RRType2Row4Cell.h"
#import "RRType2Row5Cell.h"
#import "RRType1Row1Cell.h"
#import "RRType1Row2Cell.h"
#import "RRDetailHeadView.h"
#import "UIView+RRLoad.h"
#import "UMSocial.h"
#import "RROrderFormVC.h"
#import "RRMapController.h"
@interface RRChooseDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 任务管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** 模型数组*/
@property (nonatomic,strong) NSMutableArray *arr;
/** 第一个cell的数组*/
@property (nonatomic,strong) NSArray *arr1;
@property (nonatomic,strong) NSArray *arr2;
/** 第二个cell*/
@property (nonatomic,strong) NSArray *type2Arr2;
/** type2 row4*/
@property (nonatomic,strong) NSArray *arrType2Row4;
/** type2 row5*/
@property (nonatomic,strong) NSArray *arrType2Row5;
@property (nonatomic,strong) NSArray *arrType2Row6;
@property (weak, nonatomic) IBOutlet UILabel *price;
//tyep1 row1
@property (nonatomic,strong) NSArray *arrType1Row1;
@property (nonatomic,strong) NSArray *arrType1Row2;
@property (nonatomic,strong) NSArray *arrType1Row4;
@property (nonatomic,strong) NSArray *arrType1Row3;

/** titleL*/
@property (nonatomic,strong) UILabel *titleL;
@property(nonatomic ,assign) CGFloat oriOffsetY;


/** 饭局*/
@property (nonatomic,strong) NSString *fanju;
/** 时间*/
@property (nonatomic,strong) NSString *shijian;
/** address*/
@property (nonatomic,strong) NSString *dizhi;
/** price*/
@property (nonatomic,strong) NSString *danjia;

/** <#注释#>*/
@property (nonatomic,strong) NSString *shareContent;
/** <#注释#>*/
@property (nonatomic,strong) RRDetailHeadView *headView;
///** <#注释#>*/
//@property (nonatomic,strong) NSString *des;
//
//
///** arrMenu*/
//信息type2 row3
@property (nonatomic,strong) NSArray *arrMenu;
///** type2 row0*/
//@property (nonatomic,strong) NSString *desRow0Type2;
///** <#注释#>*/
//@property (nonatomic,assign) CGFloat height1;
@end

@implementation RRChooseDetailController
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSMutableArray *)arr
{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
//- (NSArray *)arr1
//{
//    if (!_arr1) {
//        _arr1 = [NSArray array];
//    }
//    return _arr1;
//}
static NSString *ID = @"DetailCell";
static NSString *ID1 = @"DetailCell1";
static NSString *IDType1 = @"type1";
static NSString *IDType2row2 = @"type2row2";
static NSString *IDType2Cell3 = @"type2row3";
static NSString *IDType2Cell4 = @"type2row4";
static NSString *IDType2Cell5 = @"type2row5";
//RRType1Row1Cell
static NSString *IDType1Cell2 = @"type1row2";
static NSString *IDType1Cell3 = @"type1row3";
static NSString *IDType1Cell4 = @"type1row4";
static NSString *IDType1Cell5 = @"type1row5";



- (void)viewDidLoad {
    [super viewDidLoad];
//    [self passNotice];
    
    RRDetailHeadView *headView = [RRDetailHeadView loadWithXib];
    self.tableView.tableHeaderView = headView;
    self.headView = headView;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    设置nav
    [self setNav];
//    设置nav的透明度
    [self setNavAlpha];
    
    
    
    
}
- (void)setNavAlpha
{
    self.oriOffsetY = -20;
//    self.navigationController.navigationBar.alpha = 0;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:0];
}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    self.navigationController.navigationBar.alpha = 1;
//    // 获取导航条的颜色
//    UIColor *navColor = [UIColor colorWithWhite:1 alpha:0.99];
//    
//    // 设置导航条背景图片
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
//}
- (void)setNav{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"rejuShareD"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn sizeToFit];
//    监听点击
    [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = item;
}
#pragma mark - 监听按钮的点击
- (void)shareBtnClick:(UIButton *)btn{
//    RRLog(@"%@",self.shareContent);
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56f9347ae0f55a19aa001109"
                                      shareText:self.shareContent
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToRenren,UMShareToDouban,nil]
                                       delegate:nil];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setTable];
    [self request];
}
- (void)setTable{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
//    type2 row1
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRChooseDetailCell1 class]) bundle:nil] forCellReuseIdentifier:ID1];
//    type1 row1
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRChooseDetailType2Cell1 class]) bundle:nil] forCellReuseIdentifier:IDType1];
//    type2 row2
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRType2RowCell2 class]) bundle:nil] forCellReuseIdentifier:IDType2row2];
//    tyep2 row3
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRType2Row3TableViewCell class]) bundle:nil] forCellReuseIdentifier:IDType2Cell3];
//    type2  row4
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRType2Row4Cell class]) bundle:nil] forCellReuseIdentifier:IDType2Cell4];
//    type2 row5
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRType2Row5Cell class]) bundle:nil] forCellReuseIdentifier:IDType2Cell5];
//    type1 row2
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRType1Row1Cell class]) bundle:nil] forCellReuseIdentifier:IDType1Cell2];
//    type1 row3
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRType1Row2Cell class]) bundle:nil] forCellReuseIdentifier:IDType1Cell3];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;

}
//- (instancetype)init
//{
//    if (self = [super init]) {
//        [self request];
//    }
//    return self;
//}
- (void)request{
    NSString *url = nil;
    if (_type == 2) {
        url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/apiv2/user/themeChef/%@",_dinnerNum];
//        RRLog(@"%@",_dinnerNum);
        [self.manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //        RRLog(@"%@",responseObject);
            //        获取标签
//            第一个cell
            NSString *des = responseObject[@"data"][@"baseInfo"][@"description"];
//            self.desRow0Type2 = des;
//            标签
            NSString *tag = responseObject[@"data"][@"baseInfo"][@"tag"];
//            
            NSString *title = responseObject[@"data"][@"baseInfo"][@"title"];
//            第二个cell
//            厨师的照片
            NSString *imageurl = responseObject[@"data"][@"baseInfo"][@"imageurl"];
//            厨师照片下面的简介
            NSString *introduce = responseObject[@"data"][@"baseInfo"][@"introduce"];
//            获取饭店所在的地图
            NSString *addressURL = responseObject[@"data"][@"baseInfo"][@"addressURL"];
//            获取地址
//            1.获取城市2
            NSString *address = responseObject[@"data"][@"baseInfo"][@"address"];
            self.arrType2Row4 = @[addressURL,address];
//            信息
//            交通指南-怎么去
            NSString *transportion_info = responseObject[@"data"][@"baseInfo"][@"transportion_info"];
//            交通指南-停车场的信息
            NSString *parking_info = responseObject[@"data"][@"baseInfo"][@"parking_info"];
//            饭局信息
            NSString *time0 = responseObject[@"data"][@"baseInfo"][@"themeYinshijiaExtInfo"][0];
            NSString *time1 = responseObject[@"data"][@"baseInfo"][@"themeYinshijiaExtInfo"][1];
            if (!transportion_info) {
                transportion_info = @"(null)";
            }
            self.arrMenu = @[transportion_info,parking_info,time0,time1];
            
//            预定须知
            NSString *orderDescription = responseObject[@"data"][@"baseInfo"][@"orderDescription"];
            NSString *theme_image = responseObject[@"data"][@"baseInfo"][@"theme_image"];
            self.headView.str = theme_image;
            self.arrType2Row5 = @[orderDescription];
//            NSString *price = responseObject[@"data"][@"baseInfo"][@"price"];
//            价格1
            self.price.text = [NSString stringWithFormat:@"%@/位",responseObject[@"data"][@"baseInfo"][@"price"]];
            
//            分享
            NSString *shareContent = responseObject[@"data"][@"shareContent"];
            self.shareContent = shareContent;
//            环境的图片
//            NSArray *envImage = responseObject[@"data"][@"envImage"];
//            环境选项
//            amenities
//            菜单
//            NSArray *arrMenu = responseObject[@"data"][@"plainMenu"];
//            self.arrMenu = [RRPlainMenu mj_objectArrayWithKeyValuesArray:arrMenu];
            
            
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor colorWithWhite:0 alpha:0];
            label.text = title;
            [label sizeToFit];
            self.titleL = label;
            //可以把文字的颜色搞成透明.
            self.navigationItem.titleView = label;

//            self.navigationItem.title = title;
            self.arr1 = @[title,des,tag];
            self.type2Arr2 = @[imageurl,introduce,title];
            
            self.danjia = self.price.text;
            self.shijian = @"未知";
            self.dizhi = address;
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            RRLog(@"%@",error);
        }];
    }else{
        url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/apiv2/dinner/getDinner/%@",_dinnerNum];
//        RRLog(@"%@",_dinnerNum);
        [self.manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //        RRLog(@"%@",responseObject);
            //        获取标签
            NSString *name = responseObject[@"data"][@"name"];
            NSString *introduce = responseObject[@"data"][@"introduce"];
            NSString *title = responseObject[@"data"][@"title"];
            NSString *imageUrl = responseObject[@"data"][@"headImageUrl"];
            NSString *tag = responseObject[@"data"][@"tag"][0];
//            价格1
            NSString *price = responseObject[@"data"][@"price"];
            
//            日期2
            NSString *date = responseObject[@"data"][@"endOrderTime"];
           
//            地址3
            NSString *address = responseObject[@"data"][@"address"];
            
//            订餐须知
            NSString *orderDescription = responseObject[@"data"][@"orderDescription"];
            NSString *headImageUrl = responseObject[@"data"][@"imageurlList"][0][@"imageurl"];
            NSString *preOrder = responseObject[@"data"][@"preOrder"];
            
//            RRLog(@"%@",orderDescription);
//            信息
            NSString *parking = responseObject[@"date"][@"parking"];
            self.price.text = [NSString stringWithFormat:@"%@/位",price];
            if (!price) {
                price = @"价格未知";
                self.price.text = @"已过期";
            }
            if (preOrder.integerValue == 1) {
                date = @"已过期!";
                self.price.text = @"已过期";
                self.buyBtn.enabled = NO;
            }
            if (!parking) {
                parking = @"暂无停车场信息";
            }
            if (!orderDescription) {
                orderDescription = @"暂无描述信息";
            }
            if (!address) {
                address = @"暂无地址信息";
            }
            self.headView.str = headImageUrl;
            self.arrType1Row3 = @[parking];
            self.arrType1Row4 = @[orderDescription];
            self.arrType1Row2 = @[address];
            self.arrType1Row1 = @[price,date];
            self.arr2 = @[title,name,introduce,imageUrl,tag];
            
            self.danjia = price;
            self.shijian = date;
            self.dizhi = address;
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            RRLog(@"%@",error);
        }];
    }


}
- (void)passNotice{
    _dinnerId(@"123");
}

- (IBAction)buyBtn:(UIButton *)sender {
    RROrderFormVC *orderVC = [[RROrderFormVC alloc] init];
//    /** 饭局*/
//    @property (nonatomic,strong) NSString *fanju;
//    /** 时间*/
//    @property (nonatomic,strong) NSString *shijian;
//    /** 单价*/
//    @property (nonatomic,strong) NSString *money;
//    /** 数量*/
//    @property (nonatomic,strong) NSString *account;
//    /** 总价*/
//    @property (nonatomic,strong) NSString *allAccount;
    orderVC.fanju = self.titleL.text;
    orderVC.shijian = self.shijian;
    orderVC.money = self.danjia;
    orderVC.dizhi = self.dizhi;
//    orderVC.allAccount = self.price.text;
//    orderVC.
    [self.navigationController pushViewController:orderVC animated:YES];
}
#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if (_type == 2) {
            RRChooseDetailCell1 *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
            cell.urlArray = self.arr1;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            RRChooseDetailType2Cell1 *cell = [tableView dequeueReusableCellWithIdentifier:IDType1];
            cell.arr = self.arr2;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.row == 1) {
        if (_type == 2) {
            RRType2RowCell2 *cell = [tableView dequeueReusableCellWithIdentifier:IDType2row2];
            cell.arr = self.type2Arr2;
            
            return cell;
        }else{
            RRType1Row1Cell *cell = [tableView dequeueReusableCellWithIdentifier:IDType1Cell2];
            cell.arr = self.arrType1Row1;
            return cell;
        }
    }
    if (indexPath.row == 2) {
        if (_type == 2) {
            RRType2Row3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDType2Cell3];
            cell.arr = self.arrMenu;
            return cell;

        }else{
            RRType1Row2Cell *cell = [tableView dequeueReusableCellWithIdentifier:IDType1Cell3];
            cell.arr = self.arrType1Row2;
            return cell;

        }
    }
    if (indexPath.row == 3) {
        if (_type == 2) {
            RRType2Row4Cell *cell = [tableView dequeueReusableCellWithIdentifier:IDType2Cell4];
            cell.arr = self.arrType2Row4;
            cell.cellBlock = ^(NSString *str){
                RRLog(@"%@",str);
                RRMapController *mapVC = [[RRMapController alloc] init];
                NSLog(@"%@",self.arrType2Row4[1]);
                mapVC.mudidi = self.arrType2Row4[1];
                [self.navigationController pushViewController:mapVC animated:YES];
            };
            
            return cell;
            
        }else{
            
            RRType2Row3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDType2Cell3];
            cell.arr = self.arrType1Row3;
            return cell;

        }
    }
    if (indexPath.row == 4) {
        if (_type == 2) {
            RRType2Row5Cell *cell = [tableView dequeueReusableCellWithIdentifier:IDType2Cell5];
            cell.arr = self.arrType2Row5;
            return cell;
            
        }else{
            RRType2Row5Cell *cell = [tableView dequeueReusableCellWithIdentifier:IDType2Cell5];
            cell.arr = self.arrType1Row4;
            return cell;
            


        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = @"rui";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//只要tableView滚动时,就会调用这个方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //计算滚动的便宜量
    CGFloat offSetY = scrollView.contentOffset.y - self.oriOffsetY;
//    NSLog(@"%f",offSetY);
    // 处理导航条
    // 计算当前的透明度
    CGFloat alpha = offSetY / 200;
//    RRLog(@"%f",alpha);
    if (alpha > 1) {
        alpha = 0.99;
    }
    
    //设置标题的透明度
    self.titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];

    // 获取导航条的颜色
    UIColor *navColor = [UIColor colorWithWhite:1 alpha:alpha];
    
    // 设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navColor] forBarMetrics:UIBarMetricsDefault];
    
    
}
@end
