//
//  RRType2Row3TableViewCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 27/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRType2Row3TableViewCell.h"


@interface RRType2Row3TableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *dingdanLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *whereLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkingLabel;

@end
@implementation RRType2Row3TableViewCell

- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    
    self.dingdanLabel.text = arr[0];
    if (arr.count == 1) {
        self.whereLabel.text = @"暂无饭局信息";
        return;
    }
    self.timeLabel.text = arr[1];
    self.whereLabel.text = arr[2];
    self.parkingLabel.text = arr[3];
}
@end
