//
//  MapController.h
//  OrkShoper
//
//  Created by Келбин on 14.05.17.
//  Copyright © 2017 Келбин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocation.h>

@interface MapController : UIViewController <CLLocationManagerDelegate>


@property (nonatomic, retain) CLLocationManager *locationManager;


@end
