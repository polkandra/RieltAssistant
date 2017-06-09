//
//  GoogleMapsVC.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 09.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "GoogleMapsVC.h"

@interface GoogleMapsVC ()
{
    GMSPlacesClient * placesClient;
}

@end

@implementation GoogleMapsVC
@synthesize searchBar, locationManager;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.delegate = self;
    self.mapView.delegate = self;
    
    // [self setLocationManager];
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];;
    [self.view addSubview:searchBar];
}



-(void)loadView {
    
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:55.7522200 longitude:37.6155600 zoom:14.0];
    
    
    
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
   
    
    self.mapView.myLocationEnabled = YES;
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    
    
    self.view = self.mapView;
    [self.mapView setMinZoom:10 maxZoom:30];

    UISearchBar *searchBar = [[UISearchBar alloc] init];;
    [self.mapView addSubview:searchBar];
 }


-(BOOL)prefersStatusBarHidden {
   return YES;
}



-(void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    self.mapView.padding = UIEdgeInsetsMake(self.topLayoutGuide.length + 5, 0, self.bottomLayoutGuide.length + 5, 0);
}




- (IBAction)searchPlace:(UIBarButtonItem *)sender {




}

- (IBAction)showAllObjects:(UIBarButtonItem *)sender {





}

#pragma mark -- GMSMapViewDelegate


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

}
    
    





@end
