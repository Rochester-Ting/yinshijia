//
//  RRDisHeaderView.m
//  菜谱
//
//  Created by 丁瑞瑞 on 22/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRDisHeaderView.h"
#import "RRDisItem.h"
#import <UIButton+WebCache.h>
#import "RRBtn.h"
@implementation RRDisHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor greenColor];
//        self.frame = CGRectMake(0, 0, screenW, screenW / _arr.count * 2);
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = self.rr_width / 4;
    CGFloat btnH = btnW;
    int row = 0;
    for (int i = 0; i < arr.count; i++) {
        RRBtn *btn = [RRBtn buttonWithType:UIButtonTypeCustom];
        
        btnX = i % 4 * btnW;
        btnY = i / 4 * btnW;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        if (arr.count % 4 == 0) {
            row = (int)arr.count / 4;
        }else{
            row = (int)arr.count / 4 + 1;
        }
        RRDisItem *item = arr[i];
        [btn setTitle:item.catalogTitle forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:item.catalogImage] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(tapBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.contentHorizontalAlignment = UIViewContentModeCenter;
        self.rr_height = row * btnH + RRMargin;
        UITableView *tableView = (UITableView *)self.superview;
        tableView.tableHeaderView = self;
        [tableView reloadData];
    }
}
- (void)tapBtnClick:(UIButton *)btn{
    RRDisItem *item = _arr[btn.tag];
    if (_btnBlock) {
        _btnBlock(item.catalogId,item.catalogTitle);
    }
    
}
@end
