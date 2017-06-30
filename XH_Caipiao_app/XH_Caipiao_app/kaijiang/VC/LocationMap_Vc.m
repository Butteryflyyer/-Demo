//
//  LocationMap_Vc.m
//  XH_Caipiao_app
//
//  Created by 信昊 on 17/6/27.
//  Copyright © 2017年 xinhao. All rights reserved.
//

#import "LocationMap_Vc.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
@interface LocationMap_Vc ()<MAMapViewDelegate>

@property(nonatomic,strong)MAMapView *mapView;

@end

@implementation LocationMap_Vc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavBarTitle:self.name_title];
    
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate =self;
    ///把地图添加至view
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    self.mapView.showsUserLocation = YES;
    
    self.mapView.zoomLevel = 13;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.view addSubview:self.mapView];
    
//  MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
//    
//    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
//    
//    r.showsHeadingIndicator = NO;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
//    
//    r.fillColor = [UIColor redColor];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
//    r.strokeColor = [UIColor blueColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
//    r.lineWidth = 2;///精度圈 边线宽度，默认0
//    r.enablePulseAnnimation = NO;///内部蓝色圆点是否使用律动效果, 默认YES
//    r.locationDotBgColor = [UIColor greenColor];///定位点背景色，不设置默认白色
//    r.locationDotFillColor = [UIColor grayColor];///定位点蓝色圆点颜色，不设置默认蓝色
//    [self.mapView updateUserLocationRepresentation:r];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longtitude);
    pointAnnotation.title = self.name_title;
    pointAnnotation.subtitle = self.distance;
    
    [_mapView addAnnotation:pointAnnotation];
    
    // Do any additional setup after loading the view.
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
