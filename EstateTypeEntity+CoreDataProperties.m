//
//  EstateTypeEntity+CoreDataProperties.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//

#import "EstateTypeEntity+CoreDataProperties.h"

@implementation EstateTypeEntity (CoreDataProperties)

+ (NSFetchRequest<EstateTypeEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"EstateTypeEntity"];
}

@dynamic earth;
@dynamic flat;
@dynamic house;
@dynamic nonLiving;
@dynamic room;
@dynamic estateObjects;

@end
