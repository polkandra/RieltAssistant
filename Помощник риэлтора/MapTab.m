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
@synthesize mapView, locationManager, detailItem;


#pragma mark VC Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    [self setLocationManager];
    //[self getAnnotations];
    
    self.annotationsArray = [[NSMutableArray alloc] init];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self getAnnotations];
    // [self fetchPhotosArray];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    } else {
    
  }
    
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
        [self.mapView addAnnotation:annotation];
    
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
    
    MapAnnotation *annotation = view.annotation;
    NSInteger index = [self.annotationsArray indexOfObject:annotation];
    EstateObjectEntity *selectedEntity = [self.retrievedArray objectAtIndex:index];
    doVC.detailItem = selectedEntity;
   
    doVC.navigationItem.hidesBackButton = YES;
    doVC.navigationItem.leftBarButtonItem = nil;
    doVC.navigationItem.rightBarButtonItem = nil;
    //doVC.shareBarButtonItem = nil;
    
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Вернуться" style:UIBarButtonItemStylePlain target:self action:@selector(dismissView)];
    
    doVC.navigationItem.rightBarButtonItem = flipButton;
    
    [self.navigationController pushViewController:doVC animated:YES];

}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {

  /*  MapAnnotation *annotation = (MapAnnotation *)annotation;
    NSInteger *myIndex = annotation.myIndex;
    NSLog(@"index of pin is %d",myIndex);*/
    
}


#pragma mark - helpers


-(void)dismissView {

    [self.navigationController popViewControllerAnimated:YES];
}


- (void) dismissKeyboard {
    [self.view endEditing:YES];
}


@end
