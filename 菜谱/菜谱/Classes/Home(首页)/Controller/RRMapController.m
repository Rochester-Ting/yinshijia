//
//  RRMapController.m
//  菜谱
//
//  Created by 丁瑞瑞 on 10/4/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRMapController.h"
#import <MapKit/MapKit.h>
#import "RRAnnotation.h"
#import <CoreLocation/CoreLocation.h>
@interface RRMapController ()<CLLocationManagerDelegate,MKMapViewDelegate>
@property (nonatomic,strong) CLLocationManager *manager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) CLGeocoder *geoC;
/** <#注释#>*/
@property (nonatomic,strong) CLPlacemark *gzp;
/** ns*/
@property (nonatomic,strong) CLPlacemark *shp;
@end

@implementation RRMapController
#pragma mark - 懒加载
- (CLLocationManager *)manager{
    if (!_manager) {
        //        创建一个定位管理者
        _manager = [[CLLocationManager alloc] init];
        //        设置精度
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        //        设置代理
        _manager.delegate = self;
        //        判断系统
        if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
            //            请求授权
            [_manager requestAlwaysAuthorization];
        }
        if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
//            _manager.allowsBackgroundLocationUpdates = YES;
        }
    }
    return _manager;
    
}
-(CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    开始调用
    [self.manager startUpdatingLocation];
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
}
//请求位置的时候调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
//    NSLog(@"请求位置!");
    CLLocation *loc = locations.lastObject;
    
    [self.manager stopUpdatingHeading];
    [self.geoC reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (!error) {
            CLPlacemark *mark = placemarks.firstObject;
//            NSLog(@"%@",mark.name);
            
            [self.geoC geocodeAddressString:mark.name completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                // 广州地标
                CLPlacemark *gzP = [placemarks firstObject];
                [self.geoC geocodeAddressString:_mudidi completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                    // 上海地标
                    CLPlacemark *shP = [placemarks firstObject];
                    self.gzp = gzP;
                    self.shp = shP;
                    
                    
                }];
                
            }];
        }
        
    }];

}
#pragma mark - delegate
//更新用户的位置,并使地图以用户为中心展示
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //    设置大头针title
    userLocation.title = @"ruirui";
    //    设置大头针的subtitle
    userLocation.subtitle = @"rochester";
    //    计算跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.003, 0.003);
    
    //    设置地图展示的区域
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [self.mapView setRegion:region animated:YES];
}
//跨度改变的时候调用
-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //    调整好以后就可以看到想要的纬度跨度和精度跨度
    NSLog(@"%f---%f---",mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta);
}

- (void)startNavWithBeginPL :(CLPlacemark *)beginPL endPL :(CLPlacemark *)endPL
{
    /**
     *  使用系统的app,进行导航
     * // 告诉系统起点和终点, 然后还要告诉系统导航方式:步行,驾驶,公交, 设置系统的地图显示样式
     *  @param NSArray 系统起点和终点
     *  launchOptions : 然后还要告诉系统导航方式:步行,驾驶,公交, 设置系统的地图显示样式
     */
    
    // 创建起点地图项和终点地图项
    //    CLPlacemark
    
    MKPlacemark *bPL = [[MKPlacemark alloc] initWithPlacemark:beginPL];
    MKMapItem *bI = [[MKMapItem alloc] initWithPlacemark:bPL];
    
    
    
    MKPlacemark *ePL = [[MKPlacemark alloc] initWithPlacemark:endPL];
    MKMapItem *eI = [[MKMapItem alloc] initWithPlacemark:ePL];
    
    
    
    NSArray *items = @[bI, eI];
    
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving, // 设置导航方式
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeHybridFlyover) , // 设置地图样式
                          MKLaunchOptionsShowsTrafficKey : @(YES) //是否显示交通
                          
                          };
    [MKMapItem openMapsWithItems:items launchOptions:dic];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)daohang:(id)sender {
    [self startNavWithBeginPL:self.gzp endPL:self.shp];
}



//更改权限的时候调用
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"用户没有做出选择!");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"受到限制!");
            break;
        case kCLAuthorizationStatusDenied:
            //            判断是否开启了定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"用户拒绝开启");
                //                打开设置界面
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                //                判断是否能打开设置界面
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }else {
                NSLog(@"用户未开启定位服务!");
            }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"获取前后台的权限!");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"获取前台权限!");
            break;
        default:
            break;
    }
}



@end
