//
//  RRChooseDetailCell1.m
//  菜谱
//
//  Created by 丁瑞瑞 on 24/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRChooseDetailCell1.h"


@interface RRChooseDetailCell1 ()
@property (weak, nonatomic) IBOutlet UILabel *bigTitle;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIButton *biaoqian1;
@property (weak, nonatomic) IBOutlet UIButton *biaoqian2;

@end
@implementation RRChooseDetailCell1
- (void)setUrlArray:(NSArray *)urlArray
{
    _urlArray = urlArray;
    self.bigTitle.text = urlArray[0];
    self.desLabel.text = urlArray[1];
    NSString *str = urlArray[2];
    NSArray *arr = [str componentsSeparatedByString:@","];
    [self.biaoqian1 setTitle:arr[0] forState:UIControlStateNormal];
    [self.biaoqian2 setTitle:arr[1] forState:UIControlStateNormal];
}
//- (void)setDes:(NSString *)des
//{
//    _des = des;
//    self.desLabel.text = des;
//}
- (CGFloat)height1
{
    if (_height1) {
        return _height1;
    }
    _height1 += 22.5 + 20 + 40;
    CGSize Maxsize = CGSizeMake(screenW - 20, MAXFLOAT);
    NSDictionary *dict = @{NSAttachmentAttributeName : [UIFont systemFontOfSize:12]};
    _height1 += [self.desLabel.text boundingRectWithSize:Maxsize options:0 attributes:dict context:nil].size.height;
    return _height1;
    
}
@end
