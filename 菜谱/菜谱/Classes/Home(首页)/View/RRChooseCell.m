//
//  RRChooseCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChooseCell.h"
#import <UIImageView+WebCache.h>
#import "RRChooseItem.h"
#import "NSString+RRString.h"
#import <DACircularProgressView.h>
#import <DALabeledCircularProgressView.h>
@interface RRChooseCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ChefImageView;
//菜的样式图片
@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
//文本内容
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
//所在地区
@property (weak, nonatomic) IBOutlet UILabel *whereLabel;
//日期
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//价钱
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;


@end
@implementation RRChooseCell

-(void)awakeFromNib
{
    self.ChefImageView.layer.cornerRadius = self.ChefImageView.rr_width * 0.5;
    self.ChefImageView.clipsToBounds = YES;
}
- (void)setChooseItem:(RRChooseItem *)chooseItem
{
    _chooseItem = chooseItem;
    if (chooseItem.dinnerType == 1) {
        [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:chooseItem.imageurl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            CGFloat progress = 1.0 * receivedSize / expectedSize;
            self.progressView.hidden = NO;
            self.progressView.progress = progress;
            self.progressView.progressLabel.textColor = [UIColor blackColor];
//            self.progressView.trackTintColor = [UIColor blackColor];
            self.progressView.progressTintColor = [UIColor grayColor];
            self.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.0f%%",progress * 100];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
             self.progressView.hidden = YES;
        }];
        self.contentLabel.text = chooseItem.title;
        self.whereLabel.text = chooseItem.district;
        self.moneyLabel.text = chooseItem.price;
        [self.ChefImageView sd_setImageWithURL:[NSURL URLWithString:chooseItem.chefImageurl]];
        
        self.dateLabel.text = chooseItem.datetime.subStringLast;
    }else{
        [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:chooseItem.themeDinnerImageurl.subString]  placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            CGFloat progress = 1.0 * receivedSize / expectedSize;
            self.progressView.hidden = NO;
            self.progressView.progress = progress;
//            self.progressView.trackTintColor = [UIColor blackColor];
            self.progressView.progressTintColor = [UIColor grayColor];
            self.progressView.progressLabel.textColor = [UIColor blackColor];
            self.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.0f%%",progress * 100];
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.progressView.hidden = YES;
        }];
        self.contentLabel.text = chooseItem.themeDinnerTitle;
        self.whereLabel.text = chooseItem.themeDinnerDistrict;
        self.moneyLabel.text = chooseItem.themeDinnerMinPrice;
        [self.ChefImageView sd_setImageWithURL:[NSURL URLWithString:chooseItem.themeDinnerChefImageurl]];
        self.dateLabel.text = [NSString stringWithFormat:@"%@-%@",chooseItem.themeDinnerStartTime.subStringMiddle,chooseItem.themeDinnerEndTime.subStringMiddle];
    }
    
}

@end
