//
//  RRMeViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRMeViewController.h"
#import "RRMeCell.h"
#import <SVProgressHUD.h>
#import <AFHTTPSessionManager.h>
#import <UIImageView+WebCache.h>
@interface RRMeViewController ()<UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** uibutton*/
@property (nonatomic,strong) UIButton *btn;
@property(nonatomic,strong)AFHTTPSessionManager *manager;

@property(nonatomic,strong)UIImageView *headerImage;
@property(nonatomic,strong)UIImage *photo;
@end

@implementation RRMeViewController
static NSString *MEID = @"SSS";
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return _manager;
}

- (UIButton *)btn
{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRMeCell class]) bundle:nil] forCellReuseIdentifier:MEID];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.scrollEnabled = NO;
    
    
    self.headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 30, 70, 70)];
    self.headerImage.image = [UIImage imageNamed:@"menu_invite"];
    self.headerImage.userInteractionEnabled = YES;
    self.headerImage.layer.cornerRadius = 35;
    self.headerImage.clipsToBounds = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    重新获取登录信息
    NSString *strUrl = [NSString stringWithFormat:@"http://112.65.246.170/goodluck/molog?usnm=13280981028&pwd=123456"];
    
    [self.manager GET:strUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"code"] isEqualToString:@"1001"]) {
            NSString *url = [NSString stringWithFormat:@"%@/%@",server_ip,responseObject[@"user"][@"img"]];
            [self.headerImage sd_setImageWithURL:[NSURL URLWithString:url]];
            self.headerImage.layer.cornerRadius = 35;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 5;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UUU"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UUU"];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell addSubview:self.headerImage];
            [self.headerImage  addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handlePhotoImageAction)]];
            return cell;
        }else if (indexPath.row == 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = cell.bounds;
            [cell addSubview:btn];
            [btn setTitle:@"口味与偏好" forState:UIControlStateNormal];
            btn.tag = 1;
        }else if(indexPath.row == 2){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = cell.bounds;
            [cell addSubview:btn];
            [btn setTitle:@"我的关注" forState:UIControlStateNormal];
            btn.tag = 2;
        }else if(indexPath.row == 3){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = cell.bounds;
            [cell addSubview:btn];
            [btn setTitle:@"我的优惠券" forState:UIControlStateNormal];
            btn.tag = 3;
        }else if (indexPath.row == 4){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitle:@"" forState:UIControlStateNormal];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = cell.bounds;
            [cell addSubview:btn];
            [btn setTitle:@"我的钱包" forState:UIControlStateNormal];
            btn.tag = 4;
        }else if (indexPath.row == 5){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = cell.bounds;
            [cell addSubview:btn];
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setTitle:@"礼物卡" forState:UIControlStateNormal];
            btn.tag = 5;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = cell.bounds;
            
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setTitle:@"联系客服" forState:UIControlStateNormal];
            btn.tag = 10;
            [cell addSubview:btn];


        }else if(indexPath.row == 1){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.frame = cell.bounds;
            [btn setTitle:@"" forState:UIControlStateNormal];
            [btn setTitle:@"反馈和意见" forState:UIControlStateNormal];
            btn.tag = 11;
            [cell addSubview:btn];


        }else if(indexPath.row == 2){
            self.btn.frame = cell.bounds;
            
            [self.btn setTitle:@"" forState:UIControlStateNormal];
            [self.btn setTitle:@"邀请好友" forState:UIControlStateNormal];
            self.btn.tag = 12;
            [cell addSubview:self.btn];
        }
    }
    return cell;
}

- (void)btnClick:(UIButton *)sender{
    if (sender.tag == 0) {
//        口味和偏好
        [SVProgressHUD showErrorWithStatus:@"这个没做"];
    }else if (sender.tag == 1){
//        我的关注
    }else if (sender.tag == 2){
//        我的优惠券
        [SVProgressHUD showErrorWithStatus:@"这个没做"];
    }else if (sender.tag == 3){
//        我的钱包
        [SVProgressHUD showErrorWithStatus:@"这个没做"];
    }else if (sender.tag == 10){
//        联系客服
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10010"]];
    }else if (sender.tag == 11){
        [SVProgressHUD showErrorWithStatus:@"这个没做"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"这个没做"];
    }
}

//弹出的alertSheet
-(void)handlePhotoImageAction{
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中获取", nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}


#pragma mark - uialertDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self snapImage]; // 点击拍照调用
    }
    if (buttonIndex == 1) {
        [self pickImage]; // 点击从相册获取调用
    }
    return;
}
//拍照
- (void) snapImage
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //如果没有相机,直接返回
        NSLog(@"sorry, no camera or camera is unavailable.");
        return;
    }
    //如果有相机直接打开相机
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    ipc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:ipc animated:YES completion:nil];
}
//相册
- (void) pickImage
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate =self;
    ipc.allowsEditing = YES;
    ipc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:ipc animated:YES completion:nil];
}
//让选择的照片可以缩放
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
//弹出相册
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.photo = [self imageWithImageSimple:image scaledToSize:CGSizeMake(240.0, 240.0)];
    
    
//    [self.headerImage  setImage:self.photo];
    self.headerImage.image = self.photo;
    [self updateTypeImage:self.photo];
    
    [self dismissViewControllerAnimated:YES completion:^{ }];
    
}
-(void)updateTypeImage:(UIImage *)image
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:@"userID"];
    
    int uid = [userID intValue];
    int dir0 = uid/1000;
    
    NSString *filePath = [NSString stringWithFormat:@"user%d-%d-t%d.png",dir0,uid,1];
    //    NSLog(@"filePath == %@",filePath);
    [self saveImage:image WithName:filePath];
    
    NSString *urlString = @"http://112.65.246.170/goodluck/changeUserInfo?type=1&uid=46";
    [self updateImage:image url:urlString];
    
}
- (NSString *)updateImage:(UIImage *)image url:(NSString *)urlString
{
    NSData *imageData = UIImagePNGRepresentation(image);
    
    //    NSLog(@"urlString=%@",urlString);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSMutableData *body = [NSMutableData data];
    [request addValue:@"binary/octet-stream" forHTTPHeaderField: @"Content-Type"];
    [body appendData:[NSData dataWithData:imageData]];
    
    [request setHTTPBody:body];
    // now lets make the connection to the web
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"returnString=%@",returnString);//服务器返回数据
    return returnString;
}

#pragma mark保存图片到document
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    
    [imageData writeToFile:fullPathToFile atomically:NO];
}

- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0 && indexPath.row == 0) {
        return 120;
    }else{
        return 44;
    }
}
@end
