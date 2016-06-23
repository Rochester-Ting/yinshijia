//
//  RRType2Row5Cell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 27/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRType2Row5Cell.h"

@interface RRType2Row5Cell ()
@property (weak, nonatomic) IBOutlet UILabel *labelrr;

@end
@implementation RRType2Row5Cell
- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    self.labelrr.text = arr[0];
}

@end
