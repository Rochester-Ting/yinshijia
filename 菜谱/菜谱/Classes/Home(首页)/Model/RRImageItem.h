//
//  RRImageItem.h
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRImageItem : NSObject
/** 图片*/
@property (nonatomic,strong) NSString *banner_image;
/** bannerId*/
@property (nonatomic,strong) NSString *bannerId;
/** title*/
@property (nonatomic,strong) NSString *title;
/** description*/
@property (nonatomic,strong) NSString *des;

@end
