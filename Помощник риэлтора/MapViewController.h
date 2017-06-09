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
#import "MapAnnotation.h"



@interface MapViewController :UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic)  CLLocationManager *locationManager;

- (IBAction)showAllObjects:(UIBarButtonItem *)sender;

@end
