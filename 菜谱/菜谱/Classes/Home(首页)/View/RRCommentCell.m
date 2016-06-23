//
//  RRCommentCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 11/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRCommentCell.h"
#import "RRCommetItem.h"
#import <UIImageView+WebCache.h>
@interface RRCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
@implementation RRCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageV.layer.cornerRadius = self.headImageV.rr_width * 0.5;
    self.headImageV.clipsToBounds = YES;
}
- (void)setComment:(RRCommetItem *)comment
{
    _comment = comment;
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:comment.headImageurl]];
    self.nameLabel.text = comment.name;
    self.dateLabel.text = comment.createtime;
    self.account.text = [NSString stringWithFormat:@"%@分",comment.rank];
    self.contentLabel.text = comment.content;
}
@end
