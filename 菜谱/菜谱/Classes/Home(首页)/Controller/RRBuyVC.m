//
//  RRBuyVC.m
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRBuyVC.h"
#import "RRTitleCell.h"
#import "RRCountCell.h"
#import "RRPriceCell.h"
#import "RROrderFormFromBuyVC.h"
@interface RRBuyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buy;
/** 价格*/
@property (nonatomic,strong) NSString *price;
/** 数量*/
@property (nonatomic,assign) NSInteger account;
/** 名字*/
@property (nonatomic,strong) NSString *name;
@end

@implementation RRBuyVC
static NSString *cell1 = @"title";
static NSString *cell2 = @"price";
static NSString *cell3 = @"count";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTable];
    }
- (void)setTable{
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRTitleCell class]) bundle:nil] forCellReuseIdentifier:cell1];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRPriceCell class]) bundle:nil] forCellReuseIdentifier:cell2];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRCountCell class]) bundle:nil] forCellReuseIdentifier:cell3];
}
- (IBAction)buyBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
//    self.view.hidden = YES;
        if (_buyBlock) {
            _buyBlock(_titleLabel,_priceLabel,_onePrice.integerValue);
        }
//
    }];
//    RROrderFormFromBuyVC *orderVC = [[RROrderFormFromBuyVC alloc] init];
//    [self presentViewController:orderVC animated:YES completion:nil];
}
#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        RRTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cell1];
        cell.title = _titleLabel;
        return cell;
    }else if (indexPath.row == 1) {
        RRPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cell2];
        cell.price = _priceLabel;
        return cell;
    }else{
        RRCountCell *cell = [tableView dequeueReusableCellWithIdentifier:cell3];
        cell.countBlock = ^(NSString *str){
            NSInteger value = _onePrice.integerValue;
            value = value * str.integerValue;
            _priceLabel = [NSString stringWithFormat:@"%zd",value];
            [self.tableView reloadData];
        };
        cell.minusBlock = ^(NSString *str){
            NSInteger value = _onePrice.integerValue;
            value = value * str.integerValue;
            _priceLabel = [NSString stringWithFormat:@"%zd",value];
            [self.tableView reloadData];
        };
        return cell;
    }
}
@end
