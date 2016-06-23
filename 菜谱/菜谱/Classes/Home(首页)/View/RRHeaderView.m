//
//  RRHeaderView.m
//  菜谱
//
//  Created by 丁瑞瑞 on 12/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRHeaderView.h"
#import <UIImageView+WebCache.h>
#import "RRImageItem.h"
#import "RRChefImageItem.h"
@interface RRHeaderView ()<UIScrollViewDelegate>
/** scrollView*/
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *page;
/** kebianshuzu */
@property (nonatomic,strong) NSMutableArray *arrM;
/** */
@property (nonatomic,strong) UIImageView *imageV;
/** 定时器*/
@property (nonatomic,weak) NSTimer *timer;

@property (nonatomic,assign) NSInteger index;
/** 存放bannerId的数组*/
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) NSMutableArray *arr2;
@end
@implementation RRHeaderView
- (NSMutableArray *)arr
{
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (NSMutableArray *)arr2
{
    if (!_arr2) {
        _arr2 = [NSMutableArray array];
    }
    return _arr2;
}

- (void)setUrlArrM:(NSArray *)urlArrM
{
    _urlArrM = urlArrM;
    self.scrollView.contentSize = CGSizeMake(_urlArrM.count * screenW, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.page.numberOfPages = _urlArrM.count;
    self.scrollView.bounces = NO;
    self.page.tintColor = [UIColor orangeColor];
    [self start];
    
    for (int i = 0; i < _urlArrM.count; i++) {
    //        计算高度
        CGFloat imageH = self.rr_height;
        UIImageView *imageV = [[UIImageView alloc] init];
        RRImageItem *item = nil;
        RRChefImageItem *imageItem = nil;
        NSURL *url = nil;
        self.index = i;
//        _urlArrM.count == 4
        NSObject *obj = _urlArrM[0];
            if ([NSStringFromClass([obj class]) isEqualToString:@"RRImageItem"]) {
                item = _urlArrM[i];
                url = [NSURL URLWithString:item.banner_image];
                imageV.frame = CGRectMake(i * screenW + RRMargin, 0, screenW, imageH);
            }
//            else{
////                RRLog(@"%zd",_urlArrM.count);
//                imageItem = _urlArrM[i];
////                RRLog(@"%@",imageItem.imageurl);
//                url = [NSURL URLWithString:imageItem.imageurl];
//                imageV.frame = CGRectMake(i * screenW, 0, screenW, imageH);
//            }

        if ([NSStringFromClass(item.class) isEqualToString:@"RRImageItem"]) {
            
            [self.arr addObject:item.bannerId];
            [self.arr2 addObject:item.des];
        }
//        imageV.tag = i;
        self.imageV = imageV;
        [imageV sd_setImageWithURL:url];
        [self.scrollView addSubview:imageV];
//        添加点击手势
        imageV.userInteractionEnabled = YES;

        
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tap];
    }
   
}
//创建监听器
- (void)start{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}
#pragma mark - 实现手势点击的监听
- (void)tap:(UITapGestureRecognizer *)tap
{
//    RRLog(@"---%zd",self.page.currentPage);
    if (_headViewBlock) {
        _headViewBlock(self.arr[self.page.currentPage],self.arr2[self.page.currentPage]);

    }
}
#pragma mark - scrollview的代理方法
/**
 *  停止定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
    
}

- (void)nextPage:(NSTimer *)timer
{
    //    NSLog(@"nextPage--%@",timer.userInfo);
    // 计算下一页的页码
    NSInteger page = self.page.currentPage + 1;
    
    // 超过最后一页
    if (page == _urlArrM.count) {
        page = 0;
    }
    
    // 滚到下一页
    [self.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width, 0) animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    计算页码
    NSInteger num = (int)(scrollView.contentOffset.x / screenW + 0.5);
    self.page.currentPage = num;
}
//开始拖拽的时候
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
//停止拖拽的时候停止
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self start];
}

@end
