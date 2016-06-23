//
//  RRBuyVC.h
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RRBuyVC : UIViewController
/** title*/
@property (nonatomic,strong) NSString *titleLabel;
/** price*/
@property (nonatomic,strong) NSString *priceLabel;
/** price*/
@property (nonatomic,strong) NSString *onePrice;


/** <#注释#>*/
@property (nonatomic,strong) void(^buyBlock)(NSString *name,NSString *price,NSInteger account);

@end
