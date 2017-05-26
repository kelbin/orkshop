//
//  MapController.m
//  OrkShoper
//
//  Created by Келбин on 14.05.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import "MapController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapController () <CLLocationManagerDelegate> {
    
    GMSMapView *mapView;
    CLLocation *location;
}

@end

@implementation MapController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLocation];
    [self GoogleMap];
    [self mylocation];
    [self firstmarket];
    [self secondmarket];
    [self thirdmarket];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated] ;
    [mapView clear];
    [mapView removeFromSuperview] ;
    mapView = nil ;
}


-(void)getLocation {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    [_locationManager requestWhenInUseAuthorization];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    [_locationManager startUpdatingLocation];
    location = [_locationManager location];
    NSLog(@"%f",location.coordinate.latitude);
}


-(void)GoogleMap {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
                                                            longitude:location.coordinate.longitude
                                                                 zoom:6];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.settings.scrollGestures = YES;
    mapView.settings.zoomGestures = YES;
    self.view = mapView;
}


-(void)firstmarket {
    GMSMarker *marker1 = [[GMSMarker alloc] init];
    marker1.position = CLLocationCoordinate2DMake(54.532373, 36.271735);
    marker1.title = @"Лавка Орка";
    marker1.snippet = @"Ул. Глаголева 5 +74842750875";
    marker1.map = mapView;
}


-(void)secondmarket {
    GMSMarker *marker2 = [[GMSMarker alloc] init];
    marker2.position = CLLocationCoordinate2DMake(52.590394, 39.617371);
    marker2.title = @"Лавка Орка";
    marker2.snippet = @"Мира ПЛ, 3 +74842551255";
    marker2.map = mapView;
}


-(void)thirdmarket {
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = CLLocationCoordinate2DMake(54.513283, 36.256534);
    marker3.title = @"Лавка Орка";
    marker3.snippet = @"Ул. Театральная, 4В +74842795517, +74842533688, +79534630980, +79105222640";
    marker3.map = mapView;
}


-(void)mylocation {
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    marker3.title = @"Я";
    marker3.map = mapView;
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
