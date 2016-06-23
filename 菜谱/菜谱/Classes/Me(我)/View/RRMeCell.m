//
//  RRMeCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRMeCell.h"

@interface RRMeCell ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation RRMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (IBAction)iconBtn:(id)sender {
//    if (_btnBlock) {
//        _btnBlock(@"123");
//    }
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中获取", nil];
//    actionSheet.delegate = self;
//    [actionSheet showInView:self.superview];
}


@end
