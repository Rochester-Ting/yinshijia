//
//  RRFairCell3.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRFairCell3.h"
#import "RRFairDetailItem.h"
#import "RRFairDetailCell.h"
#import <MJExtension/MJExtension.h>
#import <UIImageView+WebCache.h>
@interface RRFairCell3 ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewH;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/** 字典数组*/
@property (nonatomic,strong) NSMutableArray *arrM;
@end
@implementation RRFairCell3
static NSString *ID = @"detail";
- (NSMutableArray *)arrM
{
    if (!_arrM) {
        _arrM = [NSMutableArray array];
        
    }
    return _arrM;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableHeaderView = nil;
    self.tableView.tableFooterView = nil;
    self.tableView.separatorStyle = 0;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRFairDetailCell class]) bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView reloadData];
}

- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    if (arr.count > 0) {
        self.arrM = [RRFairDetailItem mj_objectArrayWithKeyValuesArray:arr[0]];
        [self.tableView reloadData];
//        NSLog(@"i -----%.2f",self.tableView.contentSize.height);
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:arr[1]]];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrM.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RRFairDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.item = self.arrM[indexPath.row];
//    NSLog(@"cellH -- -- -----  %.2f",cell.frame.size.height) ;
    cell.selectionStyle = 0;
    return cell;
}
#pragma mark - UITableViewDelegate

@end
