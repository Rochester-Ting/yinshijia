//
//  RRAnnotation.h
//  MapKit框架练习
//
//  Created by 丁瑞瑞 on 10/3/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface RRAnnotation : NSObject<MKAnnotation>
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end
