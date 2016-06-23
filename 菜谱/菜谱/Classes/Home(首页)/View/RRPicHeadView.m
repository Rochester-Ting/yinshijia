//
//  RRPicHeadView.m
//  菜谱
//
//  Created by 丁瑞瑞 on 23/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRPicHeadView.h"
#import <AFHTTPSessionManager.h>
@interface RRPicHeadView ()
@property (nonatomic,strong) AFHTTPSessionManager *manager;
/** nsstring*/
@property (nonatomic,strong) NSString *str;
@end
@implementation RRPicHeadView
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)setLabel:(NSString *)label
{
    _label = label;
    NSString *url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/apiv2/index/campaignItem/%@",_label];
//    RRLog(@"%@",_label);
    [self.manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dict = responseObject[@"data"][@"campaign"];
        NSString *str = dict[@"description"];
        self.str = str;
        [self setLabel2];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            RRLog(@"%@",error);
        
        
    }];
}

- (void)setLabel2
{
    UILabel *rr_label = [[UILabel alloc] init];
    [self addSubview:rr_label];
    CGFloat textMaxW = screenW - 60;
    CGSize textMaxSize = CGSizeMake(textMaxW, MAXFLOAT);
    CGFloat Height = [self.str boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + 2 * RRMargin;
    rr_label.frame = CGRectMake(30, 10, textMaxW, Height);
    rr_label.textAlignment = NSTextAlignmentCenter;
    rr_label.font = [UIFont systemFontOfSize:13];
    rr_label.numberOfLines = 0;
    rr_label.text = self.str;
    self.rr_height = Height + 10;
//    self.rr_width = screenW;
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableHeaderView = self;
    self.frame = CGRectMake(0, 0, screenW, Height + 10);
    [tableView reloadData];
}

@end
