//
//  RRFairCell4.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRFairCell4.h"

@interface RRFairCell4 ()
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end
@implementation RRFairCell4

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setArr:(NSArray *)arr
{
    _arr = arr;
    self.desLabel.text = arr[0];
}
@end
