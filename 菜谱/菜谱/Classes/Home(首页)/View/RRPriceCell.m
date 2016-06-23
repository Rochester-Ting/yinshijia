//
//  RRPriceCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRPriceCell.h"
#import "RRCountCell.h"
#import "UIView+RRLoad.h"
@interface RRPriceCell ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation RRPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setPrice:(NSString *)price
{
    _price = price;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",price];
    
}
@end
