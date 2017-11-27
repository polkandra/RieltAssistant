//
//  ActionTypeEntity+CoreDataProperties.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 26.11.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//

#import "ActionTypeEntity+CoreDataProperties.h"

@implementation ActionTypeEntity (CoreDataProperties)

+ (NSFetchRequest<ActionTypeEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ActionTypeEntity"];
}

@dynamic rent;
@dynamic sell;
@dynamic estateObject;

@end
