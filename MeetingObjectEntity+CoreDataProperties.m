//
//  MeetingObjectEntity+CoreDataProperties.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 24.07.17.
//  Copyright © 2017 Chebahatt. All rights reserved.
//

#import "MeetingObjectEntity+CoreDataProperties.h"

@implementation MeetingObjectEntity (CoreDataProperties)

+ (NSFetchRequest<MeetingObjectEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MeetingObjectEntity"];
}

@dynamic date;
@dynamic dateAndTime;
@dynamic objectName;
@dynamic personName;
@dynamic phoneNumber;
@dynamic time;
@dynamic estateObjects;

@end
