//
//  MeetingObjectEntity+CoreDataProperties.m
//  RieltAssistant
//
//  Created by Mikhail Kozlyukov on 30.10.2017.
//  Copyright © 2017 Chebahatt. All rights reserved.
//
//

#import "MeetingObjectEntity+CoreDataProperties.h"

@implementation MeetingObjectEntity (CoreDataProperties)

+ (NSFetchRequest<MeetingObjectEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MeetingObjectEntity"];
}

@dynamic date;
@dynamic dateAndTime;
@dynamic meetDetails;
@dynamic objectName;
@dynamic personName;
@dynamic phoneNumber;
@dynamic time;
@dynamic estateObject;

@end
