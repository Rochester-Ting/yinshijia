//
//  RRFairViewCell.h
//  菜谱
//
//  Created by 丁瑞瑞 on 21/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RRFairItem;
@interface RRFairViewCell : UICollectionViewCell
/**模型*/
@property (nonatomic,strong) RRFairItem *fairItem;

@end
