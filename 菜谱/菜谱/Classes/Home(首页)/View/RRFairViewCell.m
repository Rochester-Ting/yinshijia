//
//  RRFairViewCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 21/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRFairViewCell.h"
#import <DACircularProgress/DALabeledCircularProgressView.h>
#import <UIImageView+WebCache.h>
#import "RRFairItem.h"
@interface RRFairViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation RRFairViewCell

- (void)setFairItem:(RRFairItem *)fairItem
{
    _fairItem = fairItem;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:fairItem.properties_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        //        计算进度
        NSInteger progress = receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%zd%%",progress * 100];
        self.progressView.progressLabel.textColor = [UIColor blackColor];
        self.progressView.progressTintColor = [UIColor grayColor];
        self.progressView.trackTintColor = [UIColor blackColor];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    self.desLabel.text = fairItem.title;
    self.priceLabel.text = fairItem.subtitle;
    
}

@end
