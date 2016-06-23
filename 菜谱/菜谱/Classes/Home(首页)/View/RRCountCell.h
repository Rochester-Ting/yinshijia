//
//  RRCountCell.h
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRCountCell : UITableViewCell
/** block*/
@property (nonatomic,strong) void(^countBlock)(NSString *str);
@property (nonatomic,strong) void(^minusBlock)(NSString *str);
@end
