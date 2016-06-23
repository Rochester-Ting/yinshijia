//
//  RRFairDetailCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 14/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRFairDetailCell.h"
#import "RRFairDetailItem.h"
@interface RRFairDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

@end

@implementation RRFairDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setItem:(RRFairDetailItem *)item
{
    _item = item;
    self.nameLabel.text = item.title;
    self.introduceLabel.text = item.value;
}
@end
