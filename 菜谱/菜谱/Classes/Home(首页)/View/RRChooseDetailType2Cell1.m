//
//  RRChooseDetailType2Cell1.m
//  菜谱
//
//  Created by 丁瑞瑞 on 24/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//
//type2 cell1
#import "RRChooseDetailType2Cell1.h"
#import <UIImageView+WebCache.h>
@interface RRChooseDetailType2Cell1 ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *tagLabel;

@end
@implementation RRChooseDetailType2Cell1

-(void)awakeFromNib
{
    self.iconImageView.layer.cornerRadius = self.iconImageView.rr_width * 0.5;
    self.iconImageView.clipsToBounds = YES;
}
-(void)setArr:(NSArray *)arr
{
    _arr = arr;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:arr[3]]];
    self.titleLabel.text = arr[0];
    self.nameLabel.text = arr[1];
    self.contentLabel.text = arr[2];
    [self.tagLabel setTitle:arr[4] forState:UIControlStateNormal];;
}
@end
