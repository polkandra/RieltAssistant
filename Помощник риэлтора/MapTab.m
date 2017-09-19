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
   

}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self getAnnotations];
}



#pragma mark Helpers

-(void)getAnnotations {
    
    MapAnnotation *annotation = [[MapAnnotation alloc] init];
    
   // CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(detailItem.longitude, detailItem.latitude);
    
   // CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[detailItem valueForKey:@"latitude"] doubleValue], [[detailItem valueForKey:@"longitude"] doubleValue]);
   
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:detailItem.latitude longitude:detailItem.longitude];
    
    annotation.image =  [[UIImage alloc] initWithData:[detailItem valueForKey:@"picture"]];
    annotation.title = [detailItem valueForKey:@"discription"];
    annotation.subtitle = [detailItem valueForKey:@"price"];
    annotation.canShowCallout = YES;
    
   // annotation.coordinate = coordinate;
    annotation.coordinate = loc.coordinate;
    
    [self.mapView addAnnotation:annotation];
    
    //NSLog(@"MapTab pin coordinates are %f %f",coordinate.latitude, coordinate.latitude);
    NSLog(@"MapTab pin coordinates are %f %f",loc.coordinate.latitude, loc.coordinate.longitude);
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
    
    MKPinAnnotationView *pin = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];;
    
    
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier ];
        pin.pinTintColor = [UIColor greenColor];
        pin.animatesDrop = YES;
        pin.canShowCallout = YES;
        pin.draggable = NO;
        
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





@end
