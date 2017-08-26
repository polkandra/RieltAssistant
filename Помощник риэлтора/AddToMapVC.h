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
#import "NewObjectViewController.h"
#import "StyleKitName.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "DataManager.h"

@import GooglePlaces;
@interface AddToMapVC : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>


- (IBAction)searchPlace:(UIBarButtonItem *)sender;
- (IBAction)showAllObjects:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) HNKGooglePlacesAutocompleteQuery *searchQuery;
//@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@property(strong, nonatomic) EstateObjectEntity *object;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic)  CLLocationManager* locationManager;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSArray *pinPhotosArray;
@property (strong, nonatomic) NSArray *retrievedArray;

@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *subTitleText;


@end
