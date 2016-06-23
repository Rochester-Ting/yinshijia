//
//  RRChefCell4.m
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChefCell4.h"
#import <UIImageView+WebCache.h>

@interface RRChefCell4()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation RRChefCell4

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    self.title.text = arr[0];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:arr[2]]];
    self.introLabel.text = arr[1];
}

- (CGFloat)cellH
{
    if (_cellH) {
        return _cellH;
    }
    _cellH += 360;
    CGSize maxSize = CGSizeMake(screenW - 20, MAXFLOAT);
    _cellH += [self.introLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
    return _cellH;
}
@end
