//
//  GoogleMapsVC.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 09.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
@import GooglePlaces;


@interface GoogleMapsVC : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

- (IBAction)searchPlace:(UIBarButtonItem *)sender;
- (IBAction)showAllObjects:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic)  CLLocationManager *locationManager;

@property (strong, nonatomic)  GMSMapView *mapView;


@end
