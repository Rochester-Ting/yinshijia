//
//  RRPlainMenu.m
//  菜谱
//
//  Created by 丁瑞瑞 on 26/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRPlainMenu.h"

@implementation RRPlainMenu
- (CGFloat)cellHeiht
{
    if (_cellHeiht) {
        return _cellHeiht;
    }
    _cellHeiht += 15;
    CGSize maxSize = CGSizeMake(screenW - 4*RRMargin, MAXFLOAT);
    NSDictionary *dict = @{NSAttachmentAttributeName : [UIFont systemFontOfSize:12]};
    _cellHeiht += [_des boundingRectWithSize:maxSize options:0 attributes:dict context:nil].size.height;
    return _cellHeiht;
}
@end
