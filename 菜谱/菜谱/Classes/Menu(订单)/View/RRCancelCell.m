//
//  RRCancelCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 17/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRCancelCell.h"
#import "RRCity.h"
#import "RRCancelItem.h"
@interface RRCancelCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
@implementation RRCancelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(RRCancelItem *)item
{
    _item = item;
    self.name.text = item.themeTitle;
//    RRCity *city = item.customOrder_address;
//    self.address.text = city.area;
    self.address.text = item.customOrder_address[0][@"area"];
    self.time.text = item.createtime;
    
    
}
@end
