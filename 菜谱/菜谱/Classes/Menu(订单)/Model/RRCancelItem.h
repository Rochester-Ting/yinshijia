//
//  RRCancelItem.h
//  菜谱
//
//  Created by 丁瑞瑞 on 17/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RRCity.h"
@interface RRCancelItem : NSObject

@property (nonatomic,strong) NSString *themeTitle;

@property (nonatomic,strong) NSString *createtime;
/** <#注释#>*/
@property (nonatomic,strong) NSArray *customOrder_address;


//@property (nonatomic,strong) RRCity *customOrder_address;
@end
