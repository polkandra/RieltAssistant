//
//  TabBarViewController.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 20.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MapViewController :UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic)  CLLocationManager *locationManager;
@property (strong, nonatomic)  CLGeocoder *geocoder;
@property (strong, nonatomic)  CLPlacemark *placemark;

@end
