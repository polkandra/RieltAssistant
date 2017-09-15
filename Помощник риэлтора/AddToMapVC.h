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
#import "MapTab.h"
#import "AppDelegate.h"


@import GooglePlaces;
@interface AddToMapVC : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate>



@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) HNKGooglePlacesAutocompleteQuery *searchQuery;
//@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@property(strong, nonatomic) EstateObjectEntity *detailItem;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic)  CLLocationManager* locationManager;


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UILongPressGestureRecognizer *lpgr;

@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSMutableArray *pinPhotosArray;
@property (strong, nonatomic) NSArray *retrievedArray;
@property (strong, nonatomic) NSMutableArray *coordinatesArray;

@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *subTitleText;


@property (assign, nonatomic) double longitude;
@property (assign, nonatomic) double latitude;

@end
