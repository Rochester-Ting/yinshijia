//
//  RROrderFormVC.h
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RROrderFormVC : UIViewController
/** 饭局*/
@property (nonatomic,strong) NSString *fanju;
/** 时间*/
@property (nonatomic,strong) NSString *shijian;
/** 单价*/
@property (nonatomic,strong) NSString *money;
/** 数量*/
@property (nonatomic,strong) NSString *dizhi;
/** 总价*/
@property (nonatomic,strong) NSString *allAccount;
@end
