//
//  RRMenuViewController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRMenuViewController.h"
#import "RRDoneVC.h"
#import "RRWillVC.h"
#import "RRCancelVC.h"
@interface RRMenuViewController ()<UIScrollViewDelegate>
//放btn的view
@property (nonatomic,strong) UIView *titleView;
/** 记录被选中的按钮*/
@property (nonatomic,strong) UIButton *selectedBtn;
/** scrollView*/
@property (nonatomic,strong) UIScrollView *scrollView;
/** lineView*/
@property (nonatomic,strong) UIView *lineView;

@end

@implementation RRMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBar];
    [self addScrollView];
    [self addChildVC];
    [self setTitleView];
    [self addTitleViewWithBtn]; // 设置titleView里面的按钮
    [self addView];
}
- (void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = [UIScreen mainScreen].bounds;
    //    scrollView.backgroundColor = [UIColor redColor];
    scrollView.contentSize = CGSizeMake(RRNum * screenW, 0);
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];

}
- (void)addChildVC{
    //    已完成的订单
    RRDoneVC *doneVC = [[RRDoneVC alloc] init];
    [self addChildViewController:doneVC];
    //    未完成的订单
    RRWillVC *willVC = [[RRWillVC alloc] init];
    [self addChildViewController:willVC];
    //    取消的订单
    RRCancelVC *cancelVC = [[RRCancelVC alloc] init];
    [self addChildViewController:cancelVC];
}
- (void)setTitleView{
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 64, screenW, titleViewH);
    //    titleView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    titleView.backgroundColor = [UIColor whiteColor];

    
}
#pragma mark - 添加titleView里面的按钮
- (void)addTitleViewWithBtn{
    NSArray *arrBtm = @[@"已完成的订单",@"未完成的订单",@"取消的订单"];
    CGFloat buttonW = self.titleView.bounds.size.width / 3;
    CGFloat buttonH = self.titleView.bounds.size.height - lineH;
    for (int i = 0; i < RRNum; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arrBtm[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
        btn.tag = i;
        if (i == 0) {
            btn.selected = YES;
            self.selectedBtn = btn;
            //            添加红色的线
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = self.selectedBtn.titleLabel.textColor;
            //            计算文字的长度
            [btn.titleLabel sizeToFit];
            
            //            lineView.frame = CGRectMake(i * buttonW, self.titleView.rr_height - lineH, btn.titleLabel.rr_width, lineH);
            lineView.rr_y = self.titleView.rr_height - lineH;
            lineView.rr_width = btn.titleLabel.rr_width;
            lineView.rr_height = lineH;
            lineView.rr_centerX = self.selectedBtn.rr_centerX;
            self.lineView = lineView;
            [self.titleView addSubview:lineView];
        }
        [self.titleView addSubview:btn];
        
    }
}

//实现监听btn被点击的方法
- (void)titleBtnClick:(UIButton *)selectBtn{
    self.selectedBtn.selected = NO;
    selectBtn.selected = YES;
    self.selectedBtn = selectBtn;
    //    点击按钮scrollView滚动
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.rr_centerX = selectBtn.rr_centerX;
        [self.scrollView setContentOffset:CGPointMake(screenW * selectBtn.tag, 0) animated:YES];
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - 添加子控制器的view
- (void)addView{
    //    计算高度和宽度
    CGFloat W = self.scrollView.rr_width;
    CGFloat H = self.scrollView.rr_height;
    //    将系统给的额外滚动区域禁止
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    计算索引
    NSInteger index = self.scrollView.contentOffset.x / screenW;
    UIViewController *childVC = self.childViewControllers[index];
    //    如果已经被加载过了,那么返回
    if ([childVC isViewLoaded]) {
        return;
    }
    childVC.view.frame = CGRectMake(index * W, 0, W, H);
    [self.scrollView addSubview:childVC.view];
}


- (void)setTabBar{
    self.tabBarItem.title = @"订单";
    self.tabBarItem.image = [UIImage imageNamed:@"dock_order_unselected"];
    self.tabBarItem.selectedImage = [UIImage imageNamed:@"dock_order_selected"];
}

#pragma mark - ScrollView的代理方法
//当拖拽减速的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //    计算拖拽的位移距离
    int index = scrollView.contentOffset.x / screenW;
    //    取出按钮
    UIButton *btn = self.titleView.subviews[index + 1];
    [self titleBtnClick:btn];
    [self addView];
}
//动画减速的时候调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addView];
}



@end
