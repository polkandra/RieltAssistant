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

@interface MapTab : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic)  CLLocationManager *locationManager;

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
