//
//  GoogleMapsVC.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 09.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "AddToMapVC.h"

@interface AddToMapVC ()


@end

@implementation AddToMapVC
@synthesize searchBar, mapView, tableView, searchResults, detailItem, latitude, longitude, lpgr;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = YES;
    
    mapView.zoomEnabled = YES;
    self.mapView.showsUserLocation = YES;
      
    self.searchQuery = [HNKGooglePlacesAutocompleteQuery sharedQuery];
   // self.searchResults = [[NSMutableArray alloc] init];
    
    [self.locationManager requestWhenInUseAuthorization];
    [self setLocationManager];
  //  [self setMKUserTrackingButton];
    //[self setGestureRecognizers];
   
    /* GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:55.7522200 longitude:37.6155600 zoom:10.0];
    self.mapView = [GMSMapView mapWithFrame:CGRectMake(0, 108, 375, 560) camera:camera];
    self.mapView.delegate = self;
    self.mapView.myLocationEnabled = YES;
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    [self.mapView animateToLocation: self.mapView.myLocation.coordinate];
    self.mapView.camera = camera;
    [self.view addSubview:self.mapView];*/

    self.lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5;
    lpgr.cancelsTouchesInView = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    [self.mapView addGestureRecognizer:lpgr];
    

    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self fetchPhotosArray];
}


-(void)fetchPhotosArray {
    
    // NSError *error;
    //NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
    // self.retrievedArray = [[[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:&error] mutableCopy];
    NSMutableArray *retrievedArray = [NSKeyedUnarchiver unarchiveObjectWithData:detailItem.arrayOfUsersPics];
    self.pinPhotosArray = [[NSMutableArray alloc] initWithArray:retrievedArray];
    
    
}





#pragma mark - UITableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.searchResults.count;
   
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"autocompleteCell" forIndexPath:indexPath];
    
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
        
        [self.tableView setHidden:NO];
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


#pragma mark Helpers




/*-(void)setMKUserTrackingButton {
    
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    self.navigationItem.rightBarButtonItem = buttonItem;
}*/


- (void)handleSearchError:(NSError *)error {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}



/*- (void)addPlacemarkAnnotationToMap:(CLPlacemark *)placemark addressString:(NSString *)address
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = placemark.location.coordinate;
    annotation.title = address;
    
    
    [self.mapView addAnnotation:annotation];
}*/






- (void)recenterMapToPlacemark:(CLPlacemark *)placemark
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.02;
    span.longitudeDelta = 0.02;
    
    region.span = span;
    region.center = placemark.location.coordinate;
    
   
    [self.mapView setRegion:region animated:YES];
}







-(void)setLocationManager {
   
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
   
    
    [_locationManager startUpdatingLocation];
   
}


/*-(void)setGestureRecognizers {
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5;
    lpgr.cancelsTouchesInView = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    [self.mapView addGestureRecognizer:lpgr];
    
}*/




-(void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    self.touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    
    MapAnnotation *annotation = [[MapAnnotation alloc] init];
  
    
    annotation.canShowCallout = YES;
    annotation.coordinate = _touchMapCoordinate;
   
    NSLog(@"pins coordinates are %f  %f",_touchMapCoordinate.latitude,_touchMapCoordinate.longitude);
    
   
    annotation.image = [[UIImage alloc] initWithData:[detailItem valueForKey:@"picture"]];
    annotation.title = [detailItem valueForKey:@"discription"];
    annotation.subtitle = [detailItem valueForKey:@"price"];
    
   
    
    MKAnnotationView *pinView = nil;
    
    NSInteger toRemoveCount = self.mapView.annotations.count;
    NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
    
    for (id annotation in self.mapView.annotations)
        if (annotation != self.mapView.userLocation)
    
    [toRemove addObject:annotation];
    [self.mapView removeAnnotations:toRemove];
    
    [self.mapView addAnnotation:annotation];
        
   
    
    
    
    
  /*
    // share data through TabBarController
    
    MapTab *myVc = (MapTab*) [[(UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:1] viewControllers] objectAtIndex:0];
    myVc.detailItem = self.detailItem;
    
   
    
    
    
    [[[DataManager sharedManager] managedObjectContext] save:nil];*/


}


- (void) dismissKeyboard {
    
    
    [self.searchBar resignFirstResponder];
}






#pragma mark  MKMapViewDelegate


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
    
    if (newState == MKAnnotationViewDragStateEnding) {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        MKMapPoint point = MKMapPointForCoordinate(droppedAt);
        
        NSLog(@"dragged coordinates %f  %f",droppedAt.longitude,droppedAt.latitude);
        
        [annotationView.annotation setCoordinate:droppedAt];
    }
   
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
    }
    
    
    else if ([annotation isKindOfClass:[MapAnnotation class]]) {
        
        static NSString *identifier = @"Annotation";
        
        
        MKPinAnnotationView *pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];;
        
        
        if (!pin) {
            pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier ];
            pin.pinTintColor = [UIColor purpleColor];
            pin.animatesDrop = YES;
            pin.canShowCallout = YES;
            pin.draggable = YES;
          //  pin.image =  [[UIImage alloc] initWithData:[detailItem valueForKey:@"picture"]];
           
            UIImageView *userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
            
            if (self.pinPhotosArray.count == 0) {
                
                userAvatar.image = [UIImage imageNamed:@"nophoto"];
                
            }else{
                
                userAvatar.image = [self.pinPhotosArray firstObject];
            }
            
           // UIButton *buttonPic = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            //buttonPic.backgroundColor = [UIColor purpleColor];
           // [buttonPic addTarget:self action:@selector(goToDetail) forControlEvents:UIControlEventTouchUpInside];
           
            // UIButton *buttonPic = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            // buttonPic.frame = CGRectMake(0, 0, 23, 23);
           // UIImage *btnImage = [UIImage imageNamed:@"inArrow"];
            //[buttonPic setImage:btnImage forState:UIControlStateNormal];
            
            pin.leftCalloutAccessoryView = userAvatar;
          //  pin.rightCalloutAccessoryView = buttonPic;
            
            userAvatar.contentMode = UIViewContentModeScaleAspectFill;
            userAvatar.layer.cornerRadius = 4.0;
            userAvatar.layer.masksToBounds = YES;
            userAvatar.layer.borderColor = [[UIColor whiteColor] CGColor];
            userAvatar.layer.borderWidth = 1;
            
            
        }else{
            
            pin.annotation = annotation;
            
        }
        
        return pin;
        
        
    }
    

       /* MKAnnotationView *annotationView = (MKAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        //Lazy instantation
        if (!annotationView) {
            
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            
           // annotationView.image = [self.pinPhotosArray firstObject];;

            annotationView.centerOffset = CGPointMake(0, annotationView.frame.size.height / 2);
            annotationView.canShowCallout = YES;
            annotationView.enabled = YES;
            annotationView.draggable = YES;
            
        UIImageView *userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
        
        if (self.pinPhotosArray.count == 0) {
            
            userAvatar.image = [UIImage imageNamed:@"nophoto"];
                
            }else{
                
                userAvatar.image = [self.pinPhotosArray firstObject];
            }
            
            UIButton *buttonPic = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
            //buttonPic.backgroundColor = [UIColor purpleColor];
            UIImage *btnImage = [UIImage imageNamed:@"playArrow"];
            [buttonPic setImage:btnImage forState:UIControlStateNormal];
            
            annotationView.leftCalloutAccessoryView = userAvatar;
            annotationView.rightCalloutAccessoryView = buttonPic;
            
            userAvatar.contentMode = UIViewContentModeScaleAspectFill;
            userAvatar.layer.cornerRadius = 4.0;
            userAvatar.layer.masksToBounds = YES;
            userAvatar.layer.borderColor = [[UIColor whiteColor] CGColor];
            userAvatar.layer.borderWidth = 1;
            
            
        } else {
            
            annotationView.annotation = annotation;
            
        }
        
        return annotationView;
        
    }*/

    return nil;

}






/*- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    
}*/




#pragma mark - CLLocationManagerDelegate


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = locations.lastObject;
}


/*- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
 {
 NSLog(@"didUpdateToLocation: %@", newLocation);
 CLLocation *newLocation = locations.lastObject;
 
 }*/


#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"saveFromAddToMapVC"]) {
   
        //CGPoint touchPoint = [lpgr locationInView:self.mapView];
       // CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
       
        NSLog(@"pins coordinates are %f  %f",_touchMapCoordinate.latitude,_touchMapCoordinate.longitude);
        
        if (self.detailItem) {
            
            [detailItem setValue:[NSNumber numberWithDouble:_touchMapCoordinate.latitude] forKey:@"latitude"];
            [detailItem setValue:[NSNumber numberWithDouble:_touchMapCoordinate.longitude] forKey:@"longitude"];
            
        }
        
       [[[DataManager sharedManager] managedObjectContext] save:nil];
        
        MapTab *mtVc = (MapTab*) [[(UINavigationController*)[[self.tabBarController viewControllers] objectAtIndex:1] viewControllers] objectAtIndex:0];
        mtVc.detailItem = self.detailItem;
        mtVc.pinPhotosArray = [[NSMutableArray alloc] init];
        mtVc.pinPhotosArray = self.pinPhotosArray;
        
              
        
      
    
    }
    
}

@end
