//
//  RRChooseCell.h
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RRChooseItem;
@interface RRChooseCell : UITableViewCell
/** 模型*/
@property (nonatomic,strong) RRChooseItem *chooseItem;
@end
