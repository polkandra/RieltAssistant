//
//  EstateObjectEntity+CoreDataProperties.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
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
@dynamic meetingObjects;
@dynamic objectType;
@dynamic actionType;

@end
