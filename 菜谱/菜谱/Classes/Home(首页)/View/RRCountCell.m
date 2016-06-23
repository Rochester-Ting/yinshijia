//
//  RRCountCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRCountCell.h"

@interface RRCountCell ()
@property (weak, nonatomic) IBOutlet UIButton *minus;
@property (weak, nonatomic) IBOutlet UIButton *add;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@end
@implementation RRCountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.minus.layer.borderWidth = 1;
    self.add.layer.borderWidth = 1;
    self.minus.layer.cornerRadius = 25;
    self.add.layer.cornerRadius = 25;
    self.minus.layer.borderColor = [UIColor redColor].CGColor;
    self.add.layer.borderColor = [UIColor redColor].CGColor;
    self.minus.enabled = NO;
    
}

- (IBAction)minusClick:(id)sender {
    NSInteger num =  self.accountLabel.text.integerValue;
    num--;
    self.accountLabel.text = [NSString stringWithFormat:@"%zd",num];
    self.minus.enabled = num > 1;
    if (_minusBlock) {
        _minusBlock(self.accountLabel.text);
    };
}
- (IBAction)addClick:(id)sender {
    NSInteger num =  self.accountLabel.text.integerValue;
    num++;
    self.accountLabel.text = [NSString stringWithFormat:@"%zd",num];
    self.minus.enabled = num > 1;
    if (_countBlock) {
        _countBlock(self.accountLabel.text);
    };
    
}

@end
