//
//  RRChefDetailVC.m
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChefDetailVC.h"
#import <MJExtension.h>
#import "RRChefCell1.h"
#import "RRChefCell2.h"
#import "RRChefCell3.h"
#import "RRChefCell4.h"
#import "RRChefCell5.h"
#import "RRChefItem1.h"
#import "RRType2Row4Cell.h"
#import "RRRefreshHeader.h"
#import <SVProgressHUD.h>
#import <AFNetworking.h>
#import <AFHTTPSessionManager.h>
#import "RRComment.h"
#import "UMSocial.h"
@interface RRChefDetailVC ()<UITableViewDelegate,UITableViewDataSource>
/** 网络请求管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
/** <#注释#>*/
@property (nonatomic,strong) UIButton *btn;

/** RRChefItem1*/
@property (nonatomic,strong)  RRChefItem1 *itemCell1;

/** share*/
@property (nonatomic,strong) NSString *share;

/** arrCell*/
@property (nonatomic,strong) NSArray *arrItem;
@property (nonatomic,strong) NSArray *arrCell2;
@property (nonatomic,strong) NSArray *arrCell3;
@property (nonatomic,strong) NSArray *arrCell4;
@property (nonatomic,strong) NSArray *arrCell5;
/** <#注释#>*/
@property (nonatomic,strong) NSArray *commentArr;
/** pl*/
@property (nonatomic,strong) NSString *pl;
@end

@implementation RRChefDetailVC
static NSString *IDCell1 = @"cell1";
static NSString *IDCell2 = @"cell2";
static NSString *IDCell3 = @"cell3";
static NSString *IDCell4 = @"cell4";
static NSString *IDCell5 = @"cell5";


- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = _btn.bounds;
        
        [_btn setTitle:@"点击查看评论" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView2.rowHeight = UITableViewAutomaticDimension;
    self.tableView2.estimatedRowHeight = 400;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self setNav];
    [self loadNewTopic];
    [self setCell];
}

- (void)setCell{
    [self.tableView2 registerNib:[UINib nibWithNibName:NSStringFromClass([RRChefCell1 class]) bundle:nil] forCellReuseIdentifier:IDCell1];
    [self.tableView2 registerNib:[UINib nibWithNibName:NSStringFromClass([RRChefCell2 class]) bundle:nil] forCellReuseIdentifier:IDCell2];
    [self.tableView2 registerNib:[UINib nibWithNibName:NSStringFromClass([RRChefCell3 class]) bundle:nil] forCellReuseIdentifier:IDCell3];
    [self.tableView2 registerNib:[UINib nibWithNibName:NSStringFromClass([RRChefCell4 class]) bundle:nil] forCellReuseIdentifier:IDCell4];
    [self.tableView2 registerNib:[UINib nibWithNibName:NSStringFromClass([RRChefCell5 class]) bundle:nil] forCellReuseIdentifier:IDCell5];
    self.tableView2.delegate = self;
    self.tableView2.dataSource = self;
}

#pragma mark - loadNewTopic
- (void)loadNewTopic{
    //    取消上一次刷新
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"version"] = @3.4;
    NSString *url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/apiv2/user/chefDetail/%@",_UserId];
//    NSLog(@"%@",url);
    [self.manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /** headImageurl*/
        NSString *headImageurl = responseObject[@"data"][@"baseInfo"][@"headImageurl"];
        /** converurl*/
        NSString *converurl = responseObject[@"data"][@"baseInfo"][@"converurl"];
        /** introduce*/
        NSString *introduce = responseObject[@"data"][@"baseInfo"][@"introduce"];
        /** name*/
        NSString *name = responseObject[@"data"][@"baseInfo"][@"name"];
//        shopName
        NSString *shopName = responseObject[@"data"][@"baseInfo"][@"shopName"];
        self.navigationItem.title = shopName;
//        cell1
        NSString *pl = responseObject[@"data"][@"commentNum"];
        
        NSString *yuding = [NSString stringWithFormat:@"%zd",_yuding];
        NSString *xihuan = [NSString stringWithFormat:@"%zd",_xihuan];
        self.arrItem = @[converurl,yuding,xihuan,pl];
        
//        cell2
        if (!headImageurl) {
            headImageurl = @"暂无信息";
        }
        if (!introduce) {
            introduce = @"暂无信息";
        }
        if (!name) {
            name = @"暂无信息";
        }
        self.arrCell2 = @[headImageurl,introduce,name];
//        cell3
//        /**environmenturl*/
        NSString *environmenturl = responseObject[@"data"][@"kitchenImage"][0][@"environmenturl"];
        if (!environmenturl) {
            environmenturl = @"暂无信息";
        }
        self.arrCell3 = @[environmenturl];
        
//        cell4
        NSArray *menu = responseObject[@"data"][@"menu"];
        if (menu.count != 0) {
//            self.arrCell4 = @[@"暂无相关信息",@"暂无相关信息",@"暂无相关信息"];
            NSString *title = responseObject[@"data"][@"menu"][0][@"title"];
            NSString *description = responseObject[@"data"][@"menu"][0][@"description"];
            NSString *image = responseObject[@"data"][@"menu"][0][@"image"];
            if (!title) {
                title = @"暂无信息";
            }
            if (!description) {
                description = @"暂无信息";
            }
            if (!image) {
                image = @"暂无信息";
            }
            self.arrCell4 = @[title,description,image];
            
            
            //        cell5
            NSString *title2 = responseObject[@"data"][@"menu"][1][@"title"];
            NSString *description2 = responseObject[@"data"][@"menu"][1][@"description"];
            NSString *image2 = responseObject[@"data"][@"menu"][1][@"image"];
            if (!title2) {
                title2 = @"暂无信息";
            }
            if (!description2) {
                description2 = @"暂无信息";
            }
            if (!image2) {
                image2 = @"暂无信息";
            }
            self.arrCell5 = @[title2,description2,image2];
            
            
            self.commentArr = responseObject[@"data"][@"comment"];

        }
//        share
        self.share = responseObject[@"data"][@"shareContent"];
        [self.tableView2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RRLog(@"%@",error);
        
        [SVProgressHUD showSuccessWithStatus:@"加载失败!"];
    }];
}

#pragma mark - setNav
- (void)setNav{
//    self.navigationItem.title = _name;
    //    设置分享按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"rejuShareD"] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn sizeToFit];
    //    监听点击
    [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = item;
}
#pragma mark - rightBtnClick
- (void)rightBtnClick:(UIButton *)btn{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56f9347ae0f55a19aa001109"
                                      shareText:self.share
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToRenren,UMShareToDouban,nil]
                                       delegate:nil];

}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        RRChefCell1 *cell = [tableView dequeueReusableCellWithIdentifier:IDCell1];
        cell.arrT = self.arrItem;
        cell.selectionStyle = 0;
        return cell;
    }else if(indexPath.row == 1){
        RRChefCell2 *cell = [tableView dequeueReusableCellWithIdentifier:IDCell2];
        cell.arr = self.arrCell2;
        cell.selectionStyle = 0;
        return cell;
        
    }else if (indexPath.row == 2){
        RRChefCell3 *cell = [tableView dequeueReusableCellWithIdentifier:IDCell3];
        cell.arr = self.arrCell3;
        cell.selectionStyle = 0;
        return cell;
    } else if (indexPath.row == 3){
        RRChefCell4 *cell = [tableView dequeueReusableCellWithIdentifier:IDCell4];
        cell.arr = self.arrCell4;
        cell.selectionStyle = 0;
        return cell;
    }else if (indexPath.row == 4){
        RRChefCell5 *cell = [tableView dequeueReusableCellWithIdentifier:IDCell5];
        cell.arr = self.arrCell5;
        cell.selectionStyle = 0;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"122222"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"122222"];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.text = @"点击查看评论";
        cell.selectionStyle = 0;
        return cell;
    }
}

- (void)rightBtnClick{
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        RRComment *commentVC = [[RRComment alloc] init];
        commentVC.arr = self.commentArr;
        [self.navigationController pushViewController:commentVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 250;
    }else if(indexPath.row == 1){
        return 300;
    }else if(indexPath.row == 2){
        return 300;
    }else if(indexPath.row == 3){
        if (!self.arrCell4) {
//            NSLog(@"%@",self.arrCell3);
            return 50;
        }
        CGFloat cellH = 0;
        cellH += 360;
        CGSize maxSize = CGSizeMake(screenW - 20, MAXFLOAT);
        cellH += [self.arrCell4[1] boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
        return cellH;

        
    }else if(indexPath.row == 4){
            if (!self.arrCell5) {
            return 50;
        }
        CGFloat cellH = 0;
        cellH += 360;
        CGSize maxSize = CGSizeMake(screenW - 20, MAXFLOAT);
        cellH += [self.arrCell5[1] boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
        return cellH;
        
    }else{
        return 50;
    }
}

@end
