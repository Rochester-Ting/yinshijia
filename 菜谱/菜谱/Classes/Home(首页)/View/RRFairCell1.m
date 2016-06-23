//
//  RRFairCell1.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRFairCell1.h"

@interface RRFairCell1 ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation RRFairCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setArr:(NSArray *)arr{
    _arr = arr;
    self.titleLabel.text = arr[0];
    self.priceLabel.text = arr[2];
    self.contentLabel.text = arr[1];
}
@end
