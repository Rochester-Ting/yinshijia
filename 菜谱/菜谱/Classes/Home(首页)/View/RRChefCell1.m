//
//  RRChefCell1.m
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChefCell1.h"
#import <UIImageView+WebCache.h>
#import "RRChefItem1.h"
#import "SVProgressHUD.h"
@interface RRChefCell1 ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *ydNum;
@property (weak, nonatomic) IBOutlet UILabel *gzNum;
@property (weak, nonatomic) IBOutlet UILabel *plNum;

@end
@implementation RRChefCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setArrT:(NSArray *)arrT
{
    _arrT = arrT;

    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:arrT[0]]];
//    NSString *str = arrT[1];
    self.ydNum.text = arrT[1];
    self.gzNum.text = arrT[2];
    self.plNum.text = [NSString stringWithFormat:@"%@",arrT[3]];
//    [SVProgressHUD showSuccessWithStatus:@"加载成功!"];
   
}
@end
