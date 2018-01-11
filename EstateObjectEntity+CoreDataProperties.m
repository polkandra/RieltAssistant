//
//  EstateObjectEntity+CoreDataProperties.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 11.01.2018.
//  Copyright © 2018 Chebahatt. All rights reserved.
//
//

#import "EstateObjectEntity+CoreDataProperties.h"

@implementation EstateObjectEntity (CoreDataProperties)

+ (NSFetchRequest<EstateObjectEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
}

@dynamic actionByProperty;
@dynamic address;
@dynamic arrayOfUsersPics;
@dynamic detailInformation;
@dynamic discription;
@dynamic globalPictureArray;
@dynamic isActive;
@dynamic isLiked;
@dynamic kitchenArea;
@dynamic latitude;
@dynamic livingArea;
@dynamic longitude;
@dynamic owner;
@dynamic phoneNumber;
@dynamic picture;
@dynamic price;
@dynamic roomQuantity;
@dynamic typeOfProperty;
@dynamic wholeArea;
@dynamic city;
//@dynamic actionType;
@dynamic meetingObjects;
//@dynamic objectType;

@end
