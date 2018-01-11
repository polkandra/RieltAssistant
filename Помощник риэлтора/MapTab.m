//
//  AddPlaceToMapController.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 07.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MapTab.h"

@interface MapTab ()

@end

@implementation MapTab
@synthesize mapView, locationManager, detailItem, searchBar, tableView;


#pragma mark VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.searchBar.tintColor = [StyleKitName gradientColor52];
    self.searchBar.delegate = self;
   
    self.searchQuery = [HNKGooglePlacesAutocompleteQuery sharedQuery];
    
    self.tableView.hidden = YES;
    
    [self setLocationManager];
    //[self getAnnotations];
    
    self.annotationsArray = [[NSMutableArray alloc] init];
    

}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self setNavigationController];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self getAnnotations];
    // [self fetchPhotosArray];
   
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    NSMutableArray *toDelete = [NSMutableArray array];
    for (MapAnnotation *annotations in self.annotationsArray) {
        [toDelete addObject:annotations];
    }
    
    [self.annotationsArray removeObjectsInArray:toDelete];
}


#pragma mark Helpers


/*-(void)fetchPhotosArray {
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    self.retrievedArray = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
    NSArray *retrievedArray = [NSKeyedUnarchiver unarchiveObjectWithData:detailItem.arrayOfUsersPics];
    self.pinPhotosArray = [[NSMutableArray alloc] initWithArray:retrievedArray];
 
    NSMutableArray *fetchedArrayWithUsersPics = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData*)(detailItem.globalPictureArray)];
    self.pinPhotosArray = [[NSMutableArray alloc] initWithArray:fetchedArrayWithUsersPics];
 
}*/




-(void)getAnnotations {
    
    //  Fetching specific properties of entity (latitude, longtitude and so on);
   
    NSEntityDescription *entity = [NSEntityDescription  entityForName:@"EstateObjectEntity" inManagedObjectContext:[[DataManager sharedManager] managedObjectContext]];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    [request setReturnsDistinctResults:YES];
    [request setPropertiesToFetch:@[@"longitude", @"latitude", @"picture", @"discription", @"price", @"actionByProperty", @"address", @"kitchenArea", @"livingArea", @"owner", @"phoneNumber", @"roomQuantity", @"typeOfProperty", @"wholeArea"]];
    
    NSError *error;
    
    self.fetchedData = [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:request error:&error];
    
    if (self.fetchedData == nil) {
        
    }
    
    for (NSDictionary *location in self.fetchedData) {
        
        MapAnnotation *annotation = [[MapAnnotation alloc] init];
        
        CLLocationCoordinate2D  point;
        point.latitude  = [location[@"latitude"] doubleValue];
        point.longitude = [location[@"longitude"] doubleValue];
        annotation.pinImage = [[UIImage alloc] initWithData:location[@"picture"]];
        annotation.coordinate = point;
        annotation.title = location[@"discription"];
        annotation.subtitle = location[@"price"];
       
        [self.annotationsArray addObject:annotation];
        [self.mapView addAnnotation:(id)annotation];
    
    }
  
}


-(void)setLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
}



#pragma mark - Actions


- (IBAction)showAllObjects:(UIBarButtonItem *)sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annotation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(location);
        static double delta = 20000;
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(50, 50, 50, 50)
                           animated:YES];
    
}


#pragma mark - UITableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchResults.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"autocompleteCell2" forIndexPath:indexPath];
    HNKGooglePlacesAutocompletePlace *thisPlace = self.searchResults[indexPath.row];
    cell.textLabel.text = thisPlace.name;
    return cell;
}


#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    
    HNKGooglePlacesAutocompletePlace *selectedPlace = self.searchResults[indexPath.row];
    
    [CLPlacemark hnk_placemarkFromGooglePlace: selectedPlace
                                       apiKey:@"AIzaSyAh4GgFn_mdwKvfOzhPNxxnU7UERxIMIIM"
                                   completion:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
                                       if (placemark) {
                                           [self.tableView setHidden: YES];
                                           
                                           //uncomment to be able after selecting row in search results go to place and put a placemark.
                                           
                                           // [self addPlacemarkAnnotationToMap:placemark addressString:addressString];
                                           
                                           [self recenterMapToPlacemark:placemark];
                                           [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
                                       }
                                   }];
}




#pragma mark - UISearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar {
    [searchBar resignFirstResponder];
    
}


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:YES animated:YES];
}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length > 0) {
        self.tableView.hidden = NO;
        [self.searchQuery fetchPlacesForSearchQuery: searchText
                                         completion:^(NSArray *places, NSError *error) {
                                             if (error) {
                                                 NSLog(@"ERROR: %@", error);
                                                 [self handleSearchError:error];
                                             } else {
                                                 self.searchResults = places;
                                                 [self.mapView addSubview:self.tableView];
                                                 [self.tableView reloadData];
                                             }
                                         }];
    }else{
        
        self.tableView.hidden = YES;
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.text = @"";
    
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.tableView setHidden:YES];
}




#pragma mark - MKMapViewDelegate


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }

    static NSString *identifier = @"Annotation";
    
    MKPinAnnotationView *pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
       
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier ];
        pin.pinTintColor = [UIColor greenColor];
        pin.animatesDrop = YES;
        pin.canShowCallout = YES;
        pin.draggable = NO;
     
        UIImageView *userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
        userAvatar.contentMode = UIViewContentModeScaleAspectFill;
        userAvatar.layer.cornerRadius = 4.0;
        userAvatar.layer.masksToBounds = YES;
        userAvatar.layer.borderColor = [[UIColor whiteColor] CGColor];
        userAvatar.layer.borderWidth = 1;
        pin.leftCalloutAccessoryView = userAvatar;
        
        UIButton *buttonPic = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //buttonPic.frame = CGRectMake(0, 0, 55, 55);
        //buttonPic.backgroundColor = [UIColor purpleColor];
       // [buttonPic addTarget:self action:@selector(goToDetail) forControlEvents:UIControlEventTouchUpInside];
       // UIImage *btnImage = [UIImage imageNamed:@"inArrow"];
        //[buttonPic setImage:btnImage forState:UIControlStateNormal];
        pin.rightCalloutAccessoryView = buttonPic;
        
    }else{
        pin.annotation = annotation;
    }
    
    MapAnnotation *mvAnn = (MapAnnotation *)annotation;
    [(UIImageView*)(pin.leftCalloutAccessoryView) setImage:mvAnn.pinImage];
    
    return pin;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    DetailObjectController *doVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailObjectController"];
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    self.retrievedArray = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    for (id object in self.retrievedArray) {
        if ([object isKindOfClass:[EstateObjectEntity class]]) {
            self.detailItem = ((EstateObjectEntity *)object);
        }
    }
    
    MapAnnotation *annotation =(id)view.annotation;
    NSInteger index = [self.annotationsArray indexOfObject:annotation];
    EstateObjectEntity *selectedEntity = [self.retrievedArray objectAtIndex:index];
    doVC.detailItem = selectedEntity;
   
    doVC.navigationItem.hidesBackButton = YES;
    doVC.navigationItem.leftBarButtonItem = nil;
    doVC.navigationItem.rightBarButtonItem = nil;
    //doVC.shareBarButtonItem = nil;
    
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
    
    [self setImageForButton:flipButton];
    
    doVC.navigationItem.leftBarButtonItem = flipButton;
    
    [self.navigationController pushViewController:doVC animated:YES];

}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {

  /*  MapAnnotation *annotation = (MapAnnotation *)annotation;
    NSInteger *myIndex = annotation.myIndex;
    NSLog(@"index of pin is %d",myIndex);*/
    
}


#pragma mark - helpers

- (void)recenterMapToPlacemark:(CLPlacemark *)placemark {
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    region.span = span;
    region.center = placemark.location.coordinate;
    
    [self.mapView setRegion:region animated:YES];
}



- (void)handleSearchError:(NSError *)error {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}



-(void)dismissView {

    [self.navigationController popViewControllerAnimated:YES];
}


- (void) dismissKeyboard {
    [self.view endEditing:YES];
}


-(void)setNavigationController {
    
    [self.navigationController.navigationBar setBarTintColor:[StyleKitName gradientColor52]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    [self.navigationItem setTitle:@"Мои  объекты"];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"BloggerSans" size:23]}];
    
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
    } else {
        // Fallback on earlier versions
    }
  
}

- (void)setImageForButton:(UIBarButtonItem *)flipButton {
    UIImage* imageBack = [UIImage imageNamed:@"back"];
    CGRect frameimg = CGRectMake(0, 0, imageBack.size.width, imageBack.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:imageBack forState:UIControlStateNormal];
    [someButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
    [flipButton initWithCustomView:someButton];
}

@end
