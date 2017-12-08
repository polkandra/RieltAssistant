//
//  EstateObject.h
//  Помощник риэлтора
//
//  Created by Mikhail Kozlyukov on 01.04.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EstateObject : NSObject


@property(strong, nonatomic) NSString* phoneNumber;
@property(strong,nonatomic) NSString* discription;
@property(strong,nonatomic) NSString* price;
@property(strong, nonatomic) NSString* address;
@property(strong, nonatomic) NSString* owner;
@property(strong, nonatomic) NSString* typeOfProperty;
@property(strong, nonatomic) NSString* actionByProperty;
@property(strong, nonatomic) NSString* roomQuantity;
@property(strong, nonatomic) NSString* wholeArea;
@property(strong, nonatomic) NSString* livingArea;
@property(strong, nonatomic) NSString* kitchenArea;
@property(assign, nonatomic) BOOL isActive;

@property(assign, nonatomic) double latitude;
@property(assign, nonatomic) double longtitude;

@property(strong, nonatomic) NSData* picture;


@end



