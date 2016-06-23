//
//  RRPictureCell.h
//  菜谱
//
//  Created by 丁瑞瑞 on 23/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RRPicItem;
@class RRDisCoverBtnItem;
@interface RRPictureCell : UITableViewCell
/** 模型字典*/
@property (nonatomic,strong) RRPicItem *item;
@property (nonatomic,strong) RRDisCoverBtnItem *disItem;
@end
