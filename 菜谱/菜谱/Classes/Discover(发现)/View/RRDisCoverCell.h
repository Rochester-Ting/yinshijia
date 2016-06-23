//
//  RRDisCoverCell.h
//  菜谱
//
//  Created by 丁瑞瑞 on 22/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RRDisItem;
@interface RRDisCoverCell : UITableViewCell
/** 模型*/
@property (nonatomic,strong) RRDisItem *disItem;
/** id*/
@property (nonatomic,assign) NSInteger i;
@end
