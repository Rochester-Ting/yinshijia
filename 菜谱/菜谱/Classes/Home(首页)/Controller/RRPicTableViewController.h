//
//  RRPicTableViewController.h
//  菜谱
//
//  Created by 丁瑞瑞 on 13/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRPicTableViewController : UITableViewController
/** value*/
@property (nonatomic,strong) NSString *value;
/** value2*/
@property (nonatomic,strong) NSString *des;
/** block回调,如果没有模型*/
@property (nonatomic,copy) void(^blockValue)(NSString *value);
@end
