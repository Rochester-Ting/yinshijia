//
//  RRCollectionViewCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 13/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "chefViewItem.h"
#import <DALabeledCircularProgressView.h>
@interface RRCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *rr_imageView;
@property (weak, nonatomic) IBOutlet UILabel *introductionLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 进度条*/
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@end
@implementation RRCollectionViewCell

- (void)setChefItem:(chefViewItem *)chefItem
{
    _chefItem = chefItem;

    [self.rr_imageView sd_setImageWithURL:[NSURL URLWithString:chefItem.imageurl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        计算进度
        /*
        self.progressView.hidden = NO;
        NSInteger progress = receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%zd%%",progress * 100];
        self.progressView.progressLabel.textColor = [UIColor blackColor];
        self.progressView.trackTintColor = [UIColor redColor];
        self.progressView.tintColor = [UIColor greenColor];
         */
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
    self.introductionLabel.text = chefItem.introduce;
    self.nameLabel.text = chefItem.name;
    self.likeLabel.text = [NSString stringWithFormat:@"%zd人预定 | %zd人喜欢",chefItem.orderedCount,chefItem.likeCount];
}

@end
