//
//  RRMeCell.h
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRMeCell : UITableViewCell
/** block*/
@property (nonatomic,strong) void(^btnBlock)(NSString *str);
@end
