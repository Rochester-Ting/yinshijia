//
//  RRTitleCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRTitleCell.h"

@interface RRTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation RRTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}
@end
