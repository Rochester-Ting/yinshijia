//
//  RRType2Row4Cell.h
//  菜谱
//
//  Created by 丁瑞瑞 on 27/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRType2Row4Cell : UITableViewCell
/** <#注释#>*/
@property (nonatomic,strong) NSArray *arr;


/** <#注释#>*/
@property (nonatomic,strong) void(^cellBlock)(NSString *str);
@end
