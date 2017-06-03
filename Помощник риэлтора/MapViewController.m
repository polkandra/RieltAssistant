//
//  TabBarViewController.m
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 20.03.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MapViewController.h"



@interface MapViewController ()


@end

@implementation MapViewController
@synthesize mapView, geocoder, placemark, locationManager;





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
   

    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];

}




#pragma mark - MKMapViewDelegate




/*-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
    [self.locationManager stopUpdatingLocation];
    CGFloat usersLatitude = self.locationManager.location.coordinate.latitude;
    CGFloat usersLongidute = self.locationManager.location.coordinate.longitude;

    
}
    
- (IBAction)statrtGettingLocation:(id)sender {
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //Remember your pList needs to be configured to include the location persmission - adding the display message  (NSLocationWhenInUseUsageDescription)
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
   
}*/




@end
