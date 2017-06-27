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
@synthesize searchBar, mapView, tableView, searchResults;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.hidden = YES;
    
    mapView.zoomEnabled = YES;
    self.mapView.showsUserLocation = YES;
   
    
   
    self.searchQuery = [HNKGooglePlacesAutocompleteQuery sharedQuery];
    
    [self.locationManager requestWhenInUseAuthorization];
    [self setLocationManager];
    [self setMKUserTrackingButton];
    [self setGestureRecognizers];
   
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
                                       apiKey:@"AIzaSyCxb6RE27AreKV3R7bDJ72qyJzN0sZkd7M"
                                   completion:^(CLPlacemark *placemark, NSString *addressString, NSError *error) {
                                       if (placemark) {
                                           [self.tableView setHidden: YES];
                                           //[self addPlacemarkAnnotationToMap:placemark addressString:addressString];
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


- (void) dismissKeyboard {
    
    
    [self.searchBar resignFirstResponder];
}



#pragma mark - Helpers



-(void)setMKUserTrackingButton {
    
    MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self.mapView];
    
    self.navigationItem.rightBarButtonItem = buttonItem;
}


- (void)handleSearchError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)addPlacemarkAnnotationToMap:(CLPlacemark *)placemark addressString:(NSString *)address
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = placemark.location.coordinate;
    annotation.title = address;
    
    
    [self.mapView addAnnotation:annotation];

    
    
}



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


-(void)setGestureRecognizers {
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0;
    lpgr .cancelsTouchesInView = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    [self.mapView addGestureRecognizer:lpgr];
    
}




-(void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
        
    }
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    MapAnnotation *annotation = [[MapAnnotation alloc] init];
  
    
    annotation.canShowCallout = YES;
    annotation.coordinate = touchMapCoordinate;
    annotation.image = [self.pinPhotosArray firstObject];
    annotation.title = self.titleText;
    annotation.subtitle = self.subTitleText;
    
    
    MKAnnotationView *pinView = nil;
   
    NSInteger toRemoveCount = self.mapView.annotations.count;
    NSMutableArray *toRemove = [NSMutableArray arrayWithCapacity:toRemoveCount];
    
    for (id annotation in self.mapView.annotations)
        if (annotation != self.mapView.userLocation)
            [toRemove addObject:annotation];
    [self.mapView removeAnnotations:toRemove];
    
    
    [self.mapView addAnnotation:annotation];
    
}



/*-(BOOL)prefersStatusBarHidden {
   
    return YES;
}



-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    self.mapView.padding = UIEdgeInsetsMake(self.topLayoutGuide.length + 5, 0, self.bottomLayoutGuide.length + 55, 0);
}*/


#pragma mark  Actions



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

/*#pragma mark -- GMSMapViewDelegate


-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    
    UIView *infoWindow = [[UIView alloc] init];
    infoWindow.frame = CGRectMake(0, 0, 170, 100);
    infoWindow.backgroundColor = [UIColor redColor];
    
    //UIImageView *backgroundImage = [UIImageView alloc]initWithImage:[UIImage imageNamed:@""];
   // [infoWindow addSubview:backgroundImage];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(14, 11, 175, 16);
    [infoWindow addSubview:titleLabel];
    titleLabel.text = marker.title;
    
    UILabel *snippetLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(14, 42, 300, 16);
    [infoWindow addSubview:snippetLabel];
    snippetLabel.text = marker.title;
    
    return  infoWindow;
    
}


-(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
   
    
    GMSMarker *marker = [GMSMarker markerWithPosition:coordinate];
    //marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
   // marker.icon = [UIImage imageNamed:@"emptyObject"];
    
    marker.draggable = YES;
    marker.map = self.mapView;

}

-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
//push to another VC here

}*/
    
    


//////////////////////////////////////////////////////////////////////////////////////////////



#pragma mark  MKMapViewDelegate


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        [annotationView.annotation setCoordinate:droppedAt];
    }
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
        return nil;
    }
    
    
    if ([annotation isKindOfClass:[MapAnnotation class]]) {
        
        static NSString *identifier = @"Annotation";
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        //Lazy instantation
        if (annotationView == nil) {
            
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
          
            annotationView.image = [UIImage imageNamed:@"house"];
            annotationView.centerOffset = CGPointMake(0, annotationView.frame.size.height / 2);
            annotationView.canShowCallout = YES;
            annotationView.enabled = YES;
            annotationView.draggable = YES;
            
            
            UIImageView *userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 47, 47)];
            
            if (self.pinPhotosArray.count ==0) {
                
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
        
    }
    
    return nil;
    
}




#pragma mark - CLLocationManagerDelegate


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = locations.lastObject;
}


/*- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
   CLLocation *newLocation = locations.lastObject;
    
}*/



@end
