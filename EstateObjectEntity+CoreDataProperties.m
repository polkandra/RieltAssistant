//
//  EstateObjectEntity+CoreDataProperties.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 24.07.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "EstateObjectEntity+CoreDataProperties.h"

@implementation EstateObjectEntity (CoreDataProperties)

+ (NSFetchRequest<EstateObjectEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"EstateObjectEntity"];
}

@dynamic actionByProperty;
@dynamic address;
@dynamic arrayOfUsersPics;
@dynamic discription;
@dynamic kitchenArea;
@dynamic livingArea;
@dynamic owner;
@dynamic phoneNumber;
@dynamic picture;
@dynamic price;
@dynamic roomQuantity;
@dynamic typeOfProperty;
@dynamic wholeArea;
@dynamic meetings;

@end
