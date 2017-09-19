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

@interface MapTab : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic)  CLLocationManager *locationManager;

@property(strong, nonatomic) EstateObjectEntity *detailItem;

@property (strong, nonatomic) NSMutableArray *pinPhotosArray;

- (IBAction)showAllObjects:(UIBarButtonItem *)sender;


@end
