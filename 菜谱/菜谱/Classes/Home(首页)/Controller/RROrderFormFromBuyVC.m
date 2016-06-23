//
//  RROrderFormFromBuyVC.m
//  菜谱
//
//  Created by 丁瑞瑞 on 16/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RROrderFormFromBuyVC.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
@interface RROrderFormFromBuyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RROrderFormFromBuyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"填写订单";
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"rui"];
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"名称:%@",_name];
    }else if (indexPath.row == 1){
        cell.textLabel.text = [NSString stringWithFormat:@"数量:%zd",_account];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"总价格:%@",_price];
    }
    return cell;
}

- (IBAction)buyClick:(id)sender {
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088711358428476"; /** 合作商户ID  PID */
    NSString *seller = @"zhaiyaogang@itzl.org"; /** 支付宝账号ID  */
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKm6rsiIsVDcxd1kWvJ4L0R5g7esfTbYpiFMeoiiiYMzFhh0uZXOPB10IHDDhTilEo93rBbFlTQojRnbKooRM8jpoJoLpyKfVEFxGrZip1izFKREExfeA+RuUKe5xxetwtVdY5xArIXBFkwD+E/DvwtlhxHDYHU/x39Ebr8NWXvDAgMBAAECgYBVRG/iVqmd0gulOXFnNnGomNNPRtxw3U44lE9KrT0gKF4FUz6Yv877jQdvHwqidmton9pYZlKarXSVdMFeM14r047W4YoDF9ZaCRE7efpwX9gq+T3DF/cpIj2RMyXdouzuK/5oKjK9NdA/AAoIkSENr57NnWCuELQXgGDJ0GnY4QJBANYZ+nU8eOLxJ5YYxjL0V4WqSyO1gq2Bw4oy7JICVIqrHtpXGjbOdd/Y5TLaIj309Vo0TT7/sWFrsHILpiffhb8CQQDK8cAl+enigcDAw2NU8cf2lBicLTd3R15OdrfSZqw9an9sVwbmuxOzekMELeEsg6ZCNuQFnqmLrERaNPy1bTL9AkEAhZ81B1I0iD7F3BGeMVL6BLwhpSm1YyBnr6rUptO5e8oMuWw/OhFk084ETdaCJHTrY97cjwL567lQJ/1JN/1y9QJAKK8CCBrrih7c10fUF+lIXuQdcuGVpvHFtBEUlLdEfCNnW/6uQX7rWiV+Xc4cv+G8aLW8TGwcLQXhxfutVWmIuQJAY9ks4deUPSaRIEwHuMvTGvmRzy/9Smj5RiWPaGW7jYUOl6wFjeTCtECDR/wH94/uOLMxf6/9uvOIJQNHUxLeBw=="; /** 商户私钥 自助生成 */
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = _name; //商品标题
    order.productDescription = _name; //商品描述
    order.amount = _price; //商品价格
    order.notifyURL =  @"http://www.baidu.com"; //回调URL 异步通知服务器支付结果，便于服务器更新订单状态
    
    //实际项目开发中 订单信息应该由服务器返回
    
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme 便于支付结束后重新打开客户端
    NSString *appScheme = @"alipayCaipu";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
//        NSLog(@"签名字符串:%@",orderString);
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"支付结果reslut = %@",resultDic);
        }];
    }

}
- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


@end
