//
//  RRChefHeaderView.h
//  菜谱
//
//  Created by 丁瑞瑞 on 17/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRChefHeaderView : UIView
/** 数组*/
@property (nonatomic,strong) NSArray *urlArrM;




@property (nonatomic,copy) void(^chefBlock)(NSString *value,NSString *name);

@end
