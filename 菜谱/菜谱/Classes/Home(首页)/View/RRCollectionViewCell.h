//
//  RRCollectionViewCell.h
//  菜谱
//
//  Created by 丁瑞瑞 on 13/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>
@class chefViewItem;
@interface RRCollectionViewCell : UICollectionViewCell
/** 模型*/
@property (nonatomic,strong) chefViewItem *chefItem;
@end
