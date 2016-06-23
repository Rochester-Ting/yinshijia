//
//  RRType1Row1Cell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 27/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRType1Row1Cell.h"

@interface RRType1Row1Cell ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
@implementation RRType1Row1Cell

- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元/位",arr[0]];
    self.dateLabel.text = arr[1];
}

@end
