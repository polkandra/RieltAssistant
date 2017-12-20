//
//  AddPlaceToMapController.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 07.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotation.h"
#import "DataManager.h"
#import "EstateObjectEntity+CoreDataProperties.h"
#import "EstateObject.h"
#import "DetailObjectController.h"
#import <HNKGooglePlacesAutocomplete/HNKGooglePlacesAutocomplete.h>
#import "CLPlacemark+HNKAdditions.h"
#import "StyleKitName.h"

@interface MapTab : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate, UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) HNKGooglePlacesAutocompleteQuery *searchQuery;
@property (strong, nonatomic)  CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *searchResults;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property(strong, nonatomic) EstateObjectEntity *detailItem;
@property (assign)  int pinTag;

@property(strong, nonatomic) NSMutableArray* annotationsArray;
@property (strong, nonatomic) NSArray *pinPhotosArray;
@property(strong, nonatomic) NSArray* fetchedData;
@property(strong, nonatomic) NSMutableArray* coordinatesArray;
@property(strong, nonatomic) NSArray *retrievedArray;

@property(strong, nonatomic) NSMutableArray* photoFromDictionary;

- (IBAction)showAllObjects:(UIBarButtonItem *)sender;


@end
