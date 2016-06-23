//
//  RRChefDetailVC.h
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRChefDetailVC : UIViewController
/** userID*/
@property (nonatomic,strong) NSString *UserId;
/** name*/
@property (nonatomic,strong) NSString *name;


@property (nonatomic,strong) NSArray *arr;



@property (nonatomic,assign) NSInteger yuding;

@property (nonatomic,assign) NSInteger xihuan;
@end