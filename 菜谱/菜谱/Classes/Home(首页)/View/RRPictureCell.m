//
//  RRPictureCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 23/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRPictureCell.h"
#import <UIImageView+WebCache.h>
#import "RRPicItem.h"
#import "RRDisCoverBtnItem.h"
#import <DALabeledCircularProgressView.h>
@interface RRPictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UIButton *whereBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end
@implementation RRPictureCell

- (void)awakeFromNib {
    self.whereBtn.layer.borderWidth = 0.8;
    self.whereBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.whereBtn.layer.cornerRadius = 4;
    self.whereBtn.clipsToBounds = YES;
    
}
- (void)setItem:(RRPicItem *)item
{
    _item = item;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:item.dinner_imageurl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress];
        self.progressView.progressTintColor = [UIColor blackColor];
        self.progressView.progressLabel.textColor = [UIColor blackColor];
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    self.des.text = item.dinner_title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@/位",item.dinner_price];
    [self.whereBtn setTitle:item.dinner_district forState:UIControlStateNormal];
    self.dateLabel.text = [NSString stringWithFormat:@"%@ -> %@",item.dinner_datetime,item.dinner_endOrderTime];
}

- (void)setDisItem:(RRDisCoverBtnItem *)disItem
{
    _disItem = disItem;
    NSString *imageUrl = [disItem.dinnerImage componentsSeparatedByString:@","].firstObject;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress];
        self.progressView.progressTintColor = [UIColor blackColor];
        self.progressView.progressLabel.textColor = [UIColor blackColor];
        self.progressView.hidden = NO;
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    self.des.text = disItem.dinnerTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@/%@",disItem.dinnerPrice,disItem.unit];
    [self.whereBtn setTitle:disItem.dinnerDistrict forState:UIControlStateNormal];
    self.dateLabel.text = [NSString stringWithFormat:@"%@ -> %@",disItem.dinnerStartTime,disItem.dinnerEndTime];
}
@end
