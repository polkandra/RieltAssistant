//
//  MapAnnotation.h
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 07.06.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NewObjectViewController.h"
#import "AppDelegate.h"

@interface MapAnnotation :  MKAnnotationView <MKAnnotation>


@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *subtitle;
@property(nonatomic,strong) UIImageView *pinImage;





@end
