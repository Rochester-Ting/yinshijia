//
//  RRHeaderView.h
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRHeaderView : UIView
/** 数组*/
@property (nonatomic,strong) NSArray *urlArrM;

/** block*/
@property (nonatomic,copy) void(^headViewBlock)(NSString *value, NSString *value2);


@property (nonatomic,copy) void(^chefBlock)(NSString *value, NSString *value2);

@end
