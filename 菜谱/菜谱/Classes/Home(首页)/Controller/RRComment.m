//
//  RRComment.m
//  菜谱
//
//  Created by 丁瑞瑞 on 11/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRComment.h"
#import "RRCommetItem.h"
#import "RRCommentCell.h"
@interface RRComment ()
/** <#注释#>*/
@property (nonatomic,strong) NSMutableArray *arrM;
@end

@implementation RRComment
static NSString *ID = @"commet";
- (NSMutableArray *)arrM{
    if (!_arrM) {
        _arrM = [NSMutableArray array];
    }
    
    return _arrM;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrM = [RRCommetItem mj_objectArrayWithKeyValuesArray:_arr];
    self.tableView.separatorStyle = 0;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRCommentCell class]) bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RRCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.comment = self.arrM[indexPath.row];
    cell.selectionStyle = 0;
    return cell;
}

@end
