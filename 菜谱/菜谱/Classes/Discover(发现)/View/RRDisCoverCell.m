//
//  RRDisCoverCell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 22/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRDisCoverCell.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "RRDisItem.h"
#import <FMDB.h>
#import "RRSqlite.h"
#import <AFHTTPSessionManager.h>
#import <SVProgressHUD.h>
@interface RRDisCoverCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIButton *noticeButton;
@property (weak, nonatomic) IBOutlet UILabel *introduce;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *noticeBtn;

/** <#注释#>*/
@property (nonatomic,strong)  AFHTTPSessionManager *manager;
//数据库
@property(nonatomic,strong)FMDatabase *db;
@end
@implementation RRDisCoverCell
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
-(void)awakeFromNib
{
    self.backgroundColor = [UIColor lightGrayColor];
    self.bottomView.layer.cornerRadius = 7;
    self.bottomView.clipsToBounds = YES;
//    UITableViewCellSeparatorStyle
   
//    self.noticeBtn.selected = _disItem.favorite;

    
}
- (void)setDisItem:(RRDisItem *)disItem
{
    _disItem = disItem;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:disItem.imageurl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",progress * 100];
        self.progressView.progressLabel.textColor = [UIColor redColor];
        self.progressView.progressTintColor = [UIColor blackColor];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    self.iconImageView.layer.cornerRadius = self.iconImageView.rr_width * 0.5;
    self.iconImageView.clipsToBounds = YES;
    self.nameLabel.text = disItem.name;
    self.introduce.text = disItem.introduce;
    self.likeLabel.text = [NSString stringWithFormat:@"%zd人预定 | %zd人关注",disItem.orderedCount,disItem.likeCount];
    self.noticeButton.layer.borderWidth = 1;
    self.noticeButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.noticeButton.layer.cornerRadius = 4;
    self.noticeButton.clipsToBounds = YES;
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *uerId = [NSString stringWithFormat:@"%zd",_disItem.userId];
    NSString *favorite = [user objectForKey:uerId];
    
    if ([favorite isEqualToString:@"1"]) {
        self.noticeBtn.selected = YES;
    }else{
        self.noticeBtn.selected = NO;
    }
}
- (IBAction)noticeBtn:(id)sender {
    self.noticeBtn.selected = !self.noticeBtn.selected;
    if (self.noticeBtn.selected) {
        NSLog(@"选中");
        _disItem.favorite = YES;
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        dictM[@"version"] = @3.4;
        dictM[@"data"] = @"{\"token\":\"9758:562a61d106834e92aecb1521c9313331\"}";
        NSString *url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/api/favorites/cook/add/%@",_disItem.userId];
        [self.manager GET:url parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            if ([code isEqualToString:@"200"]) {
                [SVProgressHUD showInfoWithStatus:@"收藏成功"];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *uerId = [NSString stringWithFormat:@"%zd",_disItem.userId];
                [user setObject:@"1" forKey:uerId];
                [user setObject:@"0" forKey:@"notice"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *er = [NSString stringWithFormat:@"%@",error];
            [SVProgressHUD showErrorWithStatus:er];
            
        }];
    }else{
        
        _disItem.favorite = NO;
        NSLog(@"未选中");
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        dictM[@"version"] = @3.4;
        dictM[@"data"] = @"{\"token\":\"9758:562a61d106834e92aecb1521c9313331\"}";
        NSString *url = [NSString stringWithFormat:@"http://api.yinshijia.com/mobile/api/favorites/cook/remove/%@",_disItem.userId];
        [self.manager GET:url parameters:dictM progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            if ([code isEqualToString:@"200"]) {
                [SVProgressHUD showInfoWithStatus:@"取消收藏成功"];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *uerId = [NSString stringWithFormat:@"%zd",_disItem.userId];
                [user setObject:@"0" forKey:uerId];
                
                [user setObject:@"0" forKey:@"notice"];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSString *er = [NSString stringWithFormat:@"%@",error];
            [SVProgressHUD showErrorWithStatus:er];

        }];
    }
}

@end
