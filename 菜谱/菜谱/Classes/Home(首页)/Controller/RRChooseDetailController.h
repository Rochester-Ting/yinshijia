//
//  RRChooseDetailController.h
//  菜谱
//
//  Created by 丁瑞瑞 on 24/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRChooseDetailController : UIViewController

/** block获取dinnerID*/
@property (nonatomic,copy) void(^dinnerId)(NSString *value);
/** dinnerid*/
@property (nonatomic,strong) NSString *dinnerNum;
/** dinnerType*/
@property (nonatomic,assign) NSInteger type;
@end
