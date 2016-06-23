//
//  RRPicTableCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 23/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRPicTableCell.h"

@interface RRPicTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *www;

@end
@implementation RRPicTableCell

- (void)setDes:(NSString *)des
{
    _des = des;
    self.www.text = des;
}
@end
