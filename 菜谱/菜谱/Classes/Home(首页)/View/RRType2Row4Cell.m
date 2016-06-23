//
//  RRType2Row4Cell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 27/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRType2Row4Cell.h"
#import <UIImageView+WebCache.h>
#import "RRMapController.h"
@interface RRType2Row4Cell ()
@property (weak, nonatomic) IBOutlet UIImageView *addressImage;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;

@end
@implementation RRType2Row4Cell
- (void)setArr:(NSArray *)arr
{
    _arr = arr;
    
    [self.addressImage sd_setImageWithURL:[NSURL URLWithString:arr[0]]];
    if (arr.count == 1) {
        return;
    }
    [self.addressBtn setTitle:arr[1] forState:UIControlStateNormal];
}
- (IBAction)addressBtnClick:(id)sender {
    if (_cellBlock) {
        _cellBlock(@"22");
    }
   
    
}

@end
