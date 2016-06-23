//
//  RRType2Row3Cell.m
//  菜谱
//
//  Created by 丁瑞瑞 on 26/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRType2Row3Cell.h"
#import "RRMenu.h"
#import "UIView+RRLoad.h"
@interface RRType2Row3Cell ()
/** titleView*/
@property (nonatomic,strong) UIView *titleView;
/** 被选中的按钮*/
@property (nonatomic,strong) UIButton *selectedBtn;
/** lineView*/
@property (nonatomic,strong) UIView *lineView;
/** <#注释#>*/
@property (nonatomic,strong) UIScrollView *scrollView;
@end
@implementation RRType2Row3Cell

//- (instancetype)init{
//    if (self = [super init]) {
////        设置titleView
//        [self setTitleView];
//    }
//    return self;
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.rr_height = 400;
        [self setScrollView];
        [self setTitleView];
//        [self addView:self.selectedBtn];
    }
    return self;
}
- (void)setScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.bounds;
    scrollView.rr_width = screenW;
    scrollView.backgroundColor = [UIColor greenColor];
    self.scrollView = scrollView;
    [self addSubview:scrollView];
}
- (void)setTitleView{
    UIView *titleView = [[UIView alloc] init];
    self.titleView = titleView;
    titleView.frame = CGRectMake(0, 0, screenW, 44);
//    titleView.backgroundColor = [UIColor redColor];
//    添加按钮
    [self setBtn];
    
    [self addSubview:titleView];
}

- (void)setBtn{
    NSArray *arrTitle = @[@"菜单",@"环境",@"信息"];
    NSInteger index = 3;
    CGFloat btnW = screenW / index;
    CGFloat btnH = 43;
    CGFloat btnY = 0;
    for (int i = 0; i < index; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnW, btnY, btnW, btnH);
        [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [btn sizeToFit];
        if (i == 0) {
            btn.selected = YES;
            self.selectedBtn = btn;
            UIView *lineView = [[UIView alloc] init];
            [btn.titleLabel sizeToFit];
            lineView.rr_y = 43;
            lineView.rr_width = btn.titleLabel.rr_width;
            lineView.rr_height = lineH;
            lineView.rr_centerX = self.selectedBtn.rr_centerX;
//            RRLog(@"%@",NSStringFromCGRect(lineView.frame));
            lineView.backgroundColor = self.selectedBtn.titleLabel.textColor;
            self.lineView = lineView;
            [self.titleView addSubview:lineView];
        }
        [self.titleView addSubview:btn];
    }
}

- (void)btnClick:(UIButton *)btn{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.transform = CGAffineTransformMakeTranslation(btn.tag * btn.rr_width, 0);
    }];
    [self addView:btn];
}
- (void)addView:(UIButton *)btn{
    if (btn.tag == 0) {
        
        RRMenu *view = [RRMenu loadWithXib];
//        view.menu = _menu;
        view.backgroundColor = [UIColor redColor];
        view.rr_height = 300;

        view.frame = CGRectMake(0, 44, screenW, 300);
//        self.rr_height = 400;
        [self layoutIfNeeded];
        [self.scrollView addSubview:view];
    }else {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake(0, 44, screenW, 200);
        [self.scrollView addSubview:view];
    }
}
@end
