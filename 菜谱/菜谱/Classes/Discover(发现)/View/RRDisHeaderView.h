//
//  RRDisHeaderView.h
//  菜谱
//
//  Created by 丁瑞瑞 on 22/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RRDisItem;
@interface RRDisHeaderView : UIView
/** 数组*/
//@property (nonatomic,strong) RRDisItem *item;
/** <#注释#>*/
@property (nonatomic,strong) NSArray *arr;

/** block*/
@property (nonatomic,strong) void(^btnBlock)(NSString *str,NSString *title);
@end
