//
//  RRTransition.h
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
@interface RRTransition : NSObject
SingleH(RRTransition)
/** frame*/
@property (nonatomic,assign) CGRect rr_frame;
/** 哪个*/
@property (nonatomic,assign) BOOL isTabBar;
@property (nonatomic,assign) BOOL isBuy;

@end
