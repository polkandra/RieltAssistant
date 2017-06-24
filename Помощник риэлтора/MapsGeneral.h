//
//  GoogleMapsVC.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 09.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <HNKGooglePlacesAutocomplete/HNKGooglePlacesAutocomplete.h>
#import "MapAnnotation.h"
#import <MapKit/MapKit.h>
#import "CLPlacemark+HNKAdditions.h"
@import GooglePlaces;


@interface MapsGeneral : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>


- (IBAction)searchPlace:(UIBarButtonItem *)sender;
- (IBAction)showAllObjects:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) HNKGooglePlacesAutocompleteQuery *searchQuery;

//@property (strong, nonatomic) IBOutlet GMSMapView *mapView;


@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *searchResults;

@property (strong, nonatomic)  CLLocationManager *locationManager;




@end
