//
//  RRAnimatedTransition.h
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL presented;
/** 哪个*/
@property (nonatomic,assign) BOOL isTabBar;
@property (nonatomic,assign) BOOL isBuy;

@end
