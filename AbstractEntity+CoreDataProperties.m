//
//  AbstractEntity+CoreDataProperties.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 30.10.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//

#import "AbstractEntity+CoreDataProperties.h"

@implementation AbstractEntity (CoreDataProperties)

+ (NSFetchRequest<AbstractEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AbstractEntity"];
}


@end
