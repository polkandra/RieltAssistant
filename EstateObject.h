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

@property(strong,nonatomic) NSString* discription;
@property(strong,nonatomic) NSString* price;
@property(strong, nonatomic) UIImageView* picture;
@property(strong, nonatomic) NSString* address;
@property(strong, nonatomic) NSString* owner;

@property(strong, nonatomic) NSString* estateType;
@property(strong, nonatomic) NSString* typeOfActionByEstate;


@end
